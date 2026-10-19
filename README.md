# IA Empresarial Segura 2026

Guía de estudio sobre seguridad de IA generativa y agentes con Microsoft, y el código que la acompaña. La guía explica cada tema primero de forma agnóstica de fabricante y después con Entra Agent ID, Defender, Purview, Sentinel, Foundry, Azure API Management, Microsoft 365 Copilot y Agent 365. El código se despliega con Bicep sobre Azure y Microsoft Sentinel, y sirve para practicar y como punto de partida en proyectos de clientes.

**Empieza por la [guía](guia/README.md).**

| Carpeta | Qué tiene | Partes de la guía |
|---|---|---|
| [`guia/`](guia/README.md) | El libro de estudio en Markdown: 14 capítulos, 20 partes de profundización y práctica, 24 laboratorios, respuestas de repaso y mapa de certificaciones | Todas |
| [`ai-detections/`](ai-detections/README.md) | Paquete de detecciones para Microsoft Sentinel: tablas `MCPGateway_CL` y `A2AGateway_CL` con su DCE y DCR, watchlists y 23 reglas programadas para Azure OpenAI y Foundry, Microsoft 365 Copilot, identidades de agentes, agentes locales, MCP y A2A | [Defender para IA](guia/06-defender-para-ia.md), [Visibilidad de agentes](guia/08-visibilidad-de-agentes.md), [MCP a fondo](guia/03-mcp-a-fondo.md), [A2A a fondo](guia/04-a2a-a-fondo.md) |
| [`ai-guardrails/`](ai-guardrails/README.md) | Iniciativa de Azure Policy con 12 políticas integradas para landing zones de IA: Entra ID en lugar de claves, acceso de red privado, modelos aprobados en Foundry, claves administradas por el cliente, logs y Defender for AI Services | [Landing zone de IA](guia/09-landing-zone-de-ia.md) |

## Inicio rápido del código

```bash
# Detecciones: sobre un workspace existente con Microsoft Sentinel
az deployment group create \
  -g <grupo-de-recursos> \
  -f ai-detections/main.bicep \
  -p ai-detections/main.bicepparam

# Guardrails: en el management group donde viven las cargas de IA
az deployment mg create \
  --management-group-id <management-group> \
  -l eastus \
  -f ai-guardrails/main.bicep \
  -p ai-guardrails/main.bicepparam
```

Antes de desplegar, revisa los archivos `main.bicepparam` de cada carpeta: las watchlists, los dominios internos, los grupos de reglas, los publicadores de modelos aprobados y los efectos de las políticas.

## Estado de validación

- Las dos plantillas pasan `bicep build` y `bicep lint` con Bicep CLI 0.48.1, sin advertencias.
- Las 23 consultas de detección se validan sin conexión con el servicio de lenguaje de Kusto (`npm run validate` en `ai-detections/scripts`).
- **Nada se desplegó todavía en un tenant real.** Usa `what-if` primero, despliega las reglas desactivadas (`rulesEnabled=false`) y las políticas en Audit.
