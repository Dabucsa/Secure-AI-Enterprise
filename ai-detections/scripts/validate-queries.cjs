// ============================================================================
// Offline validation of the analytics rule queries
// Parses and binds each query with the Kusto language service against the
// table schemas below, then checks that every column used by entity mappings
// and custom details exists in the query result, and that no ago() lookback
// is longer than the rule's queryPeriod.
//
// Usage: npm install && npm run validate
// ============================================================================

const fs = require('fs');
const path = require('path');
require('@kusto/language-service-next/bridge.js');
require('@kusto/language-service-next/Kusto.Language.Bridge.js');

const { GlobalState, KustoCode } = Kusto.Language;
const { TableSymbol, FunctionSymbol, DatabaseSymbol } = Kusto.Language.Symbols;

const root = path.join(__dirname, '..');

// Columns of the built-in tables used by the rules (subset of the real schemas)
const builtInTables = {
  SecurityAlert: 'TimeGenerated:datetime, AlertName:string, AlertSeverity:string, AlertType:string, ProductName:string, ProductComponentName:string, ExtendedProperties:string, ResourceId:string, Entities:string, CompromisedEntity:string',
  AzureActivity: 'TimeGenerated:datetime, OperationNameValue:string, ActivityStatusValue:string, Caller:string, CallerIpAddress:string, ResourceGroup:string, SubscriptionId:string, _ResourceId:string',
  AppMetrics: 'TimeGenerated:datetime, Name:string, Sum:real, ItemCount:int, Properties:dynamic, AppRoleName:string',
  DeviceNetworkEvents: 'TimeGenerated:datetime, Timestamp:datetime, DeviceName:string, RemoteUrl:string, RemoteIP:string, InitiatingProcessFileName:string, InitiatingProcessFolderPath:string, InitiatingProcessAccountName:string, InitiatingProcessCommandLine:string',
  DeviceProcessEvents: 'TimeGenerated:datetime, Timestamp:datetime, DeviceName:string, AccountName:string, FileName:string, ProcessCommandLine:string, InitiatingProcessFileName:string, InitiatingProcessCommandLine:string',
  UrlClickEvents: 'TimeGenerated:datetime, Timestamp:datetime, Url:string, ActionType:string, AccountUpn:string, IPAddress:string, IsClickedThrough:bool, Workload:string, UrlChain:string',
  CloudAppEvents: 'TimeGenerated:datetime, Timestamp:datetime, ActionType:string, Application:string, AccountDisplayName:string, AccountObjectId:string, AccountId:string, IPAddress:string, RawEventData:dynamic',
  AADServicePrincipalSignInLogs: 'TimeGenerated:datetime, AppId:string, ServicePrincipalName:string, ServicePrincipalId:string, IPAddress:string, ResourceDisplayName:string, ResultType:string',
};

// Custom tables come from the same schema files the Bicep templates use
for (const file of fs.readdirSync(path.join(root, 'schemas'))) {
  const columns = JSON.parse(fs.readFileSync(path.join(root, 'schemas', file), 'utf8'));
  builtInTables[path.basename(file, '.json')] = columns.map(c => `${c.name}:${c.type === 'boolean' ? 'bool' : c.type}`).join(', ');
}

// _GetWatchlist returns the CSV columns of each watchlist plus SearchKey
const watchlistColumns = 'SearchKey:string, Identidad:string, AppId:string, Nombre:string, Dueno:string, Servidor:string, HuellaAprobada:string';

const symbols = Object.entries(builtInTables).map(([name, schema]) => new TableSymbol.$ctor7(name, `(${schema})`, null));
symbols.push(new FunctionSymbol.$ctor16('_GetWatchlist', '(watchlistAlias:string)', `{ datatable(${watchlistColumns})[] }`, null));
const globals = GlobalState.Default.WithDatabase(new DatabaseSymbol.$ctor1('sentinel', symbols, false));

const toArray = list => {
  const items = [];
  for (let i = 0; i < list.Count; i++) items.push(list.getItem(i));
  return items;
};

const isoToHours = iso => {
  const m = /^P(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?)?$/.exec(iso);
  return (+(m[1] || 0)) * 24 + (+(m[2] || 0)) + (+(m[3] || 0)) / 60;
};
const agoHours = { d: 24, h: 1, m: 1 / 60 };

const rules = JSON.parse(fs.readFileSync(path.join(root, 'rules.json'), 'utf8'));
let failures = 0;

for (const rule of rules) {
  const query = fs.readFileSync(path.join(root, 'queries', `${rule.id}.kql`), 'utf8')
    .replace('__DOMINIOS_INTERNOS__', '["contoso.com"]');
  const code = KustoCode.ParseAndAnalyze(query, globals);
  const problems = toArray(code.GetDiagnostics())
    .filter(d => d.Severity === 'Error')
    .map(d => `${d.Message} (position ${d.Start})`);

  const resultColumns = code.ResultType && code.ResultType.Columns
    ? toArray(code.ResultType.Columns).map(c => c.Name)
    : [];
  const mapped = rule.entityMappings.flatMap(e => e.fieldMappings.map(f => f.columnName))
    .concat(Object.values(rule.customDetails || {}));
  for (const column of mapped) {
    if (!resultColumns.includes(column)) problems.push(`mapped column "${column}" is not in the result`);
  }

  const period = isoToHours(rule.queryPeriod);
  for (const [, amount, unit] of query.matchAll(/ago\((\d+)([dhm])\)/g)) {
    if (amount * agoHours[unit] > period) problems.push(`ago(${amount}${unit}) is longer than queryPeriod ${rule.queryPeriod}`);
  }
  if (isoToHours(rule.queryFrequency) > period) problems.push('queryFrequency is longer than queryPeriod');

  if (problems.length) {
    failures++;
    console.log(`FAIL ${rule.id}`);
    problems.forEach(p => console.log(`     - ${p}`));
  } else {
    console.log(`OK   ${rule.id}  -> ${resultColumns.join(', ')}`);
  }
}

console.log(`\n${rules.length - failures}/${rules.length} queries valid`);
process.exit(failures ? 1 : 0);
