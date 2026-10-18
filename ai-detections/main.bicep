// ============================================================================
// AI Detection Pack for Microsoft Sentinel
// Version: 1.0.0
// Description: Custom tables and Logs Ingestion API plumbing for MCP and A2A
//              gateway logs, watchlists, and scheduled analytics rules for
//              AI workloads (Azure OpenAI/Foundry, Copilot, agents, MCP, A2A).
//
// Deploys on top of an existing workspace with Microsoft Sentinel enabled,
// for example the one created by ../main.bicep.
//
// Usage:
//   az deployment group create \
//     -g <resource-group> \
//     -f ai-detections/main.bicep \
//     -p ai-detections/main.bicepparam
// ============================================================================

targetScope = 'resourceGroup'

// ===========================================================================
// Parameters
// ===========================================================================

@description('Name of the existing Log Analytics workspace with Microsoft Sentinel')
param workspaceName string

@description('Azure region for the DCE and DCR')
param location string = resourceGroup().location

@description('Prefix for the DCE and DCR names')
param namePrefix string = 'ai-gateway'

@description('Deploy the MCPGateway_CL and A2AGateway_CL tables, DCE and DCR')
param deployIngestion bool = true

@description('Interactive retention for the custom tables, in days')
@minValue(4)
@maxValue(730)
param tableRetentionDays int = 90

@description('Object ID of the gateway identity that sends events. Empty to skip the role assignment.')
param gatewayPrincipalId string = ''

// --- Watchlist content ---

@description('Identities allowed to list keys and deploy models on AI resources, as they appear in AzureActivity.Caller')
param approvedDeployers array = [
  'pipeline-ia@contoso.com'
]

@description('Agent inventory: objects with appId, nombre and dueno')
param agentInventory array = [
  {
    appId: '00000000-0000-0000-0000-000000000001'
    nombre: 'agente-compras'
    dueno: 'compras@contoso.com'
  }
]

@description('Approved MCP servers: objects with servidor, huellaAprobada (SHA-256 of tool definitions) and dueno')
param approvedMcpServers array = [
  {
    servidor: 'erp-tools'
    huellaAprobada: '0000000000000000000000000000000000000000000000000000000000000000'
    dueno: 'erp@contoso.com'
  }
]

@description('Internal domains; MCP tool calls to other destinations raise MCP-003')
param internalDomains array = [
  'contoso.com'
]

// --- Rule groups ---

@description('Rules on SecurityAlert and AzureActivity (needs the Azure Activity, Defender for Cloud and Defender XDR connectors)')
param enableCoreRules bool = true

@description('Rules on MCPGateway_CL and A2AGateway_CL')
param enableGatewayRules bool = true

@description('Rules on Defender XDR advanced hunting tables streamed to Sentinel (DeviceNetworkEvents, DeviceProcessEvents, UrlClickEvents, CloudAppEvents)')
param enableXdrRules bool = false

@description('Rule on AppMetrics from workspace-based Application Insights fed by llm-emit-token-metric')
param enableAppInsightsRules bool = false

@description('Rules on AADServicePrincipalSignInLogs and AuditLogs from the Entra ID connector')
param enableEntraRules bool = false

@description('Rules on the AgentsInfo table (Defender for Endpoint local agent discovery and Agent 365 inventory)')
param enableAgentInventoryRules bool = false

@description('Create the rules enabled (true) or disabled for review (false)')
param rulesEnabled bool = true

// ===========================================================================
// Computed
// ===========================================================================

// Sentinel validates every query on creation, so a rule whose table does not
// exist fails the deployment. Only groups whose tables exist are deployed.
var enabledGroups = filter([
  enableCoreRules ? 'core' : ''
  enableGatewayRules && deployIngestion ? 'custom' : ''
  enableXdrRules ? 'xdr' : ''
  enableAppInsightsRules ? 'appInsights' : ''
  enableEntraRules ? 'entra' : ''
  enableAgentInventoryRules ? 'agentInventory' : ''
], g => !empty(g))

// ===========================================================================
// Module: Custom tables
// ===========================================================================

module tables 'modules/tables.bicep' = if (deployIngestion) {
  name: 'deploy-ai-tables'
  params: {
    workspaceName: workspaceName
    retentionDays: tableRetentionDays
  }
}

// ===========================================================================
// Module: DCE + DCR for the Logs Ingestion API
// ===========================================================================

module ingestion 'modules/ingestion.bicep' = if (deployIngestion) {
  name: 'deploy-ai-ingestion'
  params: {
    workspaceName: workspaceName
    location: location
    namePrefix: namePrefix
    gatewayPrincipalId: gatewayPrincipalId
  }
  dependsOn: [
    tables
  ]
}

// ===========================================================================
// Module: Watchlists
// ===========================================================================

module watchlists 'modules/watchlists.bicep' = {
  name: 'deploy-ai-watchlists'
  params: {
    workspaceName: workspaceName
    approvedDeployers: approvedDeployers
    agentInventory: agentInventory
    approvedMcpServers: approvedMcpServers
  }
}

// ===========================================================================
// Module: Analytics rules (after tables and watchlists exist)
// ===========================================================================

module rules 'modules/rules.bicep' = {
  name: 'deploy-ai-rules'
  params: {
    workspaceName: workspaceName
    enabledGroups: enabledGroups
    rulesEnabled: rulesEnabled
    internalDomains: internalDomains
  }
  dependsOn: [
    tables
    watchlists
  ]
}

// ===========================================================================
// Outputs
// ===========================================================================

@description('Logs ingestion endpoint for the gateway')
output ingestionEndpoint string = deployIngestion ? ingestion!.outputs.ingestionEndpoint : ''

@description('DCR immutable ID for the Logs Ingestion API')
output dcrImmutableId string = deployIngestion ? ingestion!.outputs.dcrImmutableId : ''

@description('Rule groups deployed')
output ruleGroups array = enabledGroups

@description('Rules in the manifest and whether each was deployed')
output deployedRules array = rules.outputs.deployedRules
