// ============================================================================
// Custom tables for MCP and A2A gateway logs
// ============================================================================

@description('Name of the existing Log Analytics workspace')
param workspaceName string

@description('Interactive retention for the custom tables, in days')
@minValue(4)
@maxValue(730)
param retentionDays int

var tableSchemas = {
  MCPGateway_CL: loadJsonContent('../schemas/MCPGateway_CL.json')
  A2AGateway_CL: loadJsonContent('../schemas/A2AGateway_CL.json')
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: workspaceName
}

resource tables 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = [for t in items(tableSchemas): {
  parent: workspace
  name: t.key
  properties: {
    plan: 'Analytics'
    retentionInDays: retentionDays
    schema: {
      name: t.key
      columns: [for c in t.value: {
        name: c.name
        // The tables API spells it dateTime; the DCR stream uses datetime
        type: c.type == 'datetime' ? 'dateTime' : c.type
        description: c.description
      }]
    }
  }
}]

@description('Names of the custom tables')
output tableNames array = [for (t, i) in items(tableSchemas): tables[i].name]
