using 'main.bicep'

// ===========================================================================
// Parameter values — adjust to your environment
// ===========================================================================

// Start in Audit. Switch to Deny after reviewing compliance for a few weeks.
param guardrailEffect = 'Audit'
param modelEffect = 'Audit'

// Customer-managed keys: keep Audit unless your data policy requires CMK
param cmkEffect = 'Audit'

// Approved models. With both lists empty, every deployment is non-compliant.
param allowedModelPublishers = [
  'OpenAI'
  'Microsoft'
]
param allowedModelAssetIds = []
param denyPreviewModels = true
param onlyAllowDirectFromAzure = false

// Foundry hubs and Azure Machine Learning workspaces
param requiredIsolationMode = 'AllowOnlyApprovedOutbound'

// DoNotEnforce evaluates compliance without blocking anything
param enforcementMode = 'Default'
