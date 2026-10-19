// ============================================================================
// Watchlists used by the AI analytics rules
// ============================================================================

@description('Name of the existing Log Analytics workspace with Microsoft Sentinel')
param workspaceName string

@description('Identities allowed to list keys and deploy models on AI resources (UPN, object ID or app ID as it appears in AzureActivity.Caller)')
param approvedDeployers array

@description('Agent inventory: objects with appId, nombre and dueno')
param agentInventory array

@description('Approved MCP servers: objects with servidor, huellaAprobada and dueno')
param approvedMcpServers array

var watchlists = [
  {
    alias: 'IdentidadesDespliegueIA'
    description: 'Identities allowed to list keys and deploy models on Azure OpenAI and Foundry'
    searchKey: 'Identidad'
    csv: join(concat(['Identidad'], approvedDeployers), '\r\n')
  }
  {
    alias: 'InventarioAgentes'
    description: 'Agent identities (Entra Agent ID) with their owner'
    searchKey: 'AppId'
    csv: join(concat(['AppId,Nombre,Dueno'], map(agentInventory, a => '${a.appId},${a.nombre},${a.dueno}')), '\r\n')
  }
  {
    alias: 'ServidoresMcpAprobados'
    description: 'Approved MCP servers and the fingerprint of their approved tool definitions'
    searchKey: 'Servidor'
    csv: join(concat(['Servidor,HuellaAprobada,Dueno'], map(approvedMcpServers, s => '${s.servidor},${s.huellaAprobada},${s.dueno}')), '\r\n')
  }
]

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: workspaceName
}

resource lists 'Microsoft.SecurityInsights/watchlists@2023-02-01' = [for w in watchlists: {
  scope: workspace
  name: w.alias
  properties: {
    displayName: w.alias
    description: w.description
    provider: 'Custom'
    source: 'Local file'
    itemsSearchKey: w.searchKey
    contentType: 'text/csv'
    numberOfLinesToSkip: 0
    rawContent: w.csv
  }
}]

@description('Aliases of the deployed watchlists')
output aliases array = [for (w, i) in watchlists: lists[i].name]
