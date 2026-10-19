# Visibilidad y detección de agentes

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Esta pestaña junta las piezas de Defender para IA, Purview para IA y Agentes con Entra para responder la pregunta que te van a hacer en cualquier cliente: **“si un agente hace algo malo, ¿lo vemos?”** La respuesta honesta depende del tipo de agente, y casi nunca es “sí” sin trabajo previo.

## 1. Tres capas de señal

Para investigar a un agente necesitas tres cosas, y cada una viene de un lugar distinto:

| Capa | Pregunta que responde | De dónde sale |
| --- | --- | --- |
| Identidad | ¿Quién es el agente, quién responde por él, qué token pidió y para qué recurso? | Entra Agent ID: inicios de sesión con tipo de agente, auditoría con `agentType` y `blueprintId`, ID Protection para agentes, Conditional Access |
| Comportamiento | ¿Qué hizo: qué herramientas llamó, qué archivos tocó, a dónde se conectó? | Observabilidad de Agent 365 en Defender (`CloudAppEvents`, `BehaviorInfo`), MDE (procesos, red, agentes locales), Defender for AI Services, logs de tu gateway |
| Contenido | ¿Qué datos entraron y salieron? | Purview (auditoría, DSPM, DLP, Insider Risk), fragmentos de evidencia del prompt en Defender, Generative AI Insights de Global Secure Access |

La regla práctica: **sin identidad propia no hay investigación posible**, porque todo lo demás se une por el identificador del agente. Y sin un punto por donde pase el tráfico (gateway, Agent 365 o el propio servicio), no hay comportamiento ni contenido.

## 2. Quién ve qué, por tipo de agente

| Tipo de agente | Inventario | Identidad | Comportamiento | Contenido | Cómo se frena |
| --- | --- | --- | --- | --- | --- |
| Microsoft 365 Copilot y agentes declarativos | Centro de administración de Microsoft 365 y registro de Agent 365 | Actúa como el usuario: inicios de sesión del usuario | `CloudAppEvents` y observabilidad de Agent 365 | Auditoría `CopilotInteraction`, DSPM, DLP de Copilot | DLP de Copilot, RCD, gestión de agentes del centro de administración |
| Copilot Studio | Centro de Power Platform, registro de Agent 365, `AgentsInfo` | Entra Agent ID (hay migración) o la identidad del usuario o del creador | Observabilidad de Agent 365 en Defender (requiere Agent 365) | Purview: auditoría, DSPM, DLP | Protección en tiempo real (preview), directivas de datos de Power Platform, DLP |
| Agentes de Foundry | Foundry Control Plane, registro de Agent 365, `AgentsInfo` | Agent ID automático: inicios de sesión, auditoría, ID Protection | Agent 365 (solo agentes publicados); Defender for AI Services para las llamadas al modelo | Integración con Purview, solo con token de usuario | Guardrails de Foundry, protección en tiempo real (preview), Conditional Access por riesgo |
| Agente propio con Agent ID (Container Apps, AKS, incluso Bedrock) | Entra y el registro de Agent 365 si lo publicas | Completa: inicios de sesión, auditoría, ID Protection, Conditional Access | Solo si lo instrumentas con el Agent 365 SDK o pasa por tu gateway | Solo si llama a la API de Purview | Deshabilitar la identidad, Conditional Access, el gateway |
| Agente propio sin Agent ID (app registration con secreto) | Ninguno específico: es una app más | Inicios de sesión de service principal, sin tipo de agente | Solo tu gateway | Solo lo que construyas | Revocar el secreto; Conditional Access para workload identities |
| Agente local de programación (Claude Code, Cursor, Codex) | Agentes locales de MDE, registro de Agent 365 | La del desarrollador y sus tokens (PAT, CLI de la nube): no se distingue del humano | MDE: procesos, red, protección en tiempo de ejecución | Inspección de MDE en agentes soportados (preview, Windows); Purview anunciado | Protección en tiempo de ejecución en Block, App Control |
| IA y agentes SaaS de terceros (ChatGPT, Claude, Gemini) | Catálogo de MDA, shadow AI de Global Secure Access, DSPM, Security Dashboard for AI | Inicios de sesión del usuario si hay SSO; app governance si se conecta a Microsoft 365 | Volumen y usuarios en MDA | Purview en equipo, Edge y red; Generative AI Insights | Unsanctioned vía MDE, Global Secure Access, sesiones si hay SSO |
| Agentes en otras nubes (Bedrock, Vertex) | AI-SPM, sincronización del registro de Agent 365 (preview) | Solo si usan Agent ID (Microsoft documenta el caso de Bedrock con el sidecar) | CloudTrail o los logs de la otra nube en Sentinel | Tu gateway | Guardrails de la otra nube, tu gateway |

