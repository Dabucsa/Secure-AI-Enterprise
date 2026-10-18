// ============================================================================
// AI Guardrails Policy Initiative
// Version: 1.0.0
// Description: Groups the built-in Azure Policy definitions for AI workloads
//              (Azure AI Services and Foundry, Foundry model deployments,
//              Azure AI Search, Azure Machine Learning hubs, Defender for AI)
//              into one initiative and assigns it to a management group.
//
// Start with the default Audit effects, review compliance, then switch the
// effects to Deny. Deny does not remove resources that already exist.
//
// Usage:
//   az deployment mg create \
//     --management-group-id <management-group> \
//     -l <region> \
//     -f ai-guardrails/main.bicep \
//     -p ai-guardrails/main.bicepparam
// ============================================================================

targetScope = 'managementGroup'

// ===========================================================================
// Parameters
// ===========================================================================

@description('Name of the initiative and its assignment')
@maxLength(24)
param initiativeName string = 'ai-guardrails'

@description('Region for the assignment metadata (no resources are deployed there)')
param location string = deployment().location

@description('Effect for key access, network, managed identity, AI Search and managed VNet controls')
@allowed([
  'Audit'
  'Deny'
  'Disabled'
])
param guardrailEffect string = 'Audit'

@description('Effect for the approved models and model eligibility controls')
@allowed([
  'Audit'
  'Deny'
  'Disabled'
])
param modelEffect string = 'Audit'

@description('Effect for the customer-managed key control')
@allowed([
  'Audit'
  'Deny'
  'Disabled'
])
param cmkEffect string = 'Audit'

@description('Model publishers allowed in Foundry deployments, for example OpenAI or Microsoft')
param allowedModelPublishers array = [
  'OpenAI'
  'Microsoft'
]

@description('Model asset IDs allowed in Foundry deployments (partial IDs match)')
param allowedModelAssetIds array = []

@description('Flag preview models as non-compliant')
param denyPreviewModels bool = true

@description('Allow only models sold directly by Azure')
param onlyAllowDirectFromAzure bool = false

@description('Managed VNet isolation mode required for Azure Machine Learning and Foundry hubs')
@allowed([
  'AllowOnlyApprovedOutbound'
  'AllowInternetOutbound'
])
param requiredIsolationMode string = 'AllowOnlyApprovedOutbound'

@description('Default evaluates and enforces; DoNotEnforce only evaluates')
@allowed([
  'Default'
  'DoNotEnforce'
])
param enforcementMode string = 'Default'

// ===========================================================================
// Variables
// ===========================================================================

var builtIn = 'Microsoft.Authorization/policyDefinitions'

// Each entry: reference ID, built-in definition GUID, group and the
// initiative parameters it receives
var controls = [
  {
    id: 'ai-services-key-access-disabled'
    definition: '71ef260a-8f18-47b7-abcb-62d0673d94dc'
    group: 'identidad'
    parameters: { effect: { value: '[parameters(\'guardrailEffect\')]' } }
  }
  {
    id: 'ai-services-managed-identity'
    definition: 'fe3fd216-4f83-4fc1-8984-2bbec80a3418'
    group: 'identidad'
    parameters: { effect: { value: '[parameters(\'guardrailEffect\')]' } }
  }
  {
    id: 'ai-services-restrict-network'
    definition: '037eea7a-bd0a-46c5-9a66-03aea78705d3'
    group: 'red'
    parameters: { effect: { value: '[parameters(\'guardrailEffect\')]' } }
  }
  {
    id: 'ai-services-private-link'
    definition: 'd6759c02-b87f-42b7-892e-71b3f471d782'
    group: 'red'
    parameters: { effect: { value: 'Audit' } }
  }
  {
    id: 'ai-search-public-network-disabled'
    definition: 'ee980b6d-0eca-4501-8d54-f6290fd512c3'
    group: 'red'
    parameters: { effect: { value: '[parameters(\'guardrailEffect\')]' } }
  }
  {
    id: 'ai-search-local-auth-disabled'
    definition: '6300012e-e9a4-4649-b41f-a85f5c43be91'
    group: 'identidad'
    parameters: { effect: { value: '[parameters(\'guardrailEffect\')]' } }
  }
  {
    id: 'ml-hub-approved-outbound-only'
    definition: '6ddb1705-c8cf-450e-aa4b-19ad6703c440'
    group: 'red'
    parameters: {
      effect: { value: '[parameters(\'guardrailEffect\')]' }
      isolationMode: { value: '[parameters(\'requiredIsolationMode\')]' }
    }
  }
  {
    id: 'foundry-approved-models'
    definition: 'aafe3651-cb78-4f68-9f81-e7e41509110f'
    group: 'modelos'
    parameters: {
      effect: { value: '[parameters(\'modelEffect\')]' }
      allowedPublishers: { value: '[parameters(\'allowedModelPublishers\')]' }
      allowedAssetIds: { value: '[parameters(\'allowedModelAssetIds\')]' }
    }
  }
  {
    id: 'foundry-model-eligibility'
    definition: '8791d062-ba96-4c34-b604-8538f7e30ca0'
    group: 'modelos'
    parameters: {
      effect: { value: '[parameters(\'modelEffect\')]' }
      denyPreviewModels: { value: '[parameters(\'denyPreviewModels\')]' }
      onlyAllowDirectFromAzure: { value: '[parameters(\'onlyAllowDirectFromAzure\')]' }
    }
  }
  {
    id: 'ai-services-cmk'
    definition: '67121cc7-ff39-4ab8-b7e3-95b84dab487d'
    group: 'datos'
    parameters: { effect: { value: '[parameters(\'cmkEffect\')]' } }
  }
  {
    id: 'ai-services-diagnostic-logs'
    definition: '1b4d1c4e-934c-4703-944c-27c82c06bebb'
    group: 'monitoreo'
    parameters: { effect: { value: 'AuditIfNotExists' } }
  }
  {
    id: 'defender-for-ai-services-enabled'
    definition: 'c2c0c6d8-007b-4a48-8d9b-3539bddd8e87'
    group: 'monitoreo'
    parameters: { effect: { value: 'AuditIfNotExists' } }
  }
]

