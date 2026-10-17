// ============================================================================
// Scheduled analytics rules for AI, MCP and A2A
// Rule metadata lives in rules.json and each query in queries/<id>.kql
// ============================================================================

@description('Name of the existing Log Analytics workspace with Microsoft Sentinel')
param workspaceName string

@description('Rule groups to deploy: core, custom, xdr, appInsights, entra')
param enabledGroups array

@description('Create the rules enabled (true) or disabled for review (false)')
param rulesEnabled bool

@description('Internal domains; MCP tool calls to other destinations raise MCP-003')
param internalDomains array

var rules = loadJsonContent('../rules.json')

var queries = {
  'AI-001': loadTextContent('../queries/AI-001.kql')
  'AI-002': loadTextContent('../queries/AI-002.kql')
  'AI-003': loadTextContent('../queries/AI-003.kql')
  'AI-004': loadTextContent('../queries/AI-004.kql')
  'AI-005': loadTextContent('../queries/AI-005.kql')
  'AI-006': loadTextContent('../queries/AI-006.kql')
  'AI-007': loadTextContent('../queries/AI-007.kql')
  'AI-008': loadTextContent('../queries/AI-008.kql')
  'AI-009': loadTextContent('../queries/AI-009.kql')
  'MCP-001': loadTextContent('../queries/MCP-001.kql')
  'MCP-002': loadTextContent('../queries/MCP-002.kql')
  'MCP-003': loadTextContent('../queries/MCP-003.kql')
  'MCP-004': loadTextContent('../queries/MCP-004.kql')
  'A2A-001': loadTextContent('../queries/A2A-001.kql')
  'A2A-002': loadTextContent('../queries/A2A-002.kql')
  'A2A-003': loadTextContent('../queries/A2A-003.kql')
  'A2A-004': loadTextContent('../queries/A2A-004.kql')
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: workspaceName
}

resource alertRules 'Microsoft.SecurityInsights/alertRules@2023-02-01' = [for r in rules: if (contains(enabledGroups, r.group)) {
  scope: workspace
  name: guid(workspace.id, 'ai-detections', r.id)
  kind: 'Scheduled'
  properties: {
    displayName: '[${r.id}] ${r.displayName}'
    description: r.description
    severity: r.severity
    enabled: rulesEnabled
    query: replace(queries[r.id], '__DOMINIOS_INTERNOS__', string(internalDomains))
    queryFrequency: r.queryFrequency
    queryPeriod: r.queryPeriod
    triggerOperator: 'GreaterThan'
    triggerThreshold: 0
    suppressionDuration: 'PT1H'
    suppressionEnabled: false
    tactics: r.tactics
    techniques: r.techniques
    entityMappings: empty(r.entityMappings) ? null : r.entityMappings
    customDetails: r.?customDetails
    eventGroupingSettings: {
      aggregationKind: 'AlertPerResult'
    }
    incidentConfiguration: {
      createIncident: true
      groupingConfiguration: {
        enabled: true
        reopenClosedIncident: false
        lookbackDuration: 'PT5H'
        matchingMethod: 'AllEntities'
        groupByEntities: []
        groupByAlertDetails: []
        groupByCustomDetails: []
      }
    }
  }
}]

@description('IDs of the rules in the manifest and whether each was deployed')
output deployedRules array = [for r in rules: {
  id: r.id
  deployed: contains(enabledGroups, r.group)
}]
