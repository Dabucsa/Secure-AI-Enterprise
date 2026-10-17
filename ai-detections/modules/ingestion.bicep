// ============================================================================
// Data collection endpoint and rule for the Logs Ingestion API
// The MCP/A2A gateway posts JSON events to the DCE; the DCR routes each
// stream to its custom table.
// ============================================================================

@description('Name of the existing Log Analytics workspace')
param workspaceName string

@description('Azure region for the DCE and DCR')
param location string

@description('Prefix for the DCE and DCR names')
param namePrefix string

@description('Object ID of the gateway identity allowed to send events. Empty to skip the role assignment.')
param gatewayPrincipalId string

var streams = {
  MCPGateway_CL: loadJsonContent('../schemas/MCPGateway_CL.json')
  A2AGateway_CL: loadJsonContent('../schemas/A2AGateway_CL.json')
}

// Built-in role: Monitoring Metrics Publisher
var metricsPublisherRoleId = '3913510d-42f4-4e42-8a64-420c390055eb'

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: workspaceName
}

resource dce 'Microsoft.Insights/dataCollectionEndpoints@2023-03-11' = {
  name: '${namePrefix}-dce'
  location: location
  properties: {
    networkAcls: {
      publicNetworkAccess: 'Enabled'
    }
  }
}

resource dcr 'Microsoft.Insights/dataCollectionRules@2023-03-11' = {
  name: '${namePrefix}-dcr'
  location: location
  properties: {
    dataCollectionEndpointId: dce.id
    streamDeclarations: toObject(items(streams), s => 'Custom-${s.key}', s => {
      columns: map(s.value, c => {
        name: c.name
        type: c.type
      })
    })
    destinations: {
      logAnalytics: [
        {
          name: 'sentinel'
          workspaceResourceId: workspace.id
        }
      ]
    }
    dataFlows: [for s in items(streams): {
      streams: [
        'Custom-${s.key}'
      ]
      destinations: [
        'sentinel'
      ]
      transformKql: 'source'
      outputStream: 'Custom-${s.key}'
    }]
  }
}

resource sendRole 'Microsoft.Authorization/roleAssignments@2022-04-01' = if (!empty(gatewayPrincipalId)) {
  scope: dcr
  name: guid(dcr.id, gatewayPrincipalId, metricsPublisherRoleId)
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', metricsPublisherRoleId)
    principalId: gatewayPrincipalId
    principalType: 'ServicePrincipal'
  }
}

@description('Logs ingestion endpoint the gateway must call')
output ingestionEndpoint string = dce.properties.logsIngestion.endpoint

@description('Immutable ID of the DCR, required by the Logs Ingestion API')
output dcrImmutableId string = dcr.properties.immutableId