// ===========================================================================
// Initiative
// ===========================================================================

resource initiative 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: initiativeName
  properties: {
    displayName: 'AI guardrails for Foundry, Azure AI Services, AI Search and Machine Learning'
    description: 'Built-in controls for AI landing zones: Entra ID instead of keys, private network access, approved models, customer-managed keys, diagnostic logs and Defender for AI Services.'
    policyType: 'Custom'
    metadata: {
      category: 'AI'
      version: '1.0.0'
    }
    parameters: {
      guardrailEffect: {
        type: 'String'
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Audit'
      }
      modelEffect: {
        type: 'String'
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Audit'
      }
      cmkEffect: {
        type: 'String'
        allowedValues: [
          'Audit'
          'Deny'
          'Disabled'
        ]
        defaultValue: 'Audit'
      }
      allowedModelPublishers: {
        type: 'Array'
        defaultValue: []
      }
      allowedModelAssetIds: {
        type: 'Array'
        defaultValue: []
      }
      denyPreviewModels: {
        type: 'Boolean'
        defaultValue: true
      }
      onlyAllowDirectFromAzure: {
        type: 'Boolean'
        defaultValue: false
      }
      requiredIsolationMode: {
        type: 'String'
        allowedValues: [
          'AllowOnlyApprovedOutbound'
          'AllowInternetOutbound'
        ]
        defaultValue: 'AllowOnlyApprovedOutbound'
      }
    }
    policyDefinitionGroups: [
      {
        name: 'identidad'
        displayName: 'Identity: Entra ID instead of keys'
      }
      {
        name: 'red'
        displayName: 'Network: private access and controlled egress'
      }
      {
        name: 'modelos'
        displayName: 'Models: approved publishers and models'
      }
      {
        name: 'datos'
        displayName: 'Data: customer-managed keys'
      }
      {
        name: 'monitoreo'
        displayName: 'Monitoring: logs and threat protection'
      }
    ]
    policyDefinitions: [for control in controls: {
      policyDefinitionReferenceId: control.id
      policyDefinitionId: tenantResourceId(builtIn, control.definition)
      groupNames: [
        control.group
      ]
      parameters: control.parameters
    }]
  }
}

// ===========================================================================
// Assignment
// ===========================================================================

resource assignment 'Microsoft.Authorization/policyAssignments@2023-04-01' = {
  name: initiativeName
  location: location
  properties: {
    displayName: 'AI guardrails'
    description: 'Assignment of the AI guardrails initiative. Review compliance in Audit before switching effects to Deny.'
    policyDefinitionId: initiative.id
    enforcementMode: enforcementMode
    parameters: {
      guardrailEffect: {
        value: guardrailEffect
      }
      modelEffect: {
        value: modelEffect
      }
      cmkEffect: {
        value: cmkEffect
      }
      allowedModelPublishers: {
        value: allowedModelPublishers
      }
      allowedModelAssetIds: {
        value: allowedModelAssetIds
      }
      denyPreviewModels: {
        value: denyPreviewModels
      }
      onlyAllowDirectFromAzure: {
        value: onlyAllowDirectFromAzure
      }
      requiredIsolationMode: {
        value: requiredIsolationMode
      }
    }
    nonComplianceMessages: [
      {
        message: 'This AI resource does not meet the AI guardrails: use Entra ID instead of keys, private network access and approved models.'
      }
    ]
  }
}

// ===========================================================================
// Outputs
// ===========================================================================

output initiativeId string = initiative.id
output assignmentId string = assignment.id