Dos filas explican la mayor parte de los incidentes que vas a ver: el **agente propio sin Agent ID**, que nadie distingue de una app cualquiera, y el **agente local**, que usa las credenciales del desarrollador. Microsoft documenta cómo [migrar app registrations a Agent ID](https://learn.microsoft.com/en-us/entra/agent-id/migrate-custom-app-registrations-to-agent-id) y cómo [integrar agentes de terceros](https://learn.microsoft.com/en-us/entra/agent-id/configure-third-party-agents) como Bedrock o n8n.

## 3. La capa de identidad: Entra para agentes

**Inicios de sesión.** Un agente puede iniciar sesión con permisos delegados o de aplicación, así que sus eventos aparecen en los cuatro tipos de log de inicio de sesión. En el centro de administración filtras por **Agent type** (Agent ID user, Agent Identity, Agent Identity Blueprint, Not Agentic) o por **Is Agent**. Por Graph, en beta ([Microsoft Learn, 28 abr 2026](https://learn.microsoft.com/en-us/entra/agent-id/sign-in-audit-logs-agents)):

```http
GET https://graph.microsoft.com/beta/auditLogs/signIns?$filter=signInEventTypes/any(t: t eq 'servicePrincipal') and agent/agentType eq 'AgentIdentity'
```

**Auditoría.** Cada evento indica si intervino un agente con la propiedad `agentType` y lo une a su plantilla con `blueprintId`. Crear un blueprint aparece como “Add application” con `agenticApp`; crear una identidad de agente, como “Add service principal” con `agenticAppInstance`; crear el usuario del agente, como “Add user” con `agentIDuser`. Esta consulta para Sentinel lista los cambios sobre agentes; está validada contra el esquema, pero confirma que tu workspace ya recibe `agentType` dentro de `TargetResources`:

```kusto
AuditLogs
| where TimeGenerated > ago(7d)
| where OperationName has_any ("application", "service principal", "Add user", "app role assignment", "Certificates and secrets")
| mv-expand Objetivo = TargetResources
| extend TipoAgente = tostring(Objetivo.agentType), Blueprint = tostring(Objetivo.blueprintId)
| where isnotempty(TipoAgente) and TipoAgente != "notAgentic"
| project TimeGenerated, OperationName, Result, TipoAgente, Blueprint, Objetivo = tostring(Objetivo.displayName),
          Actor = coalesce(tostring(InitiatedBy.user.userPrincipalName), tostring(InitiatedBy.app.displayName))
| sort by TimeGenerated desc
```

**ID Protection para agentes.** Detecta riesgo en agentes con Entra Agent ID ([Microsoft Learn, 17 jun 2026](https://learn.microsoft.com/en-us/entra/id-protection/concept-risky-agents)). Todas las detecciones son offline:

| Detección | Qué significa | `riskEventType` |
| --- | --- | --- |
| Uso sospechoso de credenciales | Se agregó una credencial nueva al blueprint y se usó | `suspiciousCredentialUsage` |
| Intento de acceso fallido | El agente intentó entrar a recursos para los que no tiene permiso; puede ser un token robado reutilizado | `failedAccessAttempt` |
| Acceso a recursos no habituales | El agente apuntó a recursos que no suele usar | `unfamiliarResourceAccess` |
| Pico de inicios de sesión | Muchos más inicios de sesión que lo normal | `signInSpike` |
| Reconocimiento del directorio | Operaciones de reconocimiento o de alto riesgo en Entra | `entraDirectoryReconnaissance` |
| Actividad maliciosa temprana | Un agente recién creado se comportó como un atacante | `earlyLifeMaliciousActivity` |
| Inteligencia de amenazas | Actividad que coincide con patrones de ataque conocidos | `threatIntelligenceAccount` |
| Compromiso confirmado | Un administrador lo marcó como comprometido | `adminConfirmedAgentCompromised` |

Tres detalles de experto. En el flujo en nombre del usuario, el riesgo se atribuye **al usuario**, no al agente, para no cortar el agente a todos. Un “modo de aprendizaje” suprime alertas de comportamiento en agentes sin historial. Y **confirmar el compromiso** sube el riesgo a alto, lo que dispara las políticas de Conditional Access que bloquean agentes de riesgo alto; desde el informe también puedes deshabilitar el agente. Las detecciones se guardan 90 días, se exportan con diagnostic settings y se consultan por Graph (`riskyAgents`, `agentRiskDetections`). Microsoft anuncia que pronto requerirá licencia de Agent 365.

Qué vigilar siempre en la auditoría: credenciales nuevas en un blueprint, identidades de agente creadas fuera de los blueprints aprobados, usuarios de agente nuevos, permisos concedidos a identidades de agente y agentes que se quedan sin sponsor.

## 4. Escenarios de punta a punta

Cada escenario recorre el ataque paso a paso y dice quién lo ve. La columna “brecha” es lo que tienes que cerrar en el diseño.

### Escenario A: datos de clientes pegados en un chat de IA de consumo

| Paso | Quién lo ve | Brecha |
| --- | --- | --- |
| El usuario abre un chat de IA de consumo | MDA (descubrimiento vía MDE), shadow AI de Global Secure Access | Si la app está como Monitored, solo hay aviso |
| Pega una planilla con datos de clientes | Purview: DLP de equipo con la extensión, protección de Edge o red con Global Secure Access | Equipo personal o navegador sin extensión: nadie ve el contenido |
| Repite durante la semana | Insider Risk con Risky AI usage; Adaptive Protection sube su nivel y la DLP pasa a bloquear | El indicador de otras apps de IA se paga por uso |
| El SOC investiga | Activity explorer de DSPM, alertas de DLP en Defender XDR | Ver el texto requiere E5 |

### Escenario B: agente de programación con inyección desde un issue

Un desarrollador le pide a su agente que resuelva un issue de GitHub. El issue tiene instrucciones ocultas para leer `.env` y enviarlo a un servidor externo con una herramienta MCP local.

| Paso | Quién lo ve | Brecha |
| --- | --- | --- |
| El agente lee el issue con la instrucción oculta | Protección en tiempo de ejecución de MDE inspecciona la respuesta de la herramienta y puede bloquear (preview, Windows, agentes de la matriz) | En macOS o con agentes sin hooks, nadie inspecciona |
| El agente auto-aprueba la lectura del secreto | Inventario de agentes locales: `autoApprove = true` (se sabe antes del ataque) | El inventario no bloquea |
| El MCP local hace una conexión saliente | MDE: `DeviceNetworkEvents` con el proceso del MCP; network protection si el destino es conocido | Destino nuevo y legítimo en apariencia: no hay bloqueo |
| Alguien usa la clave robada | Si era una credencial de Entra: ID Protection o los logs del recurso | Si era una clave de API de un tercero, Microsoft no lo ve |

La defensa real está antes del ataque: sin auto-aprobación, sin secretos en el equipo (identidades administradas o tokens de corta vida) y con los MCP pasando por un gateway (pestaña MCP a fondo).

### Escenario C: agente de Copilot Studio con inyección indirecta por correo

| Paso | Quién lo ve | Brecha |
| --- | --- | --- |
| Llega un correo con instrucciones para el agente | Defender for Office 365 P2: protección contra inyección en el correo | Sin P2, el correo llega |
| El agente procesa el correo y decide enviar un archivo afuera | Defender con Agent 365: detección de inyección indirecta y protección en tiempo real de la herramienta (preview en Copilot Studio) | Sin licencia de Agent 365, no hay detección del agente |
| El archivo tiene etiqueta confidencial | Purview: DLP para agentes de Agent 365; Insider Risk con Risky Agents | El agente no sabe que lo bloquearon: el flujo falla en silencio |
| El SOC investiga | Incidente en Defender XDR con el agente como entidad; `CloudAppEvents`, `BehaviorInfo` | Las trazas se guardan 30 días: expórtalas si necesitas más |

### Escenario D: credencial nueva en un blueprint

Un atacante con rol de administrador de aplicaciones agrega un secreto al blueprint de un agente y lo usa desde fuera.

| Paso | Quién lo ve | Brecha |
| --- | --- | --- |
| Se agrega el secreto | Auditoría de Entra (“Update application” con `agenticApp`); la consulta de la sección 3 y la regla AI-013 del paquete de detecciones | Nadie mira la auditoría si no hay regla |
| El atacante obtiene tokens como el agente | ID Protection: `suspiciousCredentialUsage`; inicios de sesión desde IP nueva (regla AI-009 del paquete de detecciones) | Detección offline: hay minutos u horas de ventaja |
| Accede a recursos que el agente no usa | ID Protection: `unfamiliarResourceAccess` o `failedAccessAttempt` | Si el agente tenía permisos amplios, el acceso “es normal” |
| Respuesta | Confirmar compromiso: riesgo alto y Conditional Access bloquea; deshabilitar la identidad | Sin la política de riesgo de agentes creada, confirmar no bloquea nada |

La lección de este escenario es de diseño: usa credenciales federadas con identidad administrada en el blueprint en lugar de secretos, y limita quién puede administrar aplicaciones con PIM.

## 5. Un inventario, varias listas

Hoy un agente puede aparecer en nueve lugares: Entra (identidades y blueprints), el registro de Agent 365, el inventario de agentes de Defender (`AgentsInfo`), los agentes locales de MDE, DSPM de Purview, AI-SPM de Defender for Cloud, el centro de Power Platform, el Foundry Control Plane y el catálogo de MDA para las apps SaaS. Microsoft está convergiendo los registros en **Agent 365** como plano de control, con **Entra** como base de identidad ([convergencia del registro](https://learn.microsoft.com/en-us/entra/agent-id/agent-registry-convergence)). El Security Dashboard for AI muestra una vista conjunta.

Recomendación para clientes:

1. **Fuente de verdad:** el registro de Agent 365, con Entra Agent ID como ancla de identidad. Un agente sin identidad es un hallazgo; Entra los llama “registry-only agents”.
2. **Conciliación mensual:** agentes publicados sin `EntraAgentId` (consulta de la pestaña Defender para IA), agentes locales nuevos con auto-aprobación y apps de IA sin decisión en MDA.
3. **Dueño y sponsor:** todo agente en producción tiene un humano responsable registrado. Sin eso, no hay a quién llamar en un incidente.

## 6. Cómo cerrar las brechas: el patrón de referencia

1. **Identidad para cada agente.** Agent ID para todo agente propio, incluidos los que corren en otras nubes; migrar las app registrations; sponsor obligatorio; Conditional Access que bloquee agentes de riesgo alto.
2. **Un punto de paso para modelos y herramientas.** El gateway de IA para los modelos y un gateway MCP para las herramientas, que registren en cada evento **el ID del agente y el del usuario**. Ese par de identificadores es lo que permite unir Entra, Defender, Purview y tus logs.
3. **Observabilidad.** Instrumentar los agentes propios con el Agent 365 SDK (GA desde Build 2026) para que Defender y Purview los vean como a los de Microsoft.
4. **Contenido.** Llamar a la API de Purview desde los agentes propios y enviar el contexto de usuario a Azure OpenAI para que Defender for AI Services sepa quién fue.
5. **Equipos.** MDE Plan 2 con la protección en tiempo de ejecución de agentes y App Control para los agentes no aprobados.
6. **SOC.** Sentinel con los conectores de Entra (inicios de sesión, auditoría y riesgo), Defender XDR (`AgentsInfo`, `BehaviorInfo`, `CloudAppEvents`), auditoría de Purview y las tablas del gateway, con las reglas del paquete de detecciones y retención más larga que los 30 días de las trazas.

## 7. Para repasar

1. ¿Por qué un agente propio sin Agent ID es casi invisible para el SOC aunque tenga Defender y Purview, y qué tres cosas cambias para verlo?
2. En el escenario B, ¿qué dato del inventario de MDE te habría permitido actuar antes del ataque?
3. Un agente actúa en nombre de un usuario cuya sesión fue robada. ¿A quién le asigna el riesgo ID Protection y por qué es una buena decisión?
4. Confirmaste el compromiso de un agente en el informe de Risky Agents y el agente sigue funcionando. ¿Qué falta?
5. ¿Qué dos identificadores debe registrar tu gateway en cada evento y para qué?

## Fuentes

- [Logs de Entra Agent ID](https://learn.microsoft.com/en-us/entra/agent-id/sign-in-audit-logs-agents) (28 abr 2026)
- [ID Protection para agentes](https://learn.microsoft.com/en-us/entra/id-protection/concept-risky-agents) (17 jun 2026)
- [Convergencia del registro de agentes con Agent 365](https://learn.microsoft.com/en-us/entra/agent-id/agent-registry-convergence) (5 abr 2026) y [agentes sin identidad](https://learn.microsoft.com/en-us/entra/agent-id/manage-agents-without-identity) (1 may 2026)
- [Agentes de terceros con Agent ID](https://learn.microsoft.com/en-us/entra/agent-id/configure-third-party-agents) (29 abr 2026) y [agente de Bedrock con Agent ID](https://learn.microsoft.com/en-us/entra/agent-id/integrate-aws-bedrock-agent) (30 abr 2026)
- El resto de las fuentes están en las pestañas Defender para IA y Purview para IA. Las páginas de Entra se leyeron desde el repositorio público MicrosoftDocs/entra-docs el 18 de octubre de 2026.
