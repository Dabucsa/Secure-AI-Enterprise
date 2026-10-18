# AI Detection Pack for Microsoft Sentinel (Bicep)

> **v1.1** — Custom tables, Logs Ingestion API plumbing, watchlists and 23 scheduled analytics rules for AI workloads: Azure OpenAI and Foundry, Microsoft 365 Copilot, agent identities, local AI agents, MCP and A2A.

Deploys on top of an existing workspace with Microsoft Sentinel enabled, for example the one created by the root template. It is the companion of the study guide *IA Empresarial Segura 2026*; table columns and watchlist names follow that guide, which is written in Spanish.

---

## What Gets Deployed

| Resource | Description |
|---|---|
| **`MCPGateway_CL`** | Custom table for MCP gateway events: tool listings, tool calls, fingerprints, external destinations |
| **`A2AGateway_CL`** | Custom table for A2A gateway events: tasks, turns, Agent Card signature checks, data labels |
| **Data collection endpoint + rule** | Logs Ingestion API path from your gateway to both tables |
| **Role assignment** | Monitoring Metrics Publisher on the DCR for the gateway identity (optional) |
| **Watchlists** | `IdentidadesDespliegueIA`, `InventarioAgentes`, `ServidoresMcpAprobados` |
| **Analytics rules** | 23 scheduled rules, deployed by group (below) |

### Analytics Rules

| ID | Rule | Severity | Data | Enabled by |
|---|---|---|---|---|
| AI-001 | Multiple Defender for AI alerts on the same resource | High | `SecurityAlert` | `enableCoreRules` |
| AI-002 | Azure OpenAI or Foundry keys listed by an unapproved identity | Medium | `AzureActivity` + watchlist `IdentidadesDespliegueIA` | `enableCoreRules` |
| AI-003 | Model deployment or logging change by an unapproved identity | Medium | `AzureActivity` + watchlist `IdentidadesDespliegueIA` | `enableCoreRules` |
| AI-004 | Token consumption spike per gateway consumer | Medium | `AppMetrics` | `enableAppInsightsRules` |
| AI-005 | Unapproved process calling public LLM APIs | Medium | `DeviceNetworkEvents` | `enableXdrRules` |
| AI-006 | AI coding CLI launched with permission bypass | High | `DeviceProcessEvents` | `enableXdrRules` |
| AI-007 | Click on an AI assistant link that writes to memory | Low | `UrlClickEvents` | `enableXdrRules` |
| AI-008 | Repeated jailbreak attempts against Microsoft 365 Copilot | Medium | `CloudAppEvents` | `enableXdrRules` |
| AI-009 | Agent identity signing in from a new IP address | Medium | `AADServicePrincipalSignInLogs` + watchlist `InventarioAgentes` | `enableEntraRules` |
| AI-010 | Local AI agent auto-approves actions and has local MCP servers | Medium | `AgentsInfo` | `enableAgentInventoryRules` |
| AI-011 | Published agent with MCP servers and no Entra Agent ID | Low | `AgentsInfo` | `enableAgentInventoryRules` |
| AI-012 | Prompt injection against AI agents on several devices | High | `SecurityAlert` | `enableCoreRules` |
| AI-013 | Secret or certificate added to an agent identity blueprint | High | `AuditLogs` | `enableEntraRules` |
| AI-014 | First MCP server process on a device | Low | `DeviceProcessEvents` | `enableXdrRules` |
| AI-015 | Repeated attempts to reach blocked generative AI apps | Low | `DeviceEvents` | `enableXdrRules` |
| MCP-001 | Tool definitions differ from the approved fingerprint | High | `MCPGateway_CL` + watchlist `ServidoresMcpAprobados` | `enableGatewayRules` |
| MCP-002 | Agent using a tool for the first time | Low | `MCPGateway_CL` | `enableGatewayRules` |
| MCP-003 | Tool call sending data to an external destination | High | `MCPGateway_CL` | `enableGatewayRules` |
| MCP-004 | Burst of tool calls by one agent | Medium | `MCPGateway_CL` | `enableGatewayRules` |
| A2A-001 | Agent Card with invalid signature or unexpected key | High | `A2AGateway_CL` | `enableGatewayRules` |
| A2A-002 | Confidential data sent to an external agent | High | `A2AGateway_CL` | `enableGatewayRules` |
| A2A-003 | Task with an unusually long conversation | Medium | `A2AGateway_CL` | `enableGatewayRules` |
| A2A-004 | First contact with an external agent | Low | `A2AGateway_CL` | `enableGatewayRules` |

> **Why groups?** Sentinel validates every query when the rule is created, so a rule whose table does not exist fails the whole deployment. Enable a group only when its tables have data: XDR tables need the Defender XDR connector with raw events streamed to Sentinel, `AppMetrics` needs workspace-based Application Insights fed by the APIM `llm-emit-token-metric` policy, and `AADServicePrincipalSignInLogs` and `AuditLogs` need the Entra ID connector.
>
> **Agent inventory rules.** `AgentsInfo` is the Defender XDR table for local agents discovered by Defender for Endpoint and for agents in the Agent 365 inventory. Enable `enableAgentInventoryRules` only if the table is queryable from your workspace. The Learn schema names the agent column `AgentName`, while the local agent queries on Learn use `Name`; AI-010 uses `Name` and AI-011 uses `AgentName`, so check both in your tenant. AI-013 relies on the `agentType` property that Entra adds to audit log target resources; confirm that your `AuditLogs` table carries it.

---

## Prerequisites

