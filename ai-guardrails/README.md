# AI Guardrails Policy Initiative (Bicep)

> **v1.0** — One Azure Policy initiative with 12 built-in controls for AI landing zones: Entra ID instead of keys, private network access, approved Foundry models, customer-managed keys, diagnostic logs and Defender for AI Services.

Assign it to the management group that holds your AI workloads (usually **Corp** for internal AI and **Online** for internet-facing AI, as the Cloud Adoption Framework recommends). It complements the platform landing zone policies and the AI Detection Pack in [`../ai-detections`](../ai-detections/README.md). It is the companion of the study guide [*IA Empresarial Segura 2026*](../guia/README.md), which is written in Spanish.

---

## Controls

| Group | Built-in policy | ID | Effect parameter |
|---|---|---|---|
| Identity | Azure AI Services resources should have key access disabled | `71ef260a` | `guardrailEffect` |
| Identity | Cognitive Services accounts should use a managed identity | `fe3fd216` | `guardrailEffect` |
| Identity | Azure AI Search services should have local authentication methods disabled | `6300012e` | `guardrailEffect` |
| Network | Azure AI Services resources should restrict network access | `037eea7a` | `guardrailEffect` |
| Network | Azure AI Services resources should use Azure Private Link | `d6759c02` | Audit only |
| Network | Azure AI Search services should disable public network access | `ee980b6d` | `guardrailEffect` |
| Network | Azure Machine Learning and AI Studio should use Allow Only Approved Outbound managed VNet mode | `6ddb1705` | `guardrailEffect` |
| Models | Foundry model deployments should only use approved models | `aafe3651` | `modelEffect` |
| Models | [Preview] Foundry model deployments should meet eligibility requirements | `8791d062` | `modelEffect` |
| Data | Azure AI Services resources should encrypt data at rest with a customer-managed key | `67121cc7` | `cmkEffect` |
| Monitoring | Diagnostic logs in Azure AI services resources should be enabled | `1b4d1c4e` | AuditIfNotExists |
| Monitoring | Microsoft Defender for AI Services should be enabled | `c2c0c6d8` | AuditIfNotExists |

Definition IDs, parameters and allowed effects were taken from the `Azure/azure-policy` repository on 2026-10-18.

---

## Quick Start

```bash
# Review main.bicepparam first: approved model publishers and effects
az deployment mg create \
  --management-group-id mg-landingzones-corp \
  -l eastus \
  -f ai-guardrails/main.bicep \
  -p ai-guardrails/main.bicepparam

# Preview the changes
az deployment mg what-if \
  --management-group-id mg-landingzones-corp \
  -l eastus \
  -f ai-guardrails/main.bicep \
  -p ai-guardrails/main.bicepparam
```

You need `Resource Policy Contributor` (or `Owner`) on the management group.

---

## Rollout

1. Deploy with every effect in **Audit** and wait for the first compliance evaluation, or start one with `az policy state trigger-scan`.
2. Fix or exempt the non-compliant resources. Typical findings: AI Services with keys enabled, public endpoints and model deployments from publishers outside the list.
3. Switch `guardrailEffect` and `modelEffect` to **Deny**. Deny blocks new or updated resources; it does not remove existing deployments, which you must remediate by hand.
4. Keep `cmkEffect` in Audit unless your data policy requires customer-managed keys.

The approved models control fails every deployment when both `allowedModelPublishers` and `allowedModelAssetIds` are empty. Publisher names must match the `model.publisher` value of the Foundry catalog.

---

## What This Initiative Does Not Cover

- **Content filters and guardrails** of model deployments and agents: Microsoft publishes a preview initiative, *Guardrail for Cognitive Services Deployments* (`5207647b`), with 40 parameters and no defaults. Assign it separately once you agree on the thresholds.
- **Deploy-if-not-exists remediation**, such as `359a48a3` (configure Defender for AI Services) or `14de9e63` (disable local authentication). They need a managed identity and role assignments on the assignment.
- **Platform controls** already covered by the Azure landing zone policies: DDoS, firewall, private DNS zones, diagnostic settings for the rest of the estate.
- **Regulatory views**: use the built-in initiatives *NIST AI RMF v1.0* (`f58a876c`), *EU AI Act 2024 1689* (`1308bccf`) and *Microsoft cloud security benchmark v2* (`e3ec7e09`) in Defender for Cloud regulatory compliance.

---

## Validation Status

- `bicep build`, `bicep lint` and `bicep build-params` pass with Bicep CLI 0.48.1, with no warnings.
- The initiative has **not** been deployed to a live tenant yet. Run `what-if` first and keep `enforcementMode = 'DoNotEnforce'` or Audit effects for the first deployment.
