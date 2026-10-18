using 'main.bicep'

// ===========================================================================
// Parameter values — adjust to your environment
// ===========================================================================

param workspaceName = 'law-sentinel-prod'

// Custom tables + DCE/DCR for MCP and A2A gateway logs
param deployIngestion = true
param tableRetentionDays = 90

// Object ID of the gateway managed identity that posts events (empty = skip)
param gatewayPrincipalId = ''

// --- Watchlists (replace the examples) ---
param approvedDeployers = [
  'pipeline-ia@contoso.com'
]
param agentInventory = [
  {
    appId: '00000000-0000-0000-0000-000000000001'
    nombre: 'agente-compras'
    dueno: 'compras@contoso.com'
  }
]
param approvedMcpServers = [
  {
    servidor: 'erp-tools'
    huellaAprobada: '0000000000000000000000000000000000000000000000000000000000000000'
    dueno: 'erp@contoso.com'
  }
]
param internalDomains = [
  'contoso.com'
]

// --- Rule groups: enable only those whose tables exist in the workspace ---
param enableCoreRules = true
param enableGatewayRules = true
param enableXdrRules = false
param enableAppInsightsRules = false
param enableEntraRules = false
param enableAgentInventoryRules = false

// Set to false to create the rules disabled and review them first
param rulesEnabled = true