1. **Existing workspace** with Microsoft Sentinel enabled (deploy the root template first if needed)
2. **Permissions**: `Microsoft Sentinel Contributor` and `Log Analytics Contributor` on the resource group; `User Access Administrator` or `Owner` if you set `gatewayPrincipalId`
3. **Azure CLI** with Bicep support
4. For the core rules: the **Azure Activity** and **Defender for Cloud** connectors, and Defender for AI Services enabled on your AI resources

---

## Quick Start

```bash
# Review and edit the parameter file first: watchlists, internal domains, rule groups
az deployment group create \
  -g rg-sentinel \
  -f ai-detections/main.bicep \
  -p ai-detections/main.bicepparam

# Deploy the rules disabled to review them in the portal first
az deployment group create \
  -g rg-sentinel \
  -f ai-detections/main.bicep \
  -p ai-detections/main.bicepparam \
  -p rulesEnabled=false
```

If the first deployment fails on MCP or A2A rules with a "table does not exist" error, the new custom tables were not queryable yet. Wait a few minutes and run the same command again.

---

## Sending Gateway Events

Your MCP and A2A gateway (API Management, a sidecar or the MCP server itself) posts JSON arrays to the Logs Ingestion API:

```
POST {ingestionEndpoint}/dataCollectionRules/{dcrImmutableId}/streams/Custom-MCPGateway_CL?api-version=2023-01-01
POST {ingestionEndpoint}/dataCollectionRules/{dcrImmutableId}/streams/Custom-A2AGateway_CL?api-version=2023-01-01
```

Both values are deployment outputs. The columns and types are defined once in [`schemas/`](schemas/) and used by the tables, the DCR, the query validator and the test script. Never send raw prompts or secrets: the `ArgumentosRedactados` column expects redacted arguments.

To test the rules end to end, send synthetic events that trigger every MCP and A2A rule:

```bash
pip install azure-identity azure-monitor-ingestion
python ai-detections/scripts/send_test_events.py --dry-run
python ai-detections/scripts/send_test_events.py \
  --endpoint "<ingestionEndpoint>" \
  --dcr "<dcrImmutableId>"
```

The identity running the script needs Monitoring Metrics Publisher on the DCR.

---

## Validating the Queries Offline

The validator parses each query with the Kusto language service against the table schemas, checks that every column used by entity mappings and custom details is in the result, and that no `ago()` lookback exceeds the rule's query period:

```bash
cd ai-detections/scripts
npm install
npm run validate
```

Run it after editing any file in `queries/` or `rules.json`, together with `az bicep build -f ai-detections/main.bicep`.

---

## Parameters Reference

| Parameter | Type | Default | Description |
|---|---|---|---|
| `workspaceName` | string | *(required)* | Existing Log Analytics workspace with Sentinel |
| `location` | string | Resource group location | Region for the DCE and DCR |
| `namePrefix` | string | `ai-gateway` | Prefix for the DCE and DCR names |
| `deployIngestion` | bool | `true` | Custom tables, DCE and DCR |
| `tableRetentionDays` | int | `90` | Interactive retention of the custom tables (4-730) |
| `gatewayPrincipalId` | string | `''` | Object ID of the gateway identity; empty skips the role assignment |
| `approvedDeployers` | array | example | Identities allowed to list keys and deploy models, as in `AzureActivity.Caller` |
| `agentInventory` | array | example | Objects with `appId`, `nombre`, `dueno` |
| `approvedMcpServers` | array | example | Objects with `servidor`, `huellaAprobada`, `dueno` |
| `internalDomains` | array | `['contoso.com']` | Destinations outside these raise MCP-003 |
| `enableCoreRules` | bool | `true` | AI-001 to AI-003 and AI-012 |
| `enableGatewayRules` | bool | `true` | MCP and A2A rules (needs `deployIngestion`) |
| `enableXdrRules` | bool | `false` | AI-005 to AI-008, AI-014 and AI-015 |
| `enableAppInsightsRules` | bool | `false` | AI-004 |
| `enableEntraRules` | bool | `false` | AI-009 and AI-013 |
| `enableAgentInventoryRules` | bool | `false` | AI-010 and AI-011 |
| `rulesEnabled` | bool | `true` | Create the rules enabled or disabled |

Watchlist values are written as CSV, so they must not contain commas. Replace the example values before deploying: with the defaults, every real caller of `ListKeys` will raise AI-002.

---

## Project Structure

```
ai-detections/
├── main.bicep                    # Orchestrator
├── main.bicepparam               # Parameter values to edit
├── rules.json                    # Rule metadata: severity, tactics, entity mappings
├── queries/                      # One KQL file per rule
├── schemas/                      # Columns of MCPGateway_CL and A2AGateway_CL
├── modules/
│   ├── tables.bicep              # Custom tables
│   ├── ingestion.bicep           # DCE, DCR and sender role assignment
│   ├── watchlists.bicep          # Watchlists
│   └── rules.bicep               # Scheduled analytics rules
└── scripts/
    ├── validate-queries.cjs      # Offline KQL validation
    ├── package.json
    └── send_test_events.py       # Synthetic events for the MCP and A2A rules
```

---

## Validation Status

- `bicep build` and `bicep lint` pass with Bicep CLI 0.48.1, with no warnings.
- All 23 queries parse and bind without errors in the Kusto language service 12.4.1, and every mapped column exists in the results.
- The test events pass schema validation in dry-run mode.
- The pack has **not** been deployed to a live tenant yet. Run `az deployment group what-if` first, and deploy with `rulesEnabled=false` the first time.
