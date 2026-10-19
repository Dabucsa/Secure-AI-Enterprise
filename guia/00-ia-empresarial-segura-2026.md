# IA Empresarial Segura 2026 — Libro de estudio

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Arquitecturas, seguridad, gobierno e identidad para IA generativa y agentes — visión de mercado + implementación en Microsoft

Oct 17, 2026 · Danilo Bustamante

## 0. Cómo usar este libro

En 2026 la IA empresarial ya no es “un chat con un modelo”: son **agentes con identidad, herramientas y acceso a datos**. Por eso la seguridad se movió a cuatro frentes: el **gateway** por donde pasa todo el tráfico de IA, la **identidad** de cada agente, la **protección de los datos** que los agentes pueden leer y el **gobierno** continuo de qué existe y quién responde por ello.

Cada capítulo va en el mismo orden: primero el concepto **agnóstico de fabricante** (cómo lo resuelve el mercado), después **cómo se implementa en Microsoft**, y al final unas preguntas de repaso. Los productos cambian de nombre cada seis meses; los conceptos no. Estudia los conceptos y usa los nombres de producto como ejemplos.

### Índice

- [1. Panorama 2026: cómo adoptan IA las empresas](#1-panorama-2026-cómo-adoptan-ia-las-empresas)
- [2. Arquitectura de referencia de IA empresarial](#2-arquitectura-de-referencia-de-ia-empresarial)
- [3. AI gateways y API management para IA](#3-ai-gateways-y-api-management-para-ia)
- [4. Amenazas: qué se ataca y cómo](#4-amenazas-qué-se-ataca-y-cómo)
- [5. Controles de seguridad por capa y diseño de agentes seguros](#5-controles-de-seguridad-por-capa-y-diseño-de-agentes-seguros)
- [6. Identidad para IA y agentes](#6-identidad-para-ia-y-agentes)
- [7. Protección de datos para IA](#7-protección-de-datos-para-ia)
- [8. MCP y A2A: los protocolos de los agentes](#8-mcp-y-a2a-los-protocolos-de-los-agentes)
- [9. El stack de Microsoft a fondo](#9-el-stack-de-microsoft-a-fondo)
- [10. Gobierno de IA: marcos, regulación y modelo operativo](#10-gobierno-de-ia-marcos-regulación-y-modelo-operativo)
- [11. Operaciones de seguridad para IA](#11-operaciones-de-seguridad-para-ia)
- [12. Casos de uso y escenarios comunes en empresas](#12-casos-de-uso-y-escenarios-comunes-en-empresas)
- [13. Roadmap de 90 días, modelo de madurez y checklist](#13-roadmap-de-90-días-modelo-de-madurez-y-checklist)
- [14. Ruta de estudio, certificaciones, glosario y fuentes](#14-ruta-de-estudio-certificaciones-glosario-y-fuentes)

### Pestañas del libro

Los capítulos dan la visión completa; las pestañas profundizan un tema o sirven para practicar y repasar.

| Pestaña | Qué tiene | Úsala para |
| --- | --- | --- |
| [Repaso en una página](01-repaso-en-una-pagina.md) | 20 ideas clave, las tres listas OWASP, el mapa de Microsoft, fechas y siglas | Repasar en 15 minutos antes de un examen o una reunión |
| [Respuestas de repaso](02-respuestas-de-repaso.md) | Respuestas modelo a todas las preguntas de repaso | Corregirte después de responder |
| [MCP a fondo](03-mcp-a-fondo.md) | Especificación, autorización, ataques, servidor protegido con Entra ID y gobierno de MCP | Diseñar o auditar servidores y clientes MCP |
| [A2A a fondo](04-a2a-a-fondo.md) | A2A 1.0, Agent Cards firmadas, riesgos y controles entre agentes | Conectar agentes con socios externos |
| [Memoria y extensibilidad](15-memoria-y-extensibilidad.md) | Memoria de agentes, su envenenamiento y la extensibilidad de Copilot | Gobernar agentes de Copilot, conectores y acciones |
| [Agentes con Entra](05-agentes-con-entra.md) | Cómo se autentica un agente con Entra Agent ID: flujos, código con varios SDK, qué se puede y qué no, mitos y errores | Escribir un agente que llame modelos y APIs sin claves |
| [Defender para IA](06-defender-para-ia.md) | MDE, MDA, Defender for Cloud y Agent 365 frente a la IA: agentes locales, shadow AI, consultas KQL, límites y licencias | Saber qué detecta y qué bloquea cada Defender, y qué no |
| [Purview para IA](07-purview-para-ia.md) | DSPM, DLP para Copilot, equipo, navegador y red, etiquetas y oversharing, Insider Risk, auditoría, retención, API para apps propias y licencias | Proteger los datos que entran y salen de la IA |
| [Visibilidad de agentes](08-visibilidad-de-agentes.md) | Quién ve qué de cada tipo de agente, ID Protection para agentes, cuatro escenarios de ataque de punta a punta y el patrón para cerrar brechas | Responder “si un agente hace algo malo, ¿lo vemos?” |
| [Landing zone de IA](09-landing-zone-de-ia.md) | Controles por capa con su evidencia, el módulo de políticas del repositorio, implementaciones de referencia de Microsoft y lista de revisión | Diseñar o revisar la landing zone de IA de un cliente |
| [Marcos y cómo aplicarlos](10-marcos-y-como-aplicarlos.md) | Qué pregunta responde cada marco, el dominio de IA de MCSB v2, Zero Trust para IA, una tabla de controles entre marcos y un modelo de madurez | Elegir y combinar marcos en un proyecto y medir al cliente |
| [Proyectos de cliente](11-proyectos-de-cliente.md) | Ocho guías por tipo de proyecto con preguntas de descubrimiento, controles mínimos, licencias, entregables y criterios de aceptación | Preparar y ejecutar un proyecto de seguridad de IA con un cliente |
| [Kit del consultor](12-kit-del-consultor.md) | Cuestionario de 24 preguntas con puntaje, cuatro talleres, plantilla de informe, hoja de ruta de 90 días, objeciones y hoja de licencias | Evaluar a un cliente y presentar resultados |
| [Ruta de referente](13-ruta-de-referente.md) | Siete tesis, plan de seis meses, demostración de 20 minutos, rutina de actualización y cómo responder como referente | Convertirte en la persona de referencia en seguridad de IA con Microsoft |
| [Casos de experto](14-casos-de-experto.md) | Cinco casos integrados (banco, fintech, retailer, incidente con agentes de programación, multinacional) con respuestas modelo | Probar tu criterio con situaciones completas |
| [Ataques con IA](16-ataques-con-ia.md) | Deepfakes, phishing con LLM, malware que usa IA, agentes atacantes y LLMjacking | Defenderte de atacantes que usan IA |
| [Residencia y LatAm](17-residencia-y-latam.md) | Residencia de datos en Azure y Copilot, leyes de seis países y plantilla de DPIA | Usar IA con datos personales desde Latinoamérica |
| [Laboratorios](18-laboratorios.md) | 24 prácticas con enunciado y resolución, la mayoría gratis | Practicar en tu computadora, en Azure, AWS o Google Cloud |
| [Mapa de certificaciones](19-mapa-de-certificaciones.md) | Qué capítulo cubre cada dominio de diez certificaciones | Preparar un examen |
| [Registro de cambios](20-registro-de-cambios.md) | Todos los cambios del libro, con fecha | Ver qué se actualizó desde tu última lectura |

### Rutas de lectura

| Si tu rol es… | Lee en este orden | Enfócate en |
| --- | --- | --- |
| Arquitecto/a de seguridad o cloud | 1 → 2 → 3 → 5 → 6 → 8 → 12; después [MCP a fondo](03-mcp-a-fondo.md), [A2A a fondo](04-a2a-a-fondo.md), [Memoria y extensibilidad](15-memoria-y-extensibilidad.md), [Agentes con Entra](05-agentes-con-entra.md), [Landing zone de IA](09-landing-zone-de-ia.md) y [Visibilidad de agentes](08-visibilidad-de-agentes.md) | Arquitectura de referencia, gateway, identidad de agentes, MCP |
| Ingeniero/a SOC o de detección | 4 → 11 → 9 (Defender, Sentinel) → 12; después [Defender para IA](06-defender-para-ia.md), [Visibilidad de agentes](08-visibilidad-de-agentes.md), [Ataques con IA](16-ataques-con-ia.md) y los labs 6, 10, 17 y 22 | Amenazas, telemetría, KQL, respuesta a incidentes de IA |
| Gobierno, riesgo y cumplimiento | 1 → 10 → 7 → 13; después [Residencia y LatAm](17-residencia-y-latam.md) y [Marcos y cómo aplicarlos](10-marcos-y-como-aplicarlos.md) | Marcos, regulación, inventario, modelo operativo |
| Administrador/a de Microsoft 365 | 7 → 9 (M365 Copilot, Purview, Agent 365) → 12; después [Memoria y extensibilidad](15-memoria-y-extensibilidad.md), [Purview para IA](07-purview-para-ia.md) y [Proyectos de cliente](11-proyectos-de-cliente.md) | Oversharing, etiquetas, DLP, ciclo de vida de agentes |
| CISO o líder de seguridad | 1 → 10 → 13 → 12; después [Marcos y cómo aplicarlos](10-marcos-y-como-aplicarlos.md), [Ataques con IA](16-ataques-con-ia.md), [Residencia y LatAm](17-residencia-y-latam.md) y [Kit del consultor](12-kit-del-consultor.md) | Riesgo, prioridades, roadmap |
| Consultor/a o futuro referente | [Ruta de referente](13-ruta-de-referente.md) → [Marcos y cómo aplicarlos](10-marcos-y-como-aplicarlos.md) → [Proyectos de cliente](11-proyectos-de-cliente.md) → [Kit del consultor](12-kit-del-consultor.md) → [Casos de experto](14-casos-de-experto.md); los capítulos y pestañas técnicas según cada proyecto | Evaluar clientes, diseñar proyectos y defender recomendaciones con evidencia |

### Qué cambió si estudiaste en 2023–2024

| Lo que estudiaste | Cómo se llama o funciona hoy | Qué implica |
| --- | --- | --- |
| Azure AI Studio | Azure AI Foundry (nov 2024) y luego **Microsoft Foundry** (Ignite, nov 2025) | Un solo portal y recurso para modelos, agentes, evaluaciones y guardrails |
| Azure OpenAI como servicio aparte | Azure OpenAI vive dentro de Foundry junto a modelos de otros proveedores (Anthropic, Meta, Mistral, xAI, DeepSeek y más) | El problema ya no es “un modelo” sino un catálogo multi-modelo que hay que gobernar |
| Azure AI Agent Service | **Foundry Agent Service** | Agentes gestionados con herramientas, memoria, MCP y A2A |
| Semantic Kernel y AutoGen por separado | **Microsoft Agent Framework** (los fusiona; anunciado oct 2025) | Un SDK para agentes y orquestación multi-agente |
| Agentes que corren con service principals genéricos o API keys | **Microsoft Entra Agent ID**: identidad propia para cada agente | Conditional Access, gobierno de identidades y auditoría aplicados a agentes |
| Sin inventario central de agentes | **Microsoft Agent 365** como plano de control de agentes (Ignite, nov 2025) | Registro, acceso, visualización, interoperabilidad y seguridad de agentes de cualquier origen |
| Security Copilot pagado por SCU | Security Copilot **incluido en Microsoft 365 E5**, con agentes propios y de partners (anunciado en Ignite 2025) | IA en el SOC deja de ser un piloto caro |
| “AI Hub” de Purview | **DSPM for AI** dentro de Purview | Visibilidad de prompts, respuestas y datos sensibles en Copilot, agentes y apps de IA de terceros |
| Certificación SC-400 | **SC-401** (Information Security Administrator) | Incluye protección de datos para Copilot y apps de IA |
| Sentinel solo sobre Log Analytics | Sentinel con **data lake**, **graph** y **servidor MCP**, gestionado desde el portal de Defender | Datos baratos a largo plazo y agentes que consultan el SIEM |
| “Capacidades GenAI” en API Management | **AI gateway** de Azure API Management, que también expone y gobierna servidores MCP | El gateway es el punto de control para modelos *y* herramientas |
| OWASP Top 10 for LLM 2023 | **OWASP Top 10 for LLM Applications 2025** + **OWASP Top 10 for Agentic Applications** (dic 2025) | Riesgos nuevos: system prompt leakage, embeddings, agencia excesiva, abuso de herramientas |
| Prompt injection como curiosidad | Vulnerabilidades reales con CVE en productos empresariales (por ejemplo EchoLeak en M365 Copilot, 2025) | Se trata como una clase de vulnerabilidad que no se puede eliminar, solo contener |

**Regla de oro para estudiar:** antes de diseñar algo, verifica en Microsoft Learn si la función está en *preview* o es *GA*, y en qué licencia está. Este libro está actualizado a la fecha del encabezado; las secciones con cambios más rápidos (Agent 365, Entra Agent ID, especificación MCP) son las primeras que debes re-verificar.

## 1. Panorama 2026: cómo adoptan IA las empresas

Las empresas grandes ya tienen agentes en producción o en piloto, pero el control va detrás de la adopción. En una encuesta a 266 líderes tecnológicos, el 42% ya tiene agentes en producción y el 60% no tiene un marco formal de gobierno de IA o está en etapa temprana ([Mayfield, 2026](https://www.mayfield.com/the-agentic-enterprise-in-2026/)). Otra encuesta a 919 profesionales encontró que solo el 22% trata a los agentes como identidades propias; el resto usa API keys compartidas ([Gravitee, 2026](https://www.gravitee.io/hubfs/Downloadable%20Resource/state_of_ai_agent_security_report_pdf_2026.pdf)). Ambas son encuestas de proveedores: úsalas como señal de tendencia, no como dato exacto.

### Los siete patrones de adopción que verás en cualquier empresa

| Patrón | Ejemplos reales | Quién controla el stack | Riesgo dominante |
| --- | --- | --- | --- |
| 1. Copilots SaaS embebidos | Microsoft 365 Copilot, Gemini en Workspace, Salesforce Agentforce, ServiceNow Now Assist | El proveedor; tú configuras el tenant | Oversharing: la IA encuentra lo que el usuario ya podía ver pero nunca encontraba |
| 2. Asistentes de IA de propósito general | ChatGPT Enterprise, Claude Enterprise, Copilot Chat | El proveedor; tú controlas SSO, conectores y retención | Datos sensibles pegados en prompts; conectores a datos internos |
| 3. “GPT interno” multi-modelo | Portal propio sobre Azure OpenAI, Bedrock, Vertex o Anthropic API detrás de un gateway | Tú (aplicación y gateway) | Costo descontrolado, logging de datos sensibles, claves compartidas |
| 4. RAG sobre conocimiento interno | Chat sobre políticas, manuales, contratos, tickets | Tú | Fuga por permisos mal aplicados en el índice; inyección indirecta desde documentos |
| 5. Agentes que ejecutan acciones | Agentes de ITSM, compras, cobranza, atención al cliente; Copilot Studio, Foundry Agent Service | Tú (o low-code de negocio) | Agencia excesiva: el agente hace algo irreversible con permisos amplios |
| 6. Agentes de código y agentes locales | GitHub Copilot, Claude Code, OpenAI Codex, Cursor; servidores MCP locales | El desarrollador en su endpoint | Ejecución de comandos, secretos expuestos, cadena de suministro de herramientas |
| 7. Shadow AI | Apps de IA no aprobadas, extensiones de navegador, agentes personales | Nadie | Fuga de datos sin visibilidad |

La mayoría de las empresas tiene los siete patrones a la vez. Un programa de seguridad de IA que solo cubre el patrón 3 (lo que construye TI) deja fuera la mayor parte del riesgo.

### Siete tendencias que cambiaron la seguridad de IA en 2025–2026

1. **De chat a agentes.** El modelo ya no solo responde: planifica, llama herramientas (por MCP), delega a otros agentes (por A2A) y guarda memoria. Cada herramienta es un permiso.
2. **Proliferación de agentes (agent sprawl).** Los crean TI, negocio con low-code y desarrolladores en su máquina. En Build 2026 Microsoft anunció que el registro de Agent 365 descubre más de 20 tipos de agentes locales, incluidos agentes de código y servidores MCP ([Microsoft Security Blog, jun 2026](https://www.microsoft.com/en-us/security/blog/2026/06/02/microsoft-build-2026-securing-code-agents-and-models-across-the-development-lifecycle/)).
3. **El agente es una identidad.** Los proveedores de identidad crearon tipos de identidad específicos para agentes (Microsoft Entra Agent ID, Okta para agentes de IA). El problema pasó de “qué modelo uso” a “quién es este agente, quién es su dueño y qué puede tocar”.
4. **El AI gateway se volvió plano de control.** Palo Alto Networks compró Portkey (cierre reportado el 29 de mayo de 2026) para usarlo como gateway central de Prisma AIRS ([Pulse 2.0](https://pulse2.com/palo-alto-networks-to-acquire-portkey-to-establish-ai-gateway-as-control-plane-for-autonomous-enterprise-agents/amp/)). Kong, F5, Cloudflare y Azure API Management ofrecen gateways específicos para IA.
5. **La seguridad de IA se consolidó en plataformas grandes.** Las startups de guardrails fueron compradas por los grandes de ciberseguridad (tabla abajo). Hoy la protección de IA viene como función de tu SASE, XDR, firewall o plataforma de identidad.
6. **La inyección de prompts se aceptó como no resoluble en el modelo.** Hay CVE reales en productos empresariales (EchoLeak en M365 Copilot, 2025). La industria diseña para *contener* el impacto, no para eliminar la inyección (capítulo 5).
7. **La regulación dejó de ser futura.** El EU AI Act ya obliga a proveedores de modelos de propósito general (desde agosto 2025) y a la transparencia del artículo 50 (desde agosto 2026); las obligaciones de alto riesgo se aplazaron a diciembre 2027 (capítulo 10).

### La consolidación del mercado de seguridad de IA

| Startup | Comprador | Año | Dónde vive hoy |
| --- | --- | --- | --- |
| Portkey (AI gateway) | Palo Alto Networks | 2026 | Gateway de Prisma AIRS |
| Lakera (guardrails, prompt injection) | Check Point | 2025 | Plataforma de seguridad de IA de Check Point |
| CalypsoAI (guardrails, red teaming) | F5 | 2025 | F5 AI Guardrails / Application Delivery |
| Pangea (guardrails como API) | CrowdStrike | 2025 | Falcon (protección de IA) |
| Prompt Security (uso de GenAI, shadow AI) | SentinelOne | 2025 | Singularity |
| Aim Security (uso seguro de IA) | Cato Networks | 2025 | SASE de Cato |
| Protect AI (escaneo de modelos, AI-SPM) | Palo Alto Networks | 2025 | Prisma AIRS |

Fuente de la consolidación 2025: [SiliconANGLE](https://siliconangle.com/2025/09/16/crowdstrike-check-point-extend-ai-security-capabilities-new-acquisitions/) y [CyberScoop](https://cyberscoop.com/check-point-lakera-acquistion-ai-security/). Para tu estudio, lo importante es el patrón: cuando evalúes una herramienta de seguridad de IA, pregúntate primero si tu plataforma actual ya la incluye.

### Modelo de responsabilidad compartida para IA

La responsabilidad depende de cuánto del stack operas tú. Microsoft lo divide en tres capas: **plataforma de IA** (modelo, entrenamiento, infraestructura), **aplicación de IA** (diseño, conectores, plugins, sistema de seguridad) y **uso de IA** (identidad, acceso, gobierno de datos, comportamiento del usuario). El mismo modelo aplica a AWS y Google.

| Capa | SaaS (ej. M365 Copilot, ChatGPT Enterprise) | PaaS (ej. Foundry, Bedrock, Vertex) | IaaS / modelo propio (ej. Llama en tus GPUs) |
| --- | --- | --- | --- |
| Uso: identidad, acceso, datos, formación de usuarios | **Cliente** | **Cliente** | **Cliente** |
| Aplicación: conectores, plugins, herramientas, diseño | Proveedor; el cliente configura conectores y agentes | **Cliente** | **Cliente** |
| Sistema de seguridad: filtros, guardrails | Proveedor | Compartido: el proveedor da filtros, el cliente los configura | **Cliente** |
| Modelo: entrenamiento, ajuste, seguridad del modelo | Proveedor | Proveedor (cliente si hace fine-tuning) | **Cliente** |
| Infraestructura de cómputo | Proveedor | Proveedor | Compartido con el cloud |

**Conclusión:** la capa de *uso* siempre es tuya. Aunque compres el copiloto más caro, el oversharing, la identidad y la clasificación de datos siguen siendo tu problema.

### Para repasar

1. ¿Por qué un programa de seguridad de IA que solo cubre las aplicaciones que construye TI deja fuera la mayor parte del riesgo?
2. En M365 Copilot, ¿qué capas del modelo de responsabilidad compartida son tuyas?
3. ¿Qué te dice la ola de adquisiciones de 2025–2026 sobre cómo comprar herramientas de seguridad de IA?

## 2. Arquitectura de referencia de IA empresarial

Una arquitectura de IA segura tiene cinco capas y un solo punto de paso obligatorio: todo el tráfico hacia modelos, herramientas y otros agentes pasa por un **AI gateway**. Cuatro controles —identidad, protección de datos, observabilidad y gobierno— atraviesan todas las capas. Si recuerdas un solo dibujo de este libro, que sea este.

&#91;embedded content: arquitectura de referencia · 5 capas, 1 gateway, 4 controles transversales\]

Las líneas punteadas indican que los controles transversales se aplican en cada capa, no en un solo punto. El gateway es el único lugar donde puedes aplicar política a *todo* el tráfico de IA, sin importar qué equipo construyó la aplicación.

### Qué hace cada capa y cómo se protege

| Capa | Qué resuelve | Controles clave | En Microsoft | Alternativas de mercado |
| --- | --- | --- | --- | --- |
| Usuarios y canales | Quién pide y desde dónde | SSO, MFA resistente a phishing, acceso condicional, dispositivo conforme | Entra ID, Intune, Teams | Okta, Ping, Google Identity |
| Aplicaciones y agentes | La lógica de negocio y la experiencia | Inventario, dueño responsable, mínimo privilegio, pruebas antes de publicar | M365 Copilot, Copilot Studio, Foundry Agent Service | Salesforce Agentforce, AWS Bedrock AgentCore, Google Gemini Enterprise, ServiceNow |
| Orquestación | Prompts, planificación, memoria, elección de herramientas | Prompts de sistema sin secretos, límite de pasos, aprobación humana en acciones sensibles, validación de salidas | Microsoft Agent Framework, Foundry Agent Service | LangGraph, LlamaIndex, CrewAI, OpenAI Agents SDK, Claude Agent SDK, Google ADK |
| AI gateway | Control del tráfico hacia modelos, MCP y A2A | Autenticación sin API keys, cuotas, enrutamiento, guardrails, logging, chargeback | Azure API Management (AI gateway) | Kong AI Gateway, Cloudflare AI Gateway, LiteLLM, Portkey (Palo Alto), Envoy AI Gateway, F5, Apigee |
| Modelos | La inferencia | Catálogo aprobado, filtros de contenido, tipo de despliegue según residencia, contrato sin entrenamiento con tus datos | Foundry Models (Azure OpenAI y modelos de terceros) | Amazon Bedrock, Google Vertex AI, APIs directas de OpenAI y Anthropic, vLLM propio |
| Datos y RAG | El conocimiento que alimenta las respuestas | Permisos en el índice (security trimming), etiquetas, control de envenenamiento, frescura | Azure AI Search, SharePoint y Microsoft Graph, Fabric, Purview | Elastic, Pinecone, pgvector, Databricks Vector Search, Glean |
| Herramientas | Las acciones que el agente puede ejecutar | Registro aprobado, tokens con alcance mínimo, aprobación humana en escrituras, sandbox | Servidores MCP detrás de API Management, Azure API Center, conectores de Power Platform | Registros MCP, gateways MCP de Kong o Cloudflare, AWS AgentCore Gateway |

### La AI landing zone

Una **AI landing zone** es tu landing zone de nube extendida para cargas de IA. Mantiene el modelo hub-spoke: el hub aloja el gateway, el firewall y la observabilidad compartida; cada aplicación de IA vive en su propio spoke con endpoints privados. Microsoft publica una implementación de referencia con plantillas Bicep y Terraform (AI Landing Zones, dentro del Cloud Adoption Framework), y AWS y Google tienen equivalentes (Generative AI Lens del Well-Architected y los blueprints de Vertex AI).

Los controles por capa con la evidencia de cada uno, las 12 políticas integradas de Azure Policy agrupadas en un módulo Bicep y la lista de revisión están en la pestaña Landing zone de IA.

| Decisión de diseño | Opción recomendada | Por qué |
| --- | --- | --- |
| Dónde va el gateway | En el hub, compartido por todas las aplicaciones | Una sola política y una sola fuente de telemetría para todo el tráfico de IA |
| Cómo se accede a los modelos | Endpoints privados, sin acceso público, autenticación con identidad administrada (sin API keys) | Elimina la clase de incidente más común: claves filtradas en código |
| Tipo de despliegue del modelo | Regional o de zona de datos cuando hay requisitos de residencia; global solo si el dato lo permite | Un despliegue global puede procesar la inferencia en cualquier región del proveedor |
| Logging de prompts y respuestas | Activado en el gateway, con redacción de datos personales, retención corta y acceso restringido | Necesitas investigar incidentes sin crear un nuevo repositorio de datos sensibles |
| Salida a internet | Firewall con lista permitida de endpoints de IA; bloqueo de servicios de IA no aprobados | Corta shadow AI y exfiltración por APIs de IA públicas |
| Multi-equipo y costos | Una suscripción del gateway por equipo o aplicación, con métricas de tokens por consumidor | Permite cuotas, chargeback y atribuir un abuso a su origen |
| Política como código | Iniciativas de Azure Policy que niegan acceso público y autenticación local en servicios de IA | El control se aplica a recursos nuevos sin depender de revisiones manuales |

Ejemplo en Bicep de una cuenta de Foundry endurecida, en la línea de lo que usarías en tus propias plantillas:

```bicep
resource foundry 'Microsoft.CognitiveServices/accounts@2025-06-01' = {
  name: foundryName
  location: location
  kind: 'AIServices'
  sku: { name: 'S0' }
  identity: { type: 'SystemAssigned' }
  properties: {
    customSubDomainName: foundryName
    allowProjectManagement: true
    disableLocalAuth: true            // sin API keys: solo Entra ID
    publicNetworkAccess: 'Disabled'   // solo por private endpoint
    networkAcls: { defaultAction: 'Deny' }
  }
}
```

Verifica la versión de API vigente antes de desplegar; las propiedades de Foundry cambiaron varias veces entre 2025 y 2026.

### Para repasar

1. ¿Por qué el gateway es el único punto donde puedes aplicar política a todo el tráfico de IA?
2. ¿Qué riesgo elimina `disableLocalAuth: true` y qué tienes que tener resuelto antes de activarlo?
3. ¿Cuándo elegirías un despliegue regional frente a uno global?

## 3. AI gateways y API management para IA

Un **AI gateway** es un proxy especializado entre quienes consumen IA (apps, agentes, usuarios) y quienes la proveen (modelos, servidores MCP, otros agentes), que entiende tokens, prompts y herramientas. En 2026 es el patrón estándar para gobernar IA a escala: Kong, F5, Cloudflare, Palo Alto Networks (con Portkey) y Microsoft (con Azure API Management) venden gateways específicos para IA.

### Por qué un API gateway clásico no alcanza

- **Mide peticiones, no tokens.** Una sola petición puede costar 100 tokens o 200.000.
- **No entiende streaming.** Las respuestas llegan por SSE en fragmentos; contar tokens o filtrar contenido exige procesar el stream.
- **No inspecciona significado.** Detectar inyección de prompts o datos personales requiere modelos clasificadores, no expresiones regulares.
- **No conoce MCP ni A2A.** Los agentes llaman herramientas y otros agentes con protocolos propios.
- **No traduce entre proveedores.** OpenAI, Anthropic, Bedrock y Vertex usan formatos distintos.

### Las doce funciones de un AI gateway

| # | Función | Qué resuelve | Riesgo que mitiga |
| --- | --- | --- | --- |
| 1 | Autenticación centralizada | El consumidor se autentica con su identidad; el gateway guarda las credenciales del proveedor | API keys filtradas en código |
| 2 | Autorización por consumidor | Qué equipo o agente puede usar qué modelo o herramienta | Uso de modelos no aprobados |
| 3 | Límites y cuotas de tokens | Tokens por minuto y cuotas diarias o mensuales por consumidor | Consumo ilimitado y “denial of wallet” (OWASP LLM10) |
| 4 | Enrutamiento, balanceo y failover | Capacidad reservada primero, pago por uso después; otra región si una falla | Caídas y throttling del proveedor |
| 5 | API unificada multi-proveedor | Un solo formato para varios modelos | Dependencia de un proveedor |
| 6 | Guardrails de entrada | Detección de inyección, jailbreak, datos personales, temas prohibidos | OWASP LLM01 y LLM02 |
| 7 | Guardrails de salida | Contenido dañino, datos sensibles, material protegido | Fuga de datos y daño reputacional |
| 8 | Caché semántica | Responde preguntas parecidas desde caché | Costo y latencia (pero ojo con fugas entre usuarios) |
| 9 | Logging y trazas | Prompts, respuestas, tokens, latencia, herramientas llamadas | Falta de evidencia forense |
| 10 | Métricas y chargeback | Tokens y costo por equipo, app o agente | Costos sin dueño |
| 11 | Gobierno de MCP y A2A | Registro, exposición y política por herramienta y por agente | Herramientas no aprobadas y abuso de herramientas |
| 12 | Redacción y residencia | Enmascarar datos personales y enrutar por región | Incumplimiento de privacidad y soberanía |

### Dos gateways distintos que no debes confundir

1. **Gateway de aplicaciones (app → modelo/herramienta).** Controla el tráfico que generan *tus* aplicaciones y agentes. Ejemplos: Azure API Management, Kong, LiteLLM.
2. **Control de acceso de usuarios a IA pública (usuario → ChatGPT, Gemini, etc.).** Lo resuelven el SSE/SASE, el CASB, el navegador empresarial y el DLP de endpoint. Ejemplos: Microsoft Entra Internet Access, Defender for Cloud Apps, Edge for Business, Zscaler, Netskope, Palo Alto Prisma Access.

Un programa completo necesita los dos. El primero gobierna lo que construyes; el segundo, lo que tus empleados usan (capítulo 7, shadow AI).

### Patrones de despliegue

| Patrón | Cuándo usarlo | Ventaja | Cuidado con |
| --- | --- | --- | --- |
| Gateway central en el hub | Opción por defecto en empresas | Una política y una telemetría para todo | Punto único de falla: despliégalo multi-zona o multi-región |
| Federado (un gateway por unidad de negocio, plano de control central) | Grupos grandes o con subsidiarias | Autonomía local con estándares comunes | Deriva de políticas entre gateways |
| Embebido en Kubernetes (sidecar o ingress) | Equipos de plataforma que ya operan Kubernetes | Baja latencia, todo en tu control | Operación y parches a tu cargo |
| SaaS en el edge | Startups o multi-cloud simple | Cero infraestructura | Residencia de logs y dependencia de un tercero con tus prompts |

### El mercado en 2026

| Producto | Tipo | Fortalezas | Considera |
| --- | --- | --- | --- |
| [Azure API Management](https://learn.microsoft.com/azure/api-management/genai-gateway-capabilities) | Gestionado (Azure) | Integración con Foundry y Entra ID, políticas de tokens y content safety, MCP y A2A | El nuevo tier AI Gateway sigue en preview |
| Kong AI Gateway | Self-hosted o Konnect | Plugins de IA (proxy, prompt guard, caché semántica, sanitizador de PII); la versión 3.14 (abr 2026) añadió un Agent Gateway para MCP y A2A ([Hexaware](https://hexaware.com/blogs/kong-ai-gateway-and-mcp-securing-and-scaling-agentic-ai-in-the-enterprise/)) | Funciones avanzadas en tiers Enterprise |
| Cloudflare AI Gateway | SaaS en el edge | Caché, rate limiting, logging y guardrails sin infraestructura | Residencia de logs |
| LiteLLM | Open source (MIT) | Claves virtuales, presupuestos, más de 100 proveedores, gateway MCP | Lo operas tú; rendimiento bajo carga sostenida |
| Portkey (Palo Alto Networks) | SaaS o VPC | Gateway con observabilidad y guardrails; ahora núcleo de Prisma AIRS | Hoja de ruta ligada a Palo Alto |
| Envoy AI Gateway | Open source sobre Envoy | Nativo de Kubernetes, rate limiting por tokens | Madurez y soporte comercial |
| Apigee (Google) | Gestionado | Políticas para LLM e integración con Model Armor | Mejor encaje si ya usas Google Cloud |
| AWS Bedrock AgentCore Gateway | Gestionado (AWS) | Convierte APIs y funciones Lambda en herramientas MCP | Centrado en el ecosistema AWS |
| F5 AI Gateway y AI Guardrails | Appliance o SaaS | Guardrails de CalypsoAI, encaje con redes F5 | Mejor encaje si ya usas F5 |

Las comparativas de mercado de 2026 suelen estar escritas por proveedores de gateways; usa la tabla como mapa, no como ranking.

### Implementación en Microsoft: Azure API Management como AI gateway

**Qué tienes hoy (octubre 2026):**

- **Backends de modelos:** Foundry y Azure OpenAI, más Anthropic y Google Vertex AI en GA, y Amazon Bedrock y endpoints compatibles con OpenAI. Una **Unified Model API** (preview) expone un solo formato y traduce a cada backend ([notas de versión de APIM](https://github.com/Azure/API-Management/releases)).
- **Pools de backends** con prioridad y peso, y **circuit breaker** para hacer failover de capacidad reservada (PTU) a pago por uso o a otra región.
- **Políticas de IA:** `llm-token-limit` (TPM y cuotas por periodo; desde marzo 2026 también a nivel de despliegue), `llm-emit-token-metric`, `llm-semantic-cache-lookup` y `llm-semantic-cache-store`, y `llm-content-safety` con Prompt Shields.
- **MCP y A2A:** exponer una API REST como servidor MCP, publicar servidores MCP existentes, agruparlos en productos y versionarlos; las APIs de agentes A2A son GA desde la versión de junio 2026. Desde esa versión, `llm-content-safety` también inspecciona argumentos de herramientas MCP, respuestas MCP y mensajes A2A.
- **Integración con Foundry:** puedes asociar un AI gateway a un recurso de Foundry y definir cuotas de tokens por proyecto desde Foundry.
- **Tier AI Gateway (preview desde el 27 de julio de 2026):** experiencia dedicada a modelos, servidores MCP y herramientas, con políticas en tarjetas en lugar de XML; solo East US 2 y Sweden Central durante la preview ([InfoQ](https://infoq.com/news/2026/08/azure-apim-ai-gateway-tier)). No es para producción hasta su GA.

**Política de ejemplo** para un chat interno: identidad del consumidor, identidad administrada al backend, límite de tokens, guardrails, métricas para chargeback y caché aislada por consumidor.

```xml
<policies>
  <inbound>
    <base />
    <!-- 1. Solo apps registradas en Entra ID pueden llamar -->
    <validate-azure-ad-token tenant-id="{{tenant-id}}">
      <client-application-ids>
        <application-id>{{app-chat-interno}}</application-id>
      </client-application-ids>
    </validate-azure-ad-token>
    <!-- 2. Sin API keys hacia el modelo: identidad administrada -->
    <authentication-managed-identity resource="https://cognitiveservices.azure.com" />
    <!-- 3. Tokens por minuto por suscripción del gateway -->
    <llm-token-limit counter-key="@(context.Subscription.Id)"
        tokens-per-minute="20000" estimate-prompt-tokens="false"
        remaining-tokens-header-name="x-remaining-tokens" />
    <!-- 4. Prompt Shields + categorías de contenido -->
    <llm-content-safety backend-id="content-safety" shield-prompt="true">
      <categories output-type="EightSeverityLevels">
        <category name="Hate" threshold="4" />
        <category name="Violence" threshold="4" />
      </categories>
    </llm-content-safety>
    <!-- 5. Caché semántica PARTICIONADA por consumidor -->
    <llm-semantic-cache-lookup score-threshold="0.05"
        embeddings-backend-id="embeddings" embeddings-backend-auth="system-assigned">
      <vary-by>@(context.Subscription.Id)</vary-by>
    </llm-semantic-cache-lookup>
    <!-- 6. Métricas de tokens para chargeback -->
    <llm-emit-token-metric namespace="ai-gateway">
      <dimension name="Subscription ID" />
    </llm-emit-token-metric>
    <set-backend-service backend-id="pool-openai" />
  </inbound>
  <outbound>
    <base />
    <llm-semantic-cache-store duration="300" />
  </outbound>
</policies>
```

El pool de backends con prioridad, en Bicep:

```bicep
resource pool 'Microsoft.ApiManagement/service/backends@2024-06-01-preview' = {
  parent: apim
  name: 'pool-openai'
  properties: {
    type: 'Pool'
    pool: {
      services: [
        { id: ptuSwedenCentral.id, priority: 1 }              // capacidad reservada primero
        { id: paygoEastUs2.id, priority: 2, weight: 50 }      // desborde repartido
        { id: paygoWestEurope.id, priority: 2, weight: 50 }
      ]
    }
  }
}
```

### Anti-patrones frecuentes

- **El gateway existe, pero el endpoint del modelo sigue público.** Si una app puede saltarse el gateway, el gateway no controla nada. Cierra el acceso público y desactiva las API keys del modelo.
- **Caché semántica compartida entre usuarios con permisos distintos.** Un usuario puede recibir una respuesta generada con datos que no le corresponden. Particiona la caché (`vary-by`) o no la uses en apps con RAG sobre datos con permisos.
- **Logging completo de prompts sin control.** El log se convierte en el repositorio más sensible de la empresa. Redacta, limita la retención y restringe el acceso.
- **Gateway solo para modelos.** Los agentes llaman herramientas y APIs directamente y el gateway no ve las acciones, que es donde está el riesgo.
- **Guardrails solo de entrada.** La inyección indirecta llega por documentos y respuestas de herramientas, no por el prompt del usuario.

### Para repasar

1. Nombra tres cosas que un AI gateway hace y un API gateway clásico no.
2. ¿Por qué la caché semántica puede convertirse en un canal de fuga de datos?
3. ¿Qué diferencia hay entre el gateway de aplicaciones y el control de acceso de usuarios a IA pública, y qué producto de Microsoft cubre cada uno?

## 4. Amenazas: qué se ataca y cómo

El problema de fondo de la IA generativa es que **el modelo no separa instrucciones de datos**: cualquier texto que lee —un correo, una página web, la respuesta de una herramienta— puede comportarse como una orden. Si además el agente tiene acceso a datos privados y una forma de enviar información hacia afuera, la exfiltración es posible aunque ningún componente tenga un “bug” clásico.

### Dos reglas mentales que usa toda la industria

**La trifecta letal** (Simon Willison, 2025). Un agente es explotable para robar datos cuando combina tres cosas:

1. Acceso a datos privados.
2. Exposición a contenido no confiable.
3. Capacidad de comunicarse hacia afuera (enviar correo, llamar una URL, renderizar una imagen remota).

Quita cualquiera de las tres y la exfiltración por inyección deja de ser posible.

**La regla de dos para agentes** (Meta, octubre 2025). En una misma sesión, un agente debería cumplir como máximo dos de estas tres propiedades; si necesita las tres, requiere supervisión humana o un diseño que las separe:

- **\[A\]** procesa entradas no confiables;
- **\[B\]** accede a sistemas sensibles o datos privados;
- **\[C\]** cambia estado o se comunica externamente.

Ambas reglas convierten un problema sin solución en el modelo (la inyección) en un problema de **arquitectura** que sí puedes resolver.

### OWASP Top 10 for LLM Applications 2025

| ID | Riesgo | Ejemplo | Control principal |
| --- | --- | --- | --- |
| LLM01 | Prompt injection | Un correo con instrucciones ocultas hace que el asistente reenvíe datos | Separar contenido no confiable, mínimo privilegio, aprobación humana en acciones |
| LLM02 | Divulgación de información sensible | El chat devuelve salarios porque el índice RAG los tenía | Permisos en el índice, etiquetas, DLP de salida |
| LLM03 | Cadena de suministro | Modelo descargado con código malicioso en pickle; paquete MCP comprometido | Escaneo de modelos, registro aprobado, versiones fijadas |
| LLM04 | Envenenamiento de datos y modelos | Documentos plantados en SharePoint que el RAG usa como verdad | Control de quién escribe en las fuentes, procedencia, revisión |
| LLM05 | Manejo inseguro de salidas | La salida del modelo se ejecuta como SQL, HTML o comando | Tratar la salida como entrada de usuario: validar, escapar, sandbox |
| LLM06 | Agencia excesiva | Un agente con permiso de borrar cuando solo debía leer | Herramientas mínimas, permisos mínimos, aprobación humana |
| LLM07 | Fuga del prompt de sistema | El atacante extrae el prompt y encuentra credenciales o reglas internas | Nunca poner secretos ni lógica de autorización en el prompt |
| LLM08 | Debilidades de vectores y embeddings | Un índice vectorial compartido entre clientes filtra datos entre ellos | Particionar índices, filtrar por permisos en la consulta |
| LLM09 | Desinformación | Respuesta inventada (alucinación) usada en una decisión legal | Grounding, citas, evaluaciones, revisión humana |
| LLM10 | Consumo ilimitado | Bucle de agente o atacante que agota cuota y presupuesto | Límites de tokens, pasos y costo por consumidor |

### OWASP Top 10 for Agentic Applications 2026

Publicado en diciembre de 2025 por el OWASP GenAI Security Project, cubre los riesgos que aparecen cuando el sistema planifica, usa herramientas, guarda memoria y coordina con otros agentes ([resumen de Promptfoo](https://www.promptfoo.dev/docs/red-team/owasp-agentic-ai/), [análisis de identidad de Descope](https://www.descope.com/blog/post/owasp-agentic-top-10-identity)).

| ID | Riesgo | Qué significa | Control principal |
| --- | --- | --- | --- |
| ASI01 | Secuestro del objetivo del agente | El atacante cambia la meta del agente, casi siempre por inyección indirecta | Separar instrucciones de datos, verificar el plan contra la tarea original |
| ASI02 | Mal uso de herramientas | El agente usa mal herramientas que sí tiene permitidas | Herramientas con alcance estrecho, validación de argumentos, límites por herramienta |
| ASI03 | Abuso de identidad y privilegios | El agente hereda sesiones, tokens o claves de quien lo invoca y escala | Identidad propia por agente, tokens delegados y de corta vida |
| ASI04 | Cadena de suministro agéntica | Servidores MCP, plugins, skills o modelos comprometidos | Registro aprobado, firma, versiones fijadas, revisión de cambios |
| ASI05 | Ejecución inesperada de código | El agente genera y ejecuta código que termina en RCE | Sandbox aislado, sin credenciales en el entorno, salida de red restringida |
| ASI06 | Envenenamiento de memoria y contexto | Se corrompe la memoria o el RAG y afecta sesiones futuras | Memoria con procedencia, expiración y separación por usuario |
| ASI07 | Comunicación insegura entre agentes | Mensajes A2A falsificados o sin autenticar | Autenticación mutua, firmas, autorización por agente |
| ASI08 | Fallas en cascada | El error de un agente se propaga por una cadena de agentes | Límites, circuit breakers, validación entre etapas |
| ASI09 | Explotación de la confianza humano-agente | El humano aprueba sin leer porque “el agente siempre acierta” | Aprobaciones con contexto claro, fricción en acciones de alto impacto |
| ASI10 | Agentes deshonestos (rogue) | Un agente comprometido o desalineado actúa como un insider | Inventario, monitoreo de comportamiento, kill switch |

### MITRE ATLAS

ATLAS es el equivalente de ATT&CK para sistemas de IA: tácticas, técnicas, mitigaciones y casos reales. Úsalo para mapear detecciones y ejercicios de red team, igual que haces con ATT&CK. Según un análisis de la versión v2026.09 (15 de septiembre de 2026), ATLAS tiene 16 tácticas, 120 técnicas y 88 subtécnicas, y la mayoría de las entradas nuevas son específicas de agentes ([Speakeasy](https://www.speakeasy.com/blog/mitre-atlas-explained)); confirma las cifras en el changelog oficial.

Técnicas que más verás en reglas de detección:

- **AML.T0051** LLM Prompt Injection (directa e indirecta).
- **AML.T0054** LLM Jailbreak.
- **AML.T0056** extracción del prompt de sistema.
- **AML.T0057** LLM Data Leakage.
- **AML.T0034** Cost Harvesting (abuso de tu cuota de IA).
- **AML.T0010** compromiso de la cadena de suministro de IA.

### Incidentes reales que debes conocer

| Fecha | Incidente | Qué pasó | Lección |
| --- | --- | --- | --- |
| ene 2026 | ShareLeak, Copilot Studio (CVE-2026-21520) | Inyección que exfiltraba datos desde agentes; según los investigadores, la exfiltración seguía funcionando tras el parche ([VentureBeat](https://venturebeat.com/security/microsoft-salesforce-copilot-agentforce-prompt-injection-cve-agent-remediation-playbook)) | Un parche no arregla una arquitectura con la trifecta letal |
| ene 2026 | CVEs en el servidor MCP de Git de Anthropic | Path traversal e inyección de argumentos ([CSA](https://labs.cloudsecurityalliance.org/research/csa-research-note-mcp-security-crisis-20260504-csa-styled/)) | Un servidor MCP es código con vulnerabilidades: aíslalo y actualízalo |
| nov 2025 | Campaña de espionaje orquestada con IA (GTG-1002) | Anthropic reportó que un grupo estatal usó Claude Code para automatizar la mayor parte de una campaña contra unas 30 organizaciones | Los atacantes también usan agentes: más velocidad y escala |
| sep 2025 | ForcedLeak, Salesforce Agentforce | Inyección por un formulario web y exfiltración a un dominio permitido que había expirado | Revisa listas de dominios permitidos y toda entrada pública |
| sep 2025 | Paquete malicioso postmark-mcp | Tras 15 versiones limpias, una actualización copiaba cada correo al atacante | Fija versiones y revisa cada actualización de servidores MCP |
| ago 2025 | s1ngularity (paquetes Nx comprometidos) | El malware invocó las CLIs de IA instaladas en la máquina del desarrollador para buscar secretos | Los agentes de código locales son herramienta del atacante |
| jul 2025 | mcp-remote (CVE-2025-6514, CVSS 9.6) | Un servidor MCP malicioso podía ejecutar comandos en el cliente | Conectarse a un servidor MCP no confiable puede ser RCE |
| jul 2025 | Extensión de Amazon Q Developer | Un pull request malicioso insertó un prompt que ordenaba borrar sistemas y llegó a una versión publicada | Los prompts de un agente son código: revísalos como tal |
| jun 2025 | EchoLeak, M365 Copilot (CVE-2025-32711, CVSS 9.3) | Zero-click: un correo con instrucciones ocultas hacía que Copilot filtrara datos por un dominio de Microsoft | Todo lo que el RAG lee es entrada no confiable |
| may 2025 | “Toxic agent flow” en el servidor MCP de GitHub | Un issue malicioso en un repo público llevaba al agente a filtrar repos privados | Un token amplio + contenido público = trifecta letal |

### Threat modeling para IA y agentes

Usa tu método habitual (STRIDE sobre un diagrama de flujo de datos) y añade **fronteras de confianza** nuevas: el prompt del usuario, el contenido recuperado, las respuestas de herramientas, la memoria y los mensajes entre agentes. Cada una es una entrada no confiable.

Marcos de apoyo:

- **CSA MAESTRO** (2025): modelado de amenazas en siete capas para agentes, desde el modelo base hasta el ecosistema de agentes.
- **Google SAIF** y su mapa de riesgos.
- **NIST AI 100-2 E2025**: taxonomía de ataques de machine learning adversarial.
- **Microsoft AI Red Team**: taxonomía de modos de falla en sistemas agénticos (2025).

**Seis preguntas para cada agente** antes de aprobarlo:

1. ¿Qué contenido no confiable lee?
2. ¿A qué datos sensibles llega?
3. ¿Qué acciones puede ejecutar y por qué canal puede sacar información?
4. ¿En nombre de quién actúa: del usuario, de sí mismo o de otro agente?
5. ¿Qué pasa si se equivoca? ¿Es reversible?
6. ¿Quién es su dueño y quién aprueba sus cambios?

Este capítulo trata a la IA como objetivo. La otra cara, la IA como arma del atacante (deepfakes, phishing escrito con LLM, malware que usa modelos, agentes atacantes y robo de claves de IA), está en Ataques con IA.

### Para repasar

1. Explica la trifecta letal con el caso EchoLeak.
2. ¿En qué se diferencian LLM06 (agencia excesiva) y ASI02 (mal uso de herramientas)?
3. Un agente lee tickets de clientes, consulta la base de clientes y puede enviar correos. ¿Cuántas propiedades de la regla de dos cumple y qué cambiarías?

## 5. Controles de seguridad por capa y diseño de agentes seguros

Ningún control aislado detiene la inyección de prompts. Lo que funciona es defensa en profundidad con un principio rector: **diseña para que un modelo engañado no pueda causar un daño grave**. Los clasificadores reducen la probabilidad del ataque; la arquitectura limita su impacto.

### Seis capas de control

| Capa | Controles | Qué detiene | En Microsoft | En el mercado |
| --- | --- | --- | --- | --- |
| 1. Identidad y acceso | Identidad propia por agente, mínimo privilegio, tokens delegados y de corta vida, acceso condicional | Escalada de privilegios (ASI03) | Entra Agent ID, Conditional Access para agentes, identidades administradas | Okta para agentes de IA, SPIFFE/SPIRE, AWS AgentCore Identity |
| 2. Entrada | Detección de inyección directa e indirecta, spotlighting del contenido no confiable, detección de datos personales | Inyección (LLM01), fuga de datos al modelo | Prompt Shields, guardrails de Foundry, DLP de Purview en prompts | Lakera (Check Point), AWS Bedrock Guardrails, Google Model Armor, Llama Guard |
| 3. Modelo y orquestación | Prompt de sistema sin secretos, límite de pasos y tokens, salidas estructuradas, verificación del plan | Secuestro del objetivo (ASI01), consumo ilimitado | Foundry Agent Service, Agent Framework, task adherence | LangGraph, frameworks de agentes |
| 4. Herramientas y acciones | Lista permitida, parámetros acotados, aprobación humana, acciones reversibles, sandbox, salida de red restringida | Agencia excesiva (LLM06), mal uso de herramientas (ASI02), RCE (ASI05) | Aprobación de herramientas MCP en Foundry, API Management, Container Apps dynamic sessions, Windows 365 for Agents | Gateways MCP, E2B, microVMs Firecracker, gVisor |
| 5. Salida | Filtros de contenido, groundedness, material protegido, DLP, saneamiento de URLs e imágenes | Fuga de datos, exfiltración por enlaces, desinformación | Content filters, groundedness detection, protected material, Purview DLP | Guardrails del gateway, NeMo Guardrails |
| 6. Monitoreo y respuesta | Trazas completas, detección de anomalías, evaluaciones continuas, kill switch | Agentes deshonestos (ASI10), abuso sostenido | Defender for Cloud (AI threat protection), Sentinel, Agent 365 | Plataformas AI-SPM y de observabilidad de LLM |

### Spotlighting: marcar lo que no es instrucción

Spotlighting, una técnica publicada por Microsoft Research en 2024, ayuda al modelo a distinguir instrucciones de datos. Tiene tres variantes:

1. **Delimitación:** encerrar el contenido no confiable entre marcadores y decirle al modelo que nunca siga instrucciones dentro de ellos.
2. **Datamarking:** intercalar un carácter especial en el texto no confiable (por ejemplo, entre palabras) para que el modelo lo reconozca como dato.
3. **Codificación:** pasar el contenido codificado (por ejemplo, en base64) y pedir al modelo que lo decodifique solo para analizarlo.

Reduce mucho la tasa de éxito de la inyección indirecta, pero no la elimina. Es una capa, no una solución.

### Seis patrones de diseño resistentes a inyección

El paper *Design Patterns for Securing LLM Agents against Prompt Injections* (2025, autores de IBM, Invariant Labs, ETH Zürich, Google y Microsoft) propone seis patrones. Todos aplican la misma idea: **una vez que el agente lee contenido no confiable, ese contenido no debe poder decidir qué acciones se ejecutan**.

| Patrón | Cómo funciona | Úsalo cuando | Costo |
| --- | --- | --- | --- |
| Action-Selector | El modelo solo elige entre acciones predefinidas; las respuestas de las herramientas no vuelven al modelo | Chatbots de servicio con acciones fijas | Poca flexibilidad |
| Plan-Then-Execute | El agente fija el plan antes de leer datos no confiables; los datos pueden cambiar parámetros, no acciones | Flujos con pasos conocidos (“lee mi calendario y envía un resumen a mi jefe”) | Un contenido malicioso aún puede alterar parámetros |
| LLM Map-Reduce | Cada documento no confiable lo procesa un sub-agente aislado que devuelve una salida acotada (sí/no, un número) | Clasificar o filtrar muchos documentos | Más llamadas al modelo |
| Dual LLM | Un modelo privilegiado (con herramientas) nunca ve el contenido no confiable; un modelo en cuarentena lo procesa y devuelve referencias simbólicas | Asistentes de correo o documentos con acciones | Complejidad de implementación |
| Code-Then-Execute | El modelo escribe un programa que llama herramientas; los datos no confiables viajan como variables con políticas de flujo (CaMeL, Google DeepMind 2025) | Agentes generales con requisitos altos de seguridad | El más complejo; requiere un intérprete controlado |
| Context-Minimization | Se elimina el prompt original del contexto tras convertirlo en una consulta estructurada | Consultas a bases de datos en lenguaje natural | Pierde contexto conversacional |

### Aprobación humana (human-in-the-loop) bien diseñada

La aprobación humana solo funciona si el humano entiende qué aprueba. Si aprueba todo por costumbre, es una casilla decorativa (ASI09).

- **Aprueba acciones, no conversaciones.** Muestra la acción exacta, sus parámetros y a dónde van los datos.
- **Escala por riesgo.** Leer no requiere aprobación; enviar fuera de la organización, pagar o borrar sí.
- **Evita la fatiga.** Si un flujo requiere aprobar diez veces por hora, rediseña el flujo.
- **Doble control** para acciones irreversibles de alto impacto (pagos, cambios de permisos).
- **Registra cada aprobación** con quién, cuándo y qué vio.

En Foundry Agent Service puedes exigir aprobación antes de cada llamada a una herramienta MCP; Microsoft Agent Framework y Copilot Studio también permiten pasos de aprobación en los flujos.

### Ejecución de código en sandbox

Si un agente ejecuta código, asume que algún día ejecutará código de un atacante. Requisitos mínimos: aislamiento a nivel de máquina virtual o contenedor endurecido, **sin credenciales** en el entorno, **salida de red denegada por defecto** y vida corta del sandbox.

Opciones en Microsoft: Azure Container Apps dynamic sessions (aisladas con Hyper-V), el Code Interpreter de Foundry y, para agentes que usan un escritorio, Windows 365 for Agents (GA en Build 2026). Microsoft también anunció en Build 2026 el SDK Microsoft Execution Container (MXC), en early preview, para aislar la ejecución de agentes en Windows ([Microsoft Security Blog](https://www.microsoft.com/en-us/security/blog/2026/06/02/microsoft-build-2026-securing-code-agents-and-models-across-the-development-lifecycle/)). En el mercado: E2B, Modal, microVMs Firecracker y gVisor.

### Cerrar los canales de exfiltración en la salida

EchoLeak y ForcedLeak sacaron datos por canales “inocentes”: una imagen markdown que carga una URL con datos en la query string, o un enlace a un dominio permitido.

- No renderices imágenes ni enlaces a dominios externos no aprobados.
- Reescribe o elimina URLs generadas por el modelo que lleven parámetros.
- Aplica Content Security Policy estricta en la interfaz del chat.
- Revisa periódicamente las listas de dominios permitidos: un dominio expirado es una puerta abierta.

### Guardrails en Microsoft Foundry

Foundry aplica guardrails (antes “content filters” de Azure OpenAI) en cuatro puntos: entrada del usuario, salida del modelo, llamada a herramienta y respuesta de herramienta. Los dos últimos se añadieron en preview con Foundry Control Plane en Ignite 2025.

| Control | Qué detecta |
| --- | --- |
| Prompt Shields (ataques de usuario) | Jailbreaks en el prompt del usuario |
| Prompt Shields (ataques en documentos) | Instrucciones ocultas en contenido recuperado o respuestas de herramientas |
| Filtros de contenido | Odio, sexual, violencia, autolesión, con umbrales configurables |
| Material protegido | Texto y código con derechos de autor conocidos |
| Groundedness detection | Respuestas no sustentadas en las fuentes entregadas |
| Detección de datos sensibles | Datos personales en entradas y salidas |
| Task adherence | Acciones del agente que se desvían de la tarea pedida |

Defender for Cloud consume estas señales para generar alertas de amenazas de IA (capítulo 9).

### Cadena de suministro de IA: modelos, datos y herramientas

Un sistema de IA depende de componentes que no escribiste: pesos de modelos, adaptadores, datasets, frameworks, servidores MCP, plugins y hasta prompts compartidos. Varios de ellos **pueden ejecutar código o esconder comportamiento**, y casi ninguno pasa hoy por los controles que aplicas al software (OWASP LLM03 y ASI04).

| Componente | Riesgo | Ejemplo | Control |
| --- | --- | --- | --- |
| Pesos en formato pickle (`.pkl`, `.pt`, `.bin`) | Ejecución de código al cargar el modelo | Modelos maliciosos subidos a hubs públicos | Formatos sin código (safetensors, GGUF, ONNX); escaneo; en PyTorch, cargar solo pesos |
| Nombre del modelo | Que otro modelo ocupe ese nombre | *Model Namespace Reuse*: nombres de autores eliminados que se pueden volver a registrar; afectó a catálogos de Azure AI Foundry y Vertex AI y a miles de proyectos ([Unit 42, 2025](https://unit42.paloaltonetworks.com/model-namespace-reuse/)) | Fijar por hash o revisión, registro interno, espejo propio |
| Puertas traseras en los pesos | Comportamiento oculto que se activa con un disparador | Investigación académica sobre modelos “durmientes” | Procedencia, evaluaciones y red team antes de usar |
| Adaptadores y fine-tunes de terceros | Los mismos riesgos, más difíciles de auditar | Adaptadores LoRA publicados por desconocidos | Mismo proceso de aprobación que un modelo |
| Datasets | Envenenamiento, datos personales, licencias | Datos de entrenamiento con información personal memorizable | Procedencia, data cards, escaneo de datos personales |
| Frameworks y servidores de inferencia | Vulnerabilidades y exposición | Servidores de inferencia expuestos sin autenticación | Parches, análisis de dependencias, red privada |
| Servidores MCP, plugins y skills | Código de terceros con privilegios | `postmark-mcp` (2025) | Registro con huella (pestaña MCP a fondo) |
| Prompts y configuraciones de agentes | Instrucciones maliciosas en una versión publicada | Extensión de Amazon Q Developer (2025) | Revisión como código y versiones firmadas |

**Controles en orden de prioridad:**

1. **Formatos seguros.** Exige safetensors u otros formatos sin código ejecutable; si debes cargar pickle, hazlo en un sandbox y solo después de escanear.
2. **Escaneo antes de usar.** Herramientas como ModelScan o fickling detectan operadores peligrosos en archivos pickle; son una red de seguridad, no una garantía.
3. **Fijar por hash o revisión, nunca por nombre.** En Hugging Face, `from_pretrained("org/modelo", revision="<commit>")`.
4. **Firma y verificación.** La biblioteca *model-signing* v1.0 de OpenSSF (Google, NVIDIA y HiddenLayer, 2025) firma modelos con Sigstore por defecto ([Sigstore](https://blog.sigstore.dev/model-transparency-v1.0)). El pipeline de despliegue rechaza modelos sin firma válida.
5. **Registro interno de modelos aprobados** y bloqueo de descargas directas desde hubs públicos en producción.
6. **AI BOM.** Inventario de modelos, datasets, adaptadores y dependencias en CycloneDX (ML-BOM, desde la versión 1.6) o en los perfiles de IA y datasets de SPDX 3.0, generado en el pipeline y enlazado al inventario del capítulo 10.
7. **Licencias.** Las licencias de modelos abiertos tienen restricciones de uso que legal debe revisar.

**En Microsoft:** los modelos del catálogo de Foundry se escanean (malware, vulnerabilidades, puertas traseras e integridad) con la tecnología de HiddenLayer y el resultado aparece en la ficha del modelo ([HiddenLayer](https://hiddenlayer.com/innovation-hub/azure-ai-catalog-integration)); Defender anunció en Build 2026 el escaneo de modelos de IA en registros, workspaces y pipelines (preview); los registros de Azure Machine Learning sirven como catálogo interno aprobado; y el AI-SPM de Defender for Cloud mantiene el inventario de componentes de IA. La práctica está en el Lab 19.

### Lista mínima de controles para cualquier agente

- [ ] Tiene dueño, identidad propia y está en el inventario
- [ ] Sus herramientas son las mínimas y con permisos mínimos
- [ ] Cumple la regla de dos o tiene aprobación humana en acciones sensibles
- [ ] El contenido no confiable va marcado (spotlighting) y pasa por Prompt Shields
- [ ] La salida no puede renderizar enlaces o imágenes a dominios no aprobados
- [ ] Tiene límites de pasos, tokens y costo
- [ ] El código que genera se ejecuta en sandbox sin credenciales ni red
- [ ] Sus trazas llegan al SIEM y existe un procedimiento para apagarlo

### Para repasar

1. ¿Por qué Plan-Then-Execute protege contra el cambio de acciones pero no contra el cambio de parámetros?
2. Diseña un asistente de correo con el patrón Dual LLM: ¿qué ve cada modelo?
3. ¿Qué canal de exfiltración usaron EchoLeak y ForcedLeak, y cómo lo cierras?

## 6. Identidad para IA y agentes

La pregunta de identidad cambió de “quién es el usuario” a “**quién está actuando y en nombre de quién**”. Un agente necesita identidad propia, un humano responsable y permisos que nunca superen los del usuario al que sirve. Hoy pocas empresas lo cumplen: la mayoría todavía conecta agentes con API keys compartidas.

### Tres formas en que un agente actúa

| Modo | Quién actúa | Permisos efectivos | Ejemplo | Riesgo típico |
| --- | --- | --- | --- | --- |
| Delegado (on-behalf-of) | El agente, en nombre de un usuario | La intersección entre los permisos delegados del agente y los del usuario | M365 Copilot leyendo tus correos | El agente usa tu acceso para algo que tú no pediste (confused deputy) |
| Autónomo (app-only) | El agente, por sí mismo | Los permisos de aplicación que se le asignaron | Agente nocturno de conciliación contable | Los permisos de aplicación suelen valer para todo el tenant |
| Agente como usuario | Una cuenta tipo usuario que es un agente | Los de esa cuenta: buzón, Teams, grupos | “Empleado digital” que recibe solicitudes por correo | Se le trata como humano en accesos y revisiones |

### Principios de identidad para agentes

1. **Una identidad por agente.** Nada de service principals o claves compartidas entre agentes; sin eso no hay auditoría ni revocación individual.
2. **Un humano responsable.** Cada agente tiene un dueño de negocio que responde por él y revisa sus accesos.
3. **Sin secretos estáticos.** Identidades administradas, federación de identidades de carga de trabajo o certificados. Nunca claves en el código ni en el prompt.
4. **Tokens de vida corta y con audiencia específica.** Un token emitido para la API A no debe servir en la API B.
5. **Mínimo privilegio por herramienta.** Usa permisos acotados (por ejemplo `Sites.Selected` en lugar de `Sites.Read.All`) y acceso just-in-time para acciones sensibles.
6. **Ciclo de vida completo.** Alta con aprobación, revisiones periódicas y baja cuando el agente o su dueño dejan de existir.
7. **Acceso condicional y riesgo también para agentes.** Las mismas señales que usas para humanos: ubicación, riesgo, recurso.
8. **Cadena de delegación trazable.** Si el usuario llama al agente A y este al agente B, los logs deben mostrar la cadena completa.

### Anti-patrones que verás en auditorías

- Una API key de modelo compartida por todo un equipo y guardada en un archivo `.env`.
- Un agente que usa el token personal (PAT) del desarrollador que lo creó.
- **Token passthrough:** un servidor MCP que reenvía el token del usuario a otra API. Está prohibido por la especificación MCP.
- Permisos de aplicación amplios (`Mail.ReadWrite`, `Sites.Read.All`) para un agente que solo necesita una carpeta.
- Agentes huérfanos que siguen activos después de que su creador se fue de la empresa.

### Microsoft Entra Agent ID

Entra Agent ID crea un tipo de identidad específico para agentes. Los agentes creados en Copilot Studio y en Foundry reciben una agent identity automáticamente ([Microsoft Learn: agent identities](https://learn.microsoft.com/entra/agent-id/agent-identities)).

| Concepto | Qué es | Para qué sirve |
| --- | --- | --- |
| Agent identity blueprint | Plantilla y base de autenticación de un tipo de agente; guarda las credenciales con las que se obtienen tokens | Gobernar de una vez todos los agentes del mismo tipo |
| Agent identity | Identidad principal del agente (un subtipo especializado de service principal), sin credenciales propias | Es el cliente que aparece en sign-in logs y auditoría, y el que recibe permisos |
| Agent user (opcional) | Cuenta de usuario marcada como agente, 1:1 con la agent identity | Agentes que necesitan buzón, Teams o pertenecer a grupos |
| Sponsor | Humano responsable; obligatorio al menos uno por agente y por blueprint | Decide el ciclo de vida y responde en revisiones e incidentes; no administra la parte técnica |
| Owner (opcional) | Administrador técnico | Configuración y credenciales |
| Manager | Responsable en la jerarquía de la organización | Puede pedir paquetes de acceso para el agente |

El código para que un agente se autentique con su identidad (sidecar, Microsoft.Identity.Web, Agent Framework, MSAL), los tres flujos de token, qué se puede y qué no, los mitos y los errores AADSTS más comunes están en la pestaña Agentes con Entra.

Fuente de los roles: [Microsoft Learn: owners, sponsors y managers](https://docs.azure.cn/en-us/entra/agent-id/agent-owners-sponsors-managers).

**Controles que puedes aplicar a agentes en Entra:**

- **Conditional Access para agentes.** Políticas sobre agent identities y agent users, con plantillas para bloquear agentes de riesgo alto y para agentes autónomos sin contexto de usuario.
- **ID Protection para agentes.** Detecta comportamiento de riesgo en agentes y alimenta las políticas de acceso condicional.
- **ID Governance para agentes.** Paquetes de acceso, revisiones de acceso con el sponsor y expiración.
- **Logs.** Los sign-in logs distinguen las autenticaciones de agentes.

**Licenciamiento (verifícalo antes de diseñar):** según el aviso MC1395007 (junio 2026), Conditional Access para agentes e ID Protection para agentes llegan como planes de servicio incluidos en Microsoft Agent 365 y Microsoft 365 E7, con despliegue GA entre julio y agosto de 2026 ([mc.merill.net](https://mc.merill.net/message/MC1395007)).

**Políticas de acceso condicional para empezar:**

| Política | Aplica a | Condición | Control |
| --- | --- | --- | --- |
| Bloquear agentes de riesgo alto | Todas las agent identities | Riesgo del agente: alto | Bloquear |
| Agentes autónomos solo a recursos aprobados | Agentes sin contexto de usuario | Cualquier recurso fuera de la lista aprobada | Bloquear |
| Revisión de agentes nuevos | Agentes creados por usuarios de negocio | Primeros 30 días | Solo modo report-only, luego aplicar |

### Agentes, MCP y OAuth

Cuando un agente llama a un servidor MCP remoto, la autorización usa OAuth 2.1 (detalle en el capítulo 8):

- El servidor MCP es un **resource server** que publica sus metadatos (RFC 9728).
- El cliente pide tokens para ese servidor concreto con **resource indicators** (RFC 8707), así el token no sirve en otro lado.
- El servidor nunca reenvía el token del usuario a otra API.

**Enterprise-Managed Authorization (Cross App Access).** Es la respuesta al problema de “cada usuario conecta sus herramientas a mano”. El usuario inicia sesión con el IdP corporativo; el cliente intercambia esa sesión por una aserción firmada (ID-JAG) que el IdP solo emite si la política del administrador lo permite; luego la canjea por un token del servidor MCP, sin pantalla de consentimiento. La extensión de MCP pasó a estable en junio de 2026; Okta fue el primer IdP compatible ([WorkOS](https://workos.com/blog/mcp-enterprise-managed-authorization-id-jag), [mcp.directory](https://mcp.directory/blog/mcp-enterprise-managed-authorization-2026)).

Ojo: este modelo controla **quién puede conectarse a qué herramienta**, no **qué hace el agente con ese acceso**. La inyección de prompts sigue siendo un riesgo.

### El mercado de identidad para agentes

| Proveedor | Enfoque |
| --- | --- |
| Microsoft Entra Agent ID | Identidad, acceso condicional y gobierno de agentes dentro de Entra |
| Okta (Okta para agentes de IA, Cross App Access) | Identidad y autorización entre aplicaciones gestionada por el IdP |
| CyberArk (Palo Alto Networks) | Privilegios y secretos para identidades no humanas y agentes |
| SailPoint | Gobierno de identidades de agentes: inventario, dueños, revisiones |
| AWS Bedrock AgentCore Identity | Identidad y credenciales de agentes en AWS |
| Aembit, Astrix | Acceso de cargas de trabajo y seguridad de identidades no humanas |

### Para repasar

1. ¿Por qué los permisos de aplicación son más peligrosos que los delegados para un agente?
2. En Entra Agent ID, ¿qué diferencia hay entre sponsor y owner?
3. ¿Qué problema resuelve Enterprise-Managed Authorization y cuál no resuelve?

## 7. Protección de datos para IA

El mayor riesgo de datos en IA no es que el modelo “aprenda” tus secretos, sino el **oversharing**: la IA encuentra y resume en segundos lo que un usuario ya tenía permiso de ver pero nunca habría encontrado. Por eso la primera tarea de cualquier despliegue de copilots es arreglar permisos y clasificación, no configurar el modelo.

### Cinco riesgos de datos

| Riesgo | Cómo ocurre | Control principal |
| --- | --- | --- |
| Oversharing | Sitios abiertos a toda la organización, enlaces “cualquiera en la empresa”, grupos heredados | Revisiones de acceso, ocultar sitios sensibles a la IA, etiquetas |
| Fuga en prompts hacia IA externa | Empleados que pegan contratos o código en servicios no aprobados | DLP en navegador, endpoint y red; alternativa aprobada |
| Fuga en respuestas | RAG que no filtra por permisos; caché compartida | Filtrado por permisos en la consulta (security trimming) |
| La IA como nuevo repositorio sensible | Prompts, respuestas, memoria y logs con datos personales | Retención, eDiscovery, control de acceso a logs |
| Uso de datos por el proveedor | Entrenamiento, retención para monitoreo de abuso, subprocesadores | Contratos, opciones de retención cero, residencia |

### Secuencia de preparación antes de encender la IA

1. **Descubrir:** inventario de datos sensibles y sitios sobreexpuestos.
2. **Clasificar:** etiquetas de sensibilidad, empezando por el contenido más crítico, con etiquetado automático.
3. **Remediar:** corregir permisos, revisar accesos de sitios, eliminar enlaces de toda la organización y ocultar sitios sensibles a la búsqueda de la IA.
4. **Proteger:** DLP para la IA (por etiqueta y por tipo de dato sensible) y cifrado con derechos de uso.
5. **Monitorear:** actividad de IA, uso riesgoso y alertas.
6. **Retener y descubrir:** políticas de retención y eDiscovery para las interacciones con IA.

Las empresas que saltan del paso 1 al 4 terminan con un DLP que bloquea todo o nada. El paso 3 es el que más tiempo consume y el que más riesgo elimina.

### RAG seguro: reglas que aplican con cualquier proveedor

- **El modelo nunca decide qué puede ver el usuario.** Filtra en la consulta al índice con la identidad del usuario. Pedirle al LLM “no muestres datos confidenciales” no es un control.
- **Guarda las ACL en el índice.** Cada fragmento lleva los usuarios o grupos que pueden leerlo, y la búsqueda filtra con el token del usuario. Azure AI Search soporta control de acceso a nivel de documento usando el token del usuario en la consulta.
- **Controla quién escribe en las fuentes.** Si cualquiera puede subir un documento al repositorio que alimenta el RAG, cualquiera puede envenenar las respuestas o plantar instrucciones.
- **Limpia el contenido al ingerirlo.** Elimina texto oculto (texto blanco, comentarios HTML, metadatos) donde suelen esconderse inyecciones.
- **Separa índices por sensibilidad y por cliente.** Un índice multi-tenant sin filtrado es una fuga esperando ocurrir (OWASP LLM08).
- **Hereda la clasificación.** Lo que la IA genera a partir de un documento confidencial debe quedar como confidencial. M365 Copilot aplica la etiqueta de mayor prioridad de las fuentes al contenido que crea.

### Shadow AI: descubrir, decidir, proteger

Un estudio de Gartner citado por TrueFoundry indica que el 69% de las organizaciones sospecha o tiene evidencia de que sus empleados usan herramientas de IA generativa prohibidas ([TrueFoundry](https://www.truefoundry.com/ar/blog/shadow-ai-detection-tools)). Bloquear sin ofrecer una alternativa aprobada no funciona: el uso se mueve a dispositivos personales.

| Capa | Qué ve | En Microsoft | En el mercado |
| --- | --- | --- | --- |
| Red (SSE o proxy) | Qué servicios de IA se usan, desde dónde | Entra Internet Access (Global Secure Access) | Zscaler, Netskope, Palo Alto Prisma Access, Cloudflare One |
| CASB y catálogo | Riesgo de cada app de IA; sancionar o bloquear | Defender for Cloud Apps (categoría de IA generativa) | Netskope, Zscaler, Skyhigh |
| Navegador | El texto que se pega o sube en sitios de IA | Edge for Business con DLP en línea, extensión de Purview para navegadores | Island, Prisma Browser, LayerX |
| Endpoint | Copiar, pegar y subir archivos a IA no aprobada | Purview Endpoint DLP | DLP de endpoint de cualquier proveedor |
| Identidad | Inicios de sesión en apps de IA con cuentas corporativas | Entra ID (consentimiento de apps, acceso condicional) | Okta, cualquier IdP |

Los agentes y CLIs locales (Claude Code, GitHub Copilot, Codex) son el nuevo shadow AI: corren en el endpoint y llaman a APIs directamente. En Build 2026 Microsoft anunció en preview la protección de datos de Purview para esos agentes locales y el descubrimiento de agentes locales en Agent 365 ([Microsoft Security Blog](https://www.microsoft.com/en-us/security/blog/2026/06/02/microsoft-build-2026-securing-code-agents-and-models-across-the-development-lifecycle/)).

Con el GA de Agent 365 (mayo 2026), los controles de red de Entra se extendieron a los agentes de Copilot Studio y a los agentes en los endpoints: detectan uso de IA no sancionado, restringen destinos, filtran movimiento de archivos y bloquean ataques de prompt ([Microsoft Security Blog](https://www.microsoft.com/en-us/security/blog/2026/05/01/microsoft-agent-365-now-generally-available-expands-capabilities-and-integrations/)).

### Implementación en Microsoft

| Necesidad | Herramienta | Notas |
| --- | --- | --- |
| Ver qué datos y apps de IA se usan | Purview DSPM for AI | Explorador de actividad, informes y una evaluación semanal automática de los 100 sitios de SharePoint más usados ([Microsoft Learn](https://learn.microsoft.com/purview/dspm-for-ai)) |
| Encontrar oversharing | DSPM for AI (evaluaciones de riesgo) + SharePoint Advanced Management | SAM está incluido con las licencias de Microsoft 365 Copilot; usa los informes de gobierno de acceso a datos y las revisiones de acceso de sitios |
| Ocultar sitios sensibles a Copilot sin tocar permisos | Restricted Content Discovery | Por sitio; los usuarios siguen accediendo al sitio directamente |
| Medida temporal mientras remedias | Restricted SharePoint Search | Lista de hasta 100 sitios permitidos; no la dejes como estado final |
| Impedir que Copilot procese contenido etiquetado | DLP con la ubicación “Microsoft 365 Copilot y Copilot Chat” | Condición por etiqueta de sensibilidad |
| Bloquear prompts con datos sensibles | DLP para prompts de Copilot | Por tipos de información sensible; GA reportada desde finales de abril 2026 ([cloudmagazin](https://www.cloudmagazin.com/en/2026/05/07/microsoft-intelligent-purview-mai-2026-dlp-ki-prompts-agents/)); el bloqueo de búsqueda web tuvo despliegue GA entre mayo y junio 2026 (MC1263277) |
| Cifrar | Etiquetas con cifrado | Copilot solo usa contenido cifrado si el usuario tiene derechos VIEW y EXTRACT; el contenido con Double Key Encryption queda fuera |
| Detectar uso riesgoso | Insider Risk Management (plantilla de uso riesgoso de IA) y Communication Compliance | Prompts que buscan datos sensibles o contenido inapropiado |
| Retener y buscar | Políticas de retención e eDiscovery para interacciones con IA | Cubre Copilot, agentes y apps de IA de terceros detectadas |
| Auditar | Purview Audit | Registros de interacciones con Copilot y actividad de agentes |
| Proteger agentes de Foundry | DLP en tiempo de ejecución para prompts de agentes (preview) y señales de riesgo de datos en Foundry Control Plane (GA) | Anunciado en Build 2026 |

### Preguntas para cualquier proveedor de modelos

- ¿Usa mis prompts o respuestas para entrenar? (En Azure OpenAI y Foundry: no.)
- ¿Cuánto tiempo retiene los datos para monitoreo de abuso y puedo desactivarlo?
- ¿En qué región se procesa la inferencia según el tipo de despliegue?
- ¿Qué subprocesadores intervienen? Ojo con los SaaS multi-modelo: cuando un copiloto usa modelos de otro proveedor, el tratamiento de datos puede cambiar. En M365 Copilot revisa la configuración de los modelos de Anthropic en el centro de administración.
- ¿Ofrece retención cero y residencia de datos por contrato?

### Para repasar

1. ¿Por qué el paso de remediación de permisos es el que más riesgo elimina en un despliegue de Copilot?
2. ¿Qué diferencia hay entre Restricted Content Discovery y Restricted SharePoint Search?
3. Diseña el filtrado por permisos de un RAG sobre SharePoint: ¿dónde guardas las ACL y con qué identidad consultas?

## 8. MCP y A2A: los protocolos de los agentes

**MCP** (Model Context Protocol) conecta agentes con herramientas y datos; **A2A** (Agent2Agent) conecta agentes con otros agentes. Ambos son estándares de facto desde 2025 y ambos tienen gobierno neutral bajo la Linux Foundation. Regla de trabajo: **cada servidor MCP y cada agente remoto es software de terceros con privilegios**, y lo que devuelven es entrada no confiable.

### MCP en cinco minutos

- **Piezas:** el *host* (Claude, VS Code, Copilot Studio, Foundry) contiene un *cliente MCP* que habla con *servidores MCP*. Cada servidor expone herramientas (acciones), recursos (datos) y prompts.
- **Transportes:** `stdio` para servidores locales (un proceso en la máquina del usuario, con sus permisos) y Streamable HTTP para servidores remotos.
- **Gobierno:** en diciembre de 2025 Anthropic donó MCP a la Agentic AI Foundation de la Linux Foundation.

| Versión de la especificación | Cambio relevante para seguridad |
| --- | --- |
| 2026-07-28 | Protocolo sin estado: se eliminan las sesiones y el handshake de inicialización. Endurece la autorización (validación del emisor con RFC 9207) y abandona el registro dinámico de clientes en favor de documentos de metadatos (CIMD). Depreca Roots, Sampling y Logging ([changelog](https://modelcontextprotocol.net/specification/2026-07-28/changelog), [Descope](https://www.descope.com/blog/post/july-2026-mcp-revision)) |
| 2025-11-25 | Registro de clientes por URL de metadatos (CIMD) y tareas asíncronas |
| 2025-06-18 | El servidor MCP pasa a ser un *resource server* OAuth; resource indicators (RFC 8707) obligatorios; prohibido el token passthrough |
| 2025-03-26 | Primera especificación de autorización con OAuth 2.1; transporte Streamable HTTP |

Además, la extensión **Enterprise-Managed Authorization** (Cross App Access, capítulo 6) pasó a estable en junio de 2026 y permite que el IdP corporativo decida qué usuarios conectan qué servidores MCP.

### Riesgos específicos de MCP

| Riesgo | Qué pasa | Mitigación |
| --- | --- | --- |
| Tool poisoning | La descripción de una herramienta incluye instrucciones ocultas que el modelo obedece | Revisar descripciones antes de aprobar; gateway que inspecciona metadatos |
| Rug pull | El servidor cambia descripciones o código después de aprobado (caso postmark-mcp) | Fijar versiones, guardar hash de las definiciones y alertar ante cambios |
| Tool shadowing | Un servidor malicioso define herramientas que alteran el uso de otras legítimas | Espacios de nombres, pocos servidores por agente, aislamiento |
| Confused deputy | Un proxy MCP con un client ID estático obtiene consentimiento ajeno | Consentimiento por cliente, como exige la especificación |
| Token passthrough | El servidor reenvía el token del usuario a otra API | Validar audiencia; usar OBO o token exchange |
| SSRF en el descubrimiento OAuth | URLs de metadatos maliciosas apuntan a recursos internos | Validar URLs y bloquear rangos internos |
| Servidores locales con permisos del usuario | Un servidor `stdio` puede leer archivos y ejecutar comandos (caso mcp-remote) | Contenedores, lista permitida gestionada por MDM, descubrimiento de servidores locales |
| Servidores expuestos sin autenticación | Servidores MCP accesibles desde internet sin OAuth | Autenticación obligatoria, red privada, escaneo de exposición |
| Exfiltración con herramientas legítimas | El agente usa “enviar correo” o “crear issue” para sacar datos | Regla de dos, aprobación humana, límites de destino |

### Arquitectura empresarial de MCP

1. **Catálogo aprobado.** Un registro de servidores MCP revisados, con dueño, versión y nivel de riesgo. Los clientes solo pueden usar servidores del registro (VS Code, GitHub Copilot y Claude Enterprise permiten imponer listas permitidas).
2. **Gateway MCP.** Todo el tráfico MCP remoto pasa por el gateway: autenticación, autorización por herramienta, límites, inspección de argumentos y respuestas, logging.
3. **Identidad.** El IdP corporativo es el servidor de autorización; los tokens tienen audiencia por servidor y alcances por herramienta; el acceso a APIs internas usa OBO.
4. **Servidores locales bajo control.** Configuración gestionada por MDM, servidores en contenedores, descubrimiento de servidores no aprobados en endpoints.
5. **Trazabilidad.** Cada llamada registra quién (usuario y agente), qué herramienta, argumentos (redactados) y resultado.

### A2A en cinco minutos

- **Origen:** Google lo lanzó en abril de 2025 y lo donó a la Linux Foundation ese mismo año. La versión 1.0 (marzo 2026) añadió **Agent Cards firmadas** con JWS para verificar que la tarjeta la emitió el dueño del dominio ([Decryption Digest](https://www.decryptiondigest.com/blog/a2a-protocol-security-mtls-signed-agent-cards)).
- **Agent Card:** documento JSON publicado en una URL conocida que describe las capacidades del agente, su endpoint y cómo autenticarse.
- **Tareas:** el agente cliente envía mensajes; el agente remoto trabaja en una tarea con ciclo de vida y devuelve artefactos, por streaming o por notificaciones push (webhooks).

|  | MCP | A2A |
| --- | --- | --- |
| Conecta | Agente con herramienta o datos | Agente con agente |
| El otro lado | Ejecuta lo que se le pide; no razona | Es opaco: razona y usa sus propias herramientas |
| Ejemplo | Agente llama a “crear ticket” en ServiceNow | Agente de compras delega la cotización al agente de un proveedor |
| Riesgo principal | Abuso de herramientas y cadena de suministro | Confianza excesiva en la respuesta de otro agente y fuga de datos hacia afuera |

**Controles para A2A:** autenticación mutua (mTLS u OAuth) entre agentes, verificación de la firma de la Agent Card, lista permitida de agentes de socios, tráfico A2A por el gateway, validación de las URLs de webhooks (SSRF) y, sobre todo, **tratar la respuesta de otro agente como entrada no confiable**.

### MCP y A2A en Microsoft

| Producto | Qué ofrece |
| --- | --- |
| Foundry Agent Service | Herramienta MCP para servidores remotos con opción de aprobación por llamada; conexiones A2A |
| Copilot Studio | Conectores MCP para agentes low-code, gobernados por las políticas de datos de Power Platform |
| Azure API Management | Exponer APIs REST como servidores MCP, publicar servidores existentes, agruparlos en productos y versionarlos; APIs A2A en GA; content safety sobre argumentos MCP y mensajes A2A |
| Azure API Center | Catálogo y descubrimiento de APIs y servidores MCP de la organización |
| Agent 365 | El registro de agentes descubre servidores MCP locales y remotos (preview, Build 2026) |
| Windows | Soporte nativo de MCP con registro de servidores y aislamiento de ejecución de agentes |

Este capítulo es la visión general. El protocolo, la autorización, el catálogo completo de amenazas, los incidentes, el desarrollo seguro de servidores y el gobierno están en la pestaña MCP a fondo.

Lo mismo para A2A, con su modelo de confianza entre agentes y entre empresas, en la pestaña A2A a fondo.

### Para repasar

1. ¿Qué es un rug pull en MCP y qué control lo detecta?
2. ¿Por qué un servidor MCP `stdio` es más peligroso de lo que parece?
3. ¿Por qué la respuesta de un agente A2A debe tratarse como entrada no confiable aunque el agente sea de un socio de confianza?

## 9. El stack de Microsoft a fondo

Microsoft organiza su oferta en tres planos: **construir** (Foundry, Copilot Studio, Agent Framework, GitHub), **usar** (Microsoft 365 Copilot y Copilot Chat) y **gobernar y proteger** (Agent 365 como plano de control sobre Entra, Purview, Defender e Intune, más Sentinel y Security Copilot para operaciones). Saber qué producto responde a qué pregunta es la mitad del trabajo de un arquitecto.

### Mapa rápido: qué producto responde a qué pregunta

| Pregunta | Producto |
| --- | --- |
| ¿Dónde construyo agentes con código? | Microsoft Foundry (Agent Service) y Microsoft Agent Framework |
| ¿Dónde construye agentes el negocio? | Copilot Studio |
| ¿Qué agentes existen y quién responde por ellos? | Agent 365 (registro), Entra Agent ID, centro de administración de Power Platform |
| ¿Qué puede tocar cada agente? | Entra (Agent ID, Conditional Access, ID Governance) |
| ¿Qué datos ve la IA y cómo los protejo? | Purview (DSPM for AI, DLP, etiquetas, Insider Risk) y SharePoint Advanced Management |
| ¿Mi infraestructura de IA está bien configurada? | Defender for Cloud: AI security posture management (plan Defender CSPM) |
| ¿Están atacando mi app o agente en ejecución? | Defender for Cloud: protección contra amenazas de IA; Defender para agentes de Copilot Studio |
| ¿Qué apps de IA usan mis empleados? | Defender for Cloud Apps, Entra Internet Access, Purview DSPM for AI |
| ¿Cómo controlo el tráfico a modelos y herramientas? | Azure API Management (AI gateway) |
| ¿Cómo detecto y respondo? | Defender XDR, Sentinel (data lake, graph, servidor MCP) y Security Copilot |
| ¿Cómo evalúo y hago red teaming? | Evaluaciones de Foundry y AI Red Teaming Agent (basado en PyRIT) |
| ¿Cómo demuestro cumplimiento? | Purview Compliance Manager (plantillas de EU AI Act, ISO/IEC 42001, NIST AI RMF) |

### 9.1 Microsoft Foundry

Foundry es la plataforma para construir apps y agentes: catálogo de modelos (Azure OpenAI más modelos de Anthropic, Meta, Mistral, xAI, DeepSeek y otros), **Agent Service** (GA), herramientas y conocimiento (Foundry IQ, catálogo de herramientas MCP), evaluaciones, observabilidad y **Foundry Control Plane**, que gobierna la flota de agentes: inventario, políticas de guardrails, cumplimiento y costos.

**Configuración segura de Foundry:**

- [ ] Acceso público deshabilitado y endpoints privados; red virtual propia para Agent Service
- [ ] Autenticación local (API keys) deshabilitada; solo Entra ID con roles de Foundry de mínimo privilegio
- [ ] Agent Service en configuración *standard*: hilos, archivos y vectores en tus propios Cosmos DB, Storage y AI Search, con claves gestionadas por el cliente si aplica
- [ ] Política de guardrails definida en Control Plane y aplicada a modelos y agentes, incluidas las llamadas y respuestas de herramientas
- [ ] Evaluaciones de calidad y seguridad en el pipeline de despliegue (groundedness, ataques indirectos, vulnerabilidades de código, precisión de llamadas a herramientas)
- [ ] AI Red Teaming Agent ejecutado antes de producción, con la tasa de éxito de ataques documentada
- [ ] Trazas con OpenTelemetry hacia Application Insights
- [ ] Defender for Cloud habilitado para recibir alertas de seguridad en Foundry
- [ ] Señales de riesgo de datos de Purview en Control Plane (GA en Build 2026) y DLP en tiempo de ejecución para prompts de agentes (preview)

### 9.2 Copilot Studio y Power Platform

Copilot Studio es donde más rápido crece el número de agentes, porque cualquier usuario de negocio puede crear uno. El gobierno se hace desde Power Platform:

| Control | Qué hace |
| --- | --- |
| Entornos y enrutamiento de entornos | Cada creador trabaja en su entorno de desarrollo, no en el entorno por defecto |
| Managed Environments | Límites de uso compartido, análisis de soluciones, reglas de publicación |
| Políticas de datos (DLP de conectores) | Clasifica conectores, fuentes de conocimiento y conectores MCP como empresariales, no empresariales o bloqueados |
| Autenticación del agente | Exige autenticación con Entra ID; prohíbe agentes sin autenticación en canales públicos salvo excepción aprobada |
| Inventario de agentes | Visible en Power Platform y en Agent 365; cada agente recibe una identidad de Entra Agent ID |
| Protección en tiempo de ejecución | Defender puede bloquear la respuesta o la acción del agente si detecta comportamiento sospechoso como una inyección (preview desde 2025) |
| Auditoría | Actividad de creadores y agentes en Purview Audit |

**El hallazgo más común en auditorías de Copilot Studio:** agentes compartidos con toda la organización cuyas conexiones usan **las credenciales del creador**. Cualquiera que hable con el agente actúa con los permisos de quien lo creó. Exige autenticación del usuario final en las conexiones de agentes compartidos.

### 9.3 Microsoft 365 Copilot

Copilot respeta los permisos del usuario: solo recupera, a través de Microsoft Graph, lo que ese usuario ya puede ver. Las interacciones tienen **Enterprise Data Protection**: no se usan para entrenar modelos fundacionales y quedan dentro del límite de servicio de Microsoft 365, con EU Data Boundary donde aplica. Microsoft agrupa sus controles en el **Copilot Control System**: seguridad y gobierno (Purview, SharePoint Advanced Management), controles de administración (agentes, conectores, búsqueda web) y medición (Copilot Analytics).

Qué hace cada pieza de Purview con Copilot y con la IA que no es de Microsoft (DSPM, DLP, etiquetas, RCD, Insider Risk, retención, la API para apps propias), con límites, licencias y una secuencia de despliegue, está en la pestaña Purview para IA.

**Controles clave para el administrador:**

1. Remediación de oversharing antes del despliegue masivo (capítulo 7).
2. Gestión de agentes en el centro de administración de Microsoft 365: quién puede instalar, publicar y compartir agentes.
3. Configuración de la búsqueda web (grounding en Bing) y de los modelos de terceros disponibles en Copilot.
4. DLP para Copilot por etiqueta y por tipo de dato sensible.
5. Insider Risk Management, Communication Compliance, retención y auditoría de interacciones.

Riesgo residual: Copilot lee correos y documentos que pueden traer instrucciones ocultas (EchoLeak). Microsoft mitiga con clasificadores de inyección y parches del servicio, pero el control que tú manejas es reducir lo que Copilot puede alcanzar.

La memoria de Copilot, los agentes declarativos y de motor propio, los conectores, las acciones y cómo gobernarlos están en Memoria y extensibilidad.

### 9.4 Microsoft Agent 365

Agent 365 es el plano de control de agentes. Llegó a GA el 1 de mayo de 2026 con licencia por usuario; también viene dentro de **Microsoft 365 E7**, el nuevo plan que reúne E5, Microsoft 365 Copilot, Entra Suite y Agent 365 ([handsontek](https://m365admin.handsontek.net/?p=19710), [TrustedTech](https://www.trustedtechteam.com/blogs/news/microsoft-365-e7-everything-you-need-to-know)). Microsoft confirmó el precio de Agent 365: 15 USD por usuario al mes por separado, o incluido en E7 (\[Microsoft Security Blog, 1 may 2026\](https://www.microsoft.com/en-us/security/blog/2026/05/01/microsoft-agent-365-now-generally-available-expands-capabilities-and-integrations/)). El precio de E7 (99 USD según blogs de licenciamiento) no lo pude confirmar en una página de Microsoft. En el lanzamiento quedaron en preview el descubrimiento de agentes locales y shadow AI con Defender e Intune, y la sincronización del registro con AWS Bedrock y Google Cloud.

| Pilar | Qué hace |
| --- | --- |
| Registro | Inventario único de agentes, incluidos los no registrados (shadow agents); permite poner en cuarentena agentes no autorizados |
| Control de acceso | Identidad de Entra por agente, mínimo privilegio, sponsors, acceso condicional basado en riesgo |
| Visualización | Paneles, telemetría y mapa de agentes con sus relaciones con usuarios y recursos |
| Interoperabilidad | Gobierna agentes de Microsoft, de código abierto y de terceros; SDK de Agent 365 en GA desde Build 2026 |
| Seguridad | Integración con Defender, Entra y Purview |

Novedades de Build 2026: el registro descubre más de 20 tipos de agentes locales, incluidos agentes de código y servidores MCP (preview) ([Microsoft Security Blog](https://www.microsoft.com/en-us/security/blog/2026/06/02/microsoft-build-2026-securing-code-agents-and-models-across-the-development-lifecycle/)), y los controles para activar y desactivar agentes de Foundry desde Agent 365 tienen GA en agosto 2026 ([AZ571826](https://mc.merill.net/message/AZ571826)).

### 9.5 Defender

| Componente | Qué aporta a la seguridad de IA |
| --- | --- |
| Defender for Cloud: AI-SPM (plan Defender CSPM) | Descubre cargas de IA en Azure OpenAI y Foundry, Azure Machine Learning, Amazon Bedrock y Google Vertex AI; inventario (AI BOM), rutas de ataque hacia recursos de IA y recomendaciones ([Microsoft Learn](https://learn.microsoft.com/azure/defender-for-cloud/ai-security-posture)) |
| Defender for Cloud: protección contra amenazas de IA | Alertas de jailbreak, fuga de datos sensibles, robo de credenciales y abuso de cuota, usando las señales de Prompt Shields; más contexto si la app envía el contexto de seguridad del usuario final en cada petición |
| Defender for Cloud Apps | Catálogo de apps de IA generativa para descubrir y bloquear shadow AI; gobierno de apps OAuth; protección de agentes de Copilot Studio |
| Defender XDR | Incidentes que correlacionan alertas de IA con identidad, endpoint y correo; búsqueda avanzada y grafo de exposición para agentes (anunciados en Build 2026) |
| Escaneo de modelos de IA (preview, Build 2026) | Detecta modelos vulnerables o comprometidos en registros, workspaces y pipelines de CI/CD |
| Defender for Endpoint con Intune y Entra | Descubre agentes locales y servidores MCP en los dispositivos |

Qué ve y qué no ve cada Defender frente a la IA (agentes locales y servidores MCP en los equipos, bloqueo de apps de IA, Defender for AI Services, AI-SPM, protección de agentes con Agent 365), con consultas KQL y licencias, está en la pestaña Defender para IA.

Varias de estas funciones de agentes seguían en preview en las fuentes revisadas; confirma el estado en la página [What's new in Microsoft AI security](https://learn.microsoft.com/en-us/security/security-for-ai/whats-new) antes de comprometerlas en un diseño.

### 9.6 Microsoft Sentinel

- **Portal:** Sentinel se gestiona desde el portal de Defender. El retiro del portal de Azure se extendió al **31 de marzo de 2027** (antes era el 1 de julio de 2026) ([Microsoft Q&A](https://learn.microsoft.com/en-us/answers/questions/5824732/what-is-the-new-date-for-microsoft-sentinel-retire)). Si despliegas Sentinel con Bicep, planifica el onboarding al portal de Defender como parte del despliegue.
- **Data lake (GA desde 2025):** almacenamiento barato a largo plazo para telemetría de alto volumen, como los logs de prompts del gateway, con consultas KQL y jobs programados.
- **Sentinel graph y servidor MCP:** permiten que agentes (Security Copilot, GitHub Copilot en VS Code y otros clientes MCP) consulten el SIEM. Trata ese servidor MCP como un acceso privilegiado: identidad propia, rol mínimo (Security Reader) y auditoría.
- **Fuentes de datos para IA:** alertas de Defender for Cloud y Defender XDR, sign-in logs de Entra (incluidos los de agentes), Purview Audit (interacciones con Copilot y agentes), logs del AI gateway de API Management y logs de diagnóstico de Foundry.

Las consultas KQL de detección están en el capítulo 11.

### 9.7 Security Copilot

Security Copilot se incluye en Microsoft 365 E5. Según el aviso MC1261596, el despliegue fue entre el 20 de abril y el 30 de junio de 2026, con 400 unidades de cómputo (SCU) al mes por cada 1.000 licencias de usuario y un máximo de 10.000 SCU al mes; al superar la asignación hay throttling, no cobro adicional ([mc.merill.net](https://mc.merill.net/message/MC1261596)).

- **Agentes de Microsoft:** triaje de phishing (Defender), optimización de Conditional Access (Entra), remediación de vulnerabilidades (Intune), triaje de alertas de DLP e Insider Risk (Purview), resumen de inteligencia de amenazas; un Security Analyst Agent para Defender en preview desde RSAC 2026.
- **Agent Builder:** creación de agentes propios en lenguaje natural, y agentes de partners.
- **Gobierno:** los agentes del SOC también son agentes. Requieren identidad, permisos mínimos y registro de quién aprobó cada acción.

### 9.8 Desarrollo seguro con GitHub

- GitHub Advanced Security con escaneo de secretos (incluidas claves de proveedores de IA), CodeQL y Copilot Autofix.
- Integración de Defender for Cloud con GitHub Code Security (GA en Build 2026): prioriza vulnerabilidades con contexto de ejecución.
- MDASH, sistema de Microsoft con más de 100 agentes para encontrar y validar vulnerabilidades explotables (expanded preview).
- Gobierno del agente de código de GitHub Copilot: firewall de salida del agente, lista permitida de servidores MCP y revisión obligatoria de sus pull requests.

### Para repasar

1. Un auditor te pregunta qué agentes existen en el tenant y quién responde por cada uno. ¿Qué productos usas?
2. ¿Por qué las conexiones con credenciales del creador son peligrosas en Copilot Studio?
3. ¿Qué diferencia hay entre AI-SPM y la protección contra amenazas de IA en Defender for Cloud?

## 10. Gobierno de IA: marcos, regulación y modelo operativo

Gobernar la IA es poder responder con evidencia cuatro preguntas: **qué IA tenemos, qué riesgo tiene cada caso, quién responde por él y qué controles se aplicaron**. Los marcos (NIST AI RMF, ISO/IEC 42001) dicen cómo organizarlo; la regulación (EU AI Act y leyes locales) dice qué es obligatorio.

### Marcos de referencia

| Marco | Tipo | Para qué te sirve |
| --- | --- | --- |
| NIST AI RMF 1.0 y su perfil de IA generativa (NIST AI 600-1, 2024) | Voluntario | Estructura de gestión de riesgos en cuatro funciones: Govern, Map, Measure, Manage |
| NIST Cyber AI Profile (NIST IR 8596) | Voluntario, en borrador | Lleva el CSF 2.0 a la IA: proteger sistemas de IA, usar IA en la defensa y frenar ataques potenciados por IA; borrador preliminar entre fines de 2025 y 2026 ([NIST](https://www.nist.gov/node/1901136)) |
| ISO/IEC 42001:2023 | Certificable | Sistema de gestión de IA (AIMS) con controles del Anexo A; muchos proveedores, incluido Microsoft para M365 Copilot, ya están certificados |
| ISO/IEC 23894 e ISO/IEC 42005 | Guías | Gestión de riesgos de IA y evaluación de impacto de sistemas de IA |
| CSA AI Controls Matrix | Voluntario | Catálogo de controles de IA alineable con auditorías cloud |
| OWASP (LLM y Agentic Top 10, AI Exchange) y MITRE ATLAS | Comunidad | Riesgos técnicos y técnicas de ataque (capítulo 4) |
| Microsoft Responsible AI Standard | Interno de Microsoft, público | Seis principios: equidad, fiabilidad y seguridad, privacidad y seguridad, inclusión, transparencia, rendición de cuentas |

Combinación habitual en empresas: **ISO/IEC 42001 como sistema de gestión**, NIST AI RMF como lenguaje de riesgos, OWASP y ATLAS para los controles técnicos y el EU AI Act como requisito legal.

Los marcos de Microsoft (Cloud Adoption Framework, Well-Architected, MCSB v2, Zero Trust para IA), una tabla que une controles entre marcos y un modelo de madurez de cinco niveles están en la pestaña Marcos y cómo aplicarlos.

### EU AI Act: lo que tienes que saber

Aplica fuera de la UE si pones un sistema en el mercado europeo o si su resultado se usa en la UE. El **Digital Omnibus** (Reglamento UE 2026/1744, publicado el 24 de julio de 2026 y en vigor desde el 27 de julio) aplazó las obligaciones de alto riesgo ([Cooley](https://cdp.cooley.com/digital-ai-omnibus-delays-key-deadlines-introduces-new-rules/), [Jones Walker](https://www.joneswalker.com/en/insights/blogs/ai-law-blog/yes-august-2-still-matters-the-eu-approved-a-high-risk-ai-delay-but-most-trans.html)).

&#91;embedded content: EU AI Act · hitos de 2024 a 2028 tras el Digital Omnibus\]

Las prohibiciones, las obligaciones de modelos de propósito general y la transparencia del artículo 50 ya aplican; el alto riesgo de Anexo III (empleo, educación, crédito, servicios esenciales) llega el 2 de diciembre de 2027.

**Roles.** La mayoría de las empresas es *deployer* (usa sistemas de terceros, como Copilot). Pasa a ser *provider* cuando desarrolla un sistema y lo pone en servicio con su nombre, incluso para uso interno.

**Niveles de riesgo:**

| Nivel | Ejemplos | Qué exige |
| --- | --- | --- |
| Prohibido | Puntuación social, reconocimiento de emociones en el trabajo o la escuela, scraping masivo de rostros, manipulación | No se puede usar |
| Alto riesgo | Selección de personal, evaluación de crédito, acceso a educación o servicios esenciales, componentes de seguridad de productos regulados | Gestión de riesgos, calidad de datos, logs, supervisión humana, documentación; el deployer debe seguir instrucciones, supervisar, conservar logs al menos seis meses e informar a los trabajadores |
| Transparencia | Chatbots, contenido sintético, deepfakes | Avisar que se interactúa con IA y marcar el contenido generado |
| Mínimo | La mayoría de los asistentes internos | Buenas prácticas voluntarias |

**Alfabetización en IA (artículo 4).** Aplica desde febrero de 2025 a todos los proveedores y deployers. El omnibus la suavizó: pasó de “asegurar un nivel suficiente” a “tomar medidas que apoyen” la alfabetización ([DPO Consulting](https://www.dpo-consulting.com/blog/ai-act-what-the-digital-omnibus-really-changes-for-companies)). Sigue siendo obligatorio tener un programa de formación.

**Multas:** hasta 35 millones de euros o el 7% de la facturación global por prácticas prohibidas, y hasta 15 millones o el 3% por otros incumplimientos.

### Estados Unidos

No hay ley federal de IA. Una orden ejecutiva del 11 de diciembre de 2025 busca desplazar leyes estatales consideradas incompatibles y menciona expresamente la de Colorado; los abogados recomiendan seguir cumpliendo las leyes estatales mientras tanto ([Gibson Dunn](https://www.gibsondunn.com/president-trump-latest-executive-order-on-ai-seeks-to-preempt-state-laws/)). La Colorado AI Act se aplazó al 30 de junio de 2026; verifica si la sesión legislativa de 2026 la cambió ([Greenberg Traurig](https://www.gtlaw.com/en/insights/2025/9/colorado-delays-comprehensive-ai-law-with-further-changes-anticipated)). Otras normas estatales relevantes: la TRAIGA de Texas, la SB 53 de California sobre modelos de frontera y la Local Law 144 de Nueva York sobre herramientas automatizadas de contratación.

### América Latina

Casi ningún país tiene todavía una ley integral de IA, pero **todos tienen leyes de protección de datos que ya aplican a la IA** (LGPD en Brasil, Ley 1581 en Colombia, Ley 29733 en Perú, la nueva LFPDPPP en México, la Ley 21.719 en Chile).

| País | Estado a octubre 2026 |
| --- | --- |
| Brasil | PL 2338/2023 aprobado por el Senado en diciembre de 2024; sigue en la Cámara de Diputados y se espera retomarlo después de las elecciones de octubre 2026. Modelo por niveles de riesgo inspirado en la UE |
| Perú | Ley 31814 con reglamento aprobado por el Decreto Supremo 115-2025-PCM (septiembre 2025): el marco operativo más avanzado de la región |
| Chile | Proyecto de ley de IA (Boletín 16.821-19) en segundo trámite en el Senado; la nueva ley de datos personales 21.719 entra en vigor el 1 de diciembre de 2026, aunque un proyecto del Gobierno (boletín 18.623-07) busca postergarla a diciembre de 2027 |
| Colombia | Política nacional de IA y varios proyectos de ley en trámite, sin ley integral |
| México | Sin ley federal de IA; varias iniciativas en discusión en el Congreso |

Fuentes: [Acento](https://acento.com.do/radar-innovador/regulacion-de-la-ia-en-america-latina-quien-avanza-quien-frena-y-que-esta-en-juego-en-2026-9641659.html), [Nodo](https://nodo.build/blog/regulacion-ia-latam-2026). Las fuentes regionales no siempre coinciden en fechas; confirma en los sitios oficiales de cada congreso.

Dónde se guardan y procesan los datos de IA desde la región, las leyes de datos personales de seis países y una plantilla de evaluación de impacto: Residencia y LatAm.

### Modelo operativo de gobierno

**Roles:**

| Rol | Responsabilidad |
| --- | --- |
| Comité de IA (CISO, CDO, legal, privacidad, riesgo, negocio) | Política, apetito de riesgo y aprobación de casos de alto riesgo |
| Centro de excelencia o equipo de plataforma de IA | Plataforma común: gateway, landing zone, catálogo de modelos y herramientas |
| Dueño del caso de uso | Responde por el agente o la app: propósito, datos, resultados |
| Seguridad (incluido red team de IA) | Threat modeling, pruebas, monitoreo y respuesta |
| Privacidad y legal | Evaluaciones de impacto, contratos, cumplimiento regulatorio |
| Auditoría interna | Verificación independiente de que el proceso se cumple |

**Ciclo de vida de un caso de uso:**

1. Registro del caso de uso y de su dueño.
2. Clasificación de riesgo.
3. Evaluaciones: privacidad, threat model, legal.
4. Controles exigidos según el nivel de riesgo.
5. Pruebas: evaluaciones automáticas y red team.
6. Aprobación y publicación.
7. Monitoreo y revisión periódica.
8. Retiro y baja de identidades y datos.

**Niveles de riesgo internos:**

| Nivel | Ejemplo | Requisitos mínimos |
| --- | --- | --- |
| Bajo | Asistente de redacción sin datos sensibles | Registro y política de uso aceptable |
| Medio | RAG sobre documentos internos confidenciales; agentes de solo lectura | Lo anterior + threat model, permisos revisados, guardrails, logging |
| Alto | Agentes que ejecutan acciones, apps para clientes, decisiones sobre personas | Lo anterior + red team, aprobación humana, evaluación de impacto, revisión legal, monitoreo continuo |
| Prohibido | Usos del artículo 5 del EU AI Act o contrarios a la política interna | No se aprueba |

**Qué registrar en el inventario (AI BOM):** dueño y sponsor, propósito, modelos y versiones, fuentes de datos, herramientas y permisos, identidad del agente, nivel de riesgo, evaluaciones y resultados, aprobaciones, número de usuarios y terceros involucrados.

**En Microsoft,** el inventario se arma con varias piezas: el registro de Agent 365, Foundry Control Plane, el inventario de IA de Defender for Cloud (AI-SPM) y Purview DSPM for AI. Purview Compliance Manager trae plantillas de evaluación para el EU AI Act, ISO/IEC 42001 y NIST AI RMF.

### Para repasar

1. Tu empresa usa un agente propio para preseleccionar CV de candidatos en España. ¿Qué rol y qué nivel de riesgo tiene bajo el EU AI Act, y desde cuándo aplican las obligaciones?
2. ¿Qué combinación de marcos usarías para certificarte y cuál para hablar de riesgo con el directorio?
3. ¿Qué campos mínimos debe tener tu inventario de agentes?

## 11. Operaciones de seguridad para IA

Un SOC no puede investigar lo que no registró. Para IA eso significa guardar, por cada interacción relevante, **quién pidió, qué agente actuó, qué modelo y versión respondió, qué datos se recuperaron y qué herramientas se llamaron**, sin convertir los logs en el repositorio más sensible de la empresa. Con esa base, las detecciones y los playbooks se parecen mucho a los que ya conoces.

### Qué registrar

| Campo | Por qué | Dónde se obtiene |
| --- | --- | --- |
| Usuario final y agente (con la cadena de delegación) | Atribuir la acción | Token del gateway, Entra sign-in logs |
| Modelo, versión y despliegue | Reproducir el comportamiento | Gateway, logs de Foundry |
| Versión del prompt de sistema y de la configuración del agente | Saber qué instrucciones tenía | Pipeline de despliegue |
| Prompt y respuesta (redactados o con hash, según política) | Investigar inyecciones y fugas | Gateway, Purview Audit |
| Documentos recuperados (IDs, etiquetas) | Detectar envenenamiento y oversharing | Trazas del RAG, Purview Audit |
| Herramientas llamadas, argumentos y resultado | Reconstruir acciones | Trazas del agente, gateway MCP |
| Veredictos de guardrails | Ver intentos bloqueados | Prompt Shields, filtros de contenido |
| Tokens y costo | Abuso de cuota | Métricas del gateway |

Usa las **convenciones semánticas de OpenTelemetry para IA generativa** (atributos `gen_ai.*`: modelo, operación, tokens de entrada y salida, herramienta) para que las trazas sean comparables entre frameworks y proveedores. Foundry, Agent Framework y los principales SDK de agentes ya las emiten.

### Detecciones en Sentinel (KQL)

Las consultas son puntos de partida: valida los nombres de tablas y campos en tu tenant, porque los esquemas de IA cambian con frecuencia.

**1. Alertas de amenazas de IA de Defender for Cloud agrupadas por recurso**

```kql
SecurityAlert
| where TimeGenerated > ago(7d)
| where AlertType startswith "AI." or AlertName has_any ("Prompt Shields", "Jailbreak", "AI model")
| extend Recurso = tostring(parse_json(ExtendedProperties)["Resource Name"])
| summarize Alertas = count(), Tipos = make_set(AlertName, 10) by Recurso, AlertSeverity
| order by Alertas desc
```

**2. Preparación de LLMjacking: alguien lista las claves de un recurso de IA**

```kql
AzureActivity
| where TimeGenerated > ago(1d)
| where OperationNameValue =~ "MICROSOFT.COGNITIVESERVICES/ACCOUNTS/LISTKEYS/ACTION"
| where ActivityStatusValue == "Success"
| project TimeGenerated, Caller, CallerIpAddress, ResourceGroup, _ResourceId
```

Si deshabilitaste la autenticación local, cualquier `ListKeys` es sospechoso. Compleméntala con cambios en despliegues de modelos (`.../DEPLOYMENTS/WRITE`) y en políticas de filtros de contenido (`.../RAIPOLICIES/WRITE`): un atacante que debilita los filtros deja esa huella.

**3. Pico de consumo de tokens por consumidor del gateway (denial of wallet)**

```kql
let ventana = 1h;
let base = AppMetrics
    | where TimeGenerated between (ago(7d) .. ago(ventana))
    | where Name == "Total Tokens"
    | extend Consumidor = tostring(Properties["Subscription ID"])
    | summarize Promedio = sum(Sum) / (7.0 * 24) by Consumidor;
AppMetrics
| where TimeGenerated > ago(ventana)
| where Name == "Total Tokens"
| extend Consumidor = tostring(Properties["Subscription ID"])
| summarize Actual = sum(Sum) by Consumidor
| join kind=leftouter base on Consumidor
| where Actual > 5 * coalesce(Promedio, 1000.0)
```

Requiere la política `llm-emit-token-metric` enviando métricas a Application Insights basado en workspace.

**4. Intentos de jailbreak en M365 Copilot por usuario**

```kql
CloudAppEvents
| where TimeGenerated > ago(1d)
| where ActionType == "CopilotInteraction"
| extend Mensajes = parse_json(RawEventData).CopilotEventData.Messages
| mv-expand Mensajes
| where tobool(Mensajes.JailbreakDetected)
| summarize Intentos = count() by AccountDisplayName
| where Intentos >= 3
```

Los registros de auditoría de Copilot incluyen los recursos a los que accedió cada interacción y sus etiquetas de sensibilidad; con ellos puedes detectar usuarios que, de golpe, usan Copilot para leer mucho contenido confidencial.

**5. Agente que inicia sesión desde una IP nueva**

```kql
let agentes = _GetWatchlist("InventarioAgentes") | project AppId = tostring(SearchKey);
let conocidas = AADServicePrincipalSignInLogs
    | where TimeGenerated between (ago(30d) .. ago(1d))
    | where AppId in (agentes)
    | distinct AppId, IPAddress;
AADServicePrincipalSignInLogs
| where TimeGenerated > ago(1d)
| where AppId in (agentes)
| join kind=leftanti conocidas on AppId, IPAddress
| project TimeGenerated, ServicePrincipalName, AppId, IPAddress, ResourceDisplayName
```

La watchlist sale del inventario de agentes (Agent 365 o tu registro). Es el mismo patrón que usas para cuentas de servicio, aplicado a agentes.

Mapea cada regla a MITRE ATLAS (por ejemplo AML.T0051 para inyección o AML.T0034 para abuso de cuota) igual que haces con ATT&CK. Si gestionas Sentinel como código, estas reglas encajan como recursos `Microsoft.SecurityInsights/alertRules` en tus plantillas Bicep.

### Playbooks de respuesta a incidentes de IA

| Escenario | Señales | Contención | Erradicación y recuperación |
| --- | --- | --- | --- |
| Inyección con exfiltración desde un agente o Copilot | Alerta de inyección indirecta, URL de salida extraña, alerta de DLP | Desactivar el agente (Agent 365, Power Platform o Foundry), revocar tokens, bloquear el dominio de destino | Eliminar el documento o correo envenenado, reducir herramientas y permisos, evaluar notificación de privacidad |
| Agente comprometido o deshonesto | Llamadas a herramientas fuera de su patrón, accesos a recursos nuevos | Deshabilitar la agent identity en Entra, revocar sesiones, activar el kill switch | Revisar y revertir sus acciones, rotar secretos a los que tuvo acceso |
| Clave de modelo filtrada o LLMjacking | Pico de costo, `ListKeys`, IPs desconocidas | Rotar claves, deshabilitar autenticación local, bloquear IPs | Buscar despliegues o recursos creados por el atacante |
| Fuga de datos por oversharing | Usuario que obtuvo contenido sensible vía Copilot | Ocultar el sitio con Restricted Content Discovery, corregir permisos | Caso en Insider Risk, evaluación legal, remediación de permisos del área |
| Servidor MCP malicioso o actualización maliciosa | Cambio de definiciones de herramientas, tráfico saliente nuevo | Bloquearlo en el registro y el gateway, desinstalarlo con Intune | Rotar credenciales accesibles al servidor, buscar el mismo paquete en otros endpoints |
| Consumo descontrolado (denial of wallet) | Pico de tokens en un consumidor | Bajar la cuota en el gateway o bloquear al consumidor | Encontrar el bucle o el abuso y corregir límites |

**Evidencia que debes preservar:** prompts y respuestas, llamadas a herramientas, documentos recuperados, versión del modelo y del prompt de sistema, veredictos de guardrails y aprobaciones humanas. Sin la versión del prompt de sistema no podrás saber si el agente se comportó “según diseño”.

### Red teaming y evaluación continua

El red teaming de IA busca dos cosas distintas: **seguridad** (inyección, exfiltración, abuso de herramientas) y **daños** (contenido dañino, sesgo, desinformación). Necesitas ambas.

| Herramienta | Tipo | Uso |
| --- | --- | --- |
| PyRIT (Microsoft) | Open source | Automatizar ataques multi-turno contra apps y agentes |
| AI Red Teaming Agent de Foundry | Gestionado | Escaneos basados en PyRIT con reporte de tasa de éxito de ataques |
| Garak (NVIDIA) | Open source | Escaneo de vulnerabilidades de LLM con sondas predefinidas |
| promptfoo | Open source | Pruebas de prompts y red teaming en CI, con plantillas de OWASP |
| Evaluaciones de Foundry | Gestionado | Calidad y seguridad en cada despliegue (groundedness, ataques indirectos, precisión de herramientas) |

**Buenas prácticas:**

1. Red team antes de producción y después de cada cambio de modelo, prompt de sistema o herramientas.
2. Evaluaciones automáticas como puerta del pipeline de CI/CD, con umbrales mínimos.
3. Prueba el sistema completo (RAG, herramientas, permisos), no solo el modelo.
4. Convierte cada incidente o hallazgo en un caso de prueba de regresión.

Para practicar estos playbooks con tu equipo, el Lab 17 de la pestaña Laboratorios es un simulacro completo de incidente de IA, con sus inyecciones de información y las respuestas esperadas.

### Para repasar

1. ¿Por qué necesitas la versión del prompt de sistema en tus logs?
2. Escribe la lógica de una detección para un agente que, de repente, llama a una herramienta que nunca había usado.
3. ¿Qué harías primero ante una alerta de LLMjacking y por qué?

## 12. Casos de uso y escenarios comunes en empresas

Estos son los doce escenarios que más se repiten en empresas grandes en 2025–2026, en el orden en que suelen aparecer: primero copilots y chat interno, después RAG y agentes, y al final agentes autónomos y entre empresas. Cada uno trae su riesgo dominante, los controles que funcionan, cómo se implementa en Microsoft y el error que más se ve.

### Resumen

| # | Escenario | Riesgo dominante | Control que más rinde |
| --- | --- | --- | --- |
| 1 | Microsoft 365 Copilot para toda la empresa | Oversharing | Remediar los sitios más expuestos y ocultar los críticos |
| 2 | Chat corporativo multi-modelo | Identidad perdida y costo | Gateway con identidad del usuario de punta a punta |
| 3 | RAG sobre conocimiento interno | Fuga por permisos | Filtrado por permisos en el índice |
| 4 | Agente de atención al cliente | Acceso a datos de otro cliente | El ID del cliente sale del token, nunca del modelo |
| 5 | Agentes de código | Ejecución de comandos y secretos | Configuración gestionada y sandbox |
| 6 | Agentes de procesos de negocio | Agencia excesiva y fraude | Aprobación humana por umbral y segregación de funciones |
| 7 | Agentes low-code del negocio | Proliferación y credenciales del creador | Zonas de publicación e inventario con dueño |
| 8 | IA en el SOC | Inyección a través de datos de alertas | Solo lectura por defecto; acciones con aprobación |
| 9 | Control de shadow AI | Fuga a servicios no aprobados | Alternativa aprobada + DLP en navegador y endpoint |
| 10 | Modelos propios y open-weights | Cadena de suministro de modelos | Escaneo y registro interno de modelos |
| 11 | Agentes de navegador y computer use | Inyección desde cualquier web | Navegador aislado sin sesiones privilegiadas |
| 12 | Agentes entre empresas (A2A) | Confianza en un agente externo | Autenticación mutua, firma y límites de autoridad |

### 12.1 Microsoft 365 Copilot para toda la empresa

Es el escenario más común en empresas con Microsoft 365. Suele empezar con un piloto de unos cientos de licencias y expandirse por olas.

- **Riesgos:** oversharing; datos sensibles en prompts; agentes de terceros instalados por usuarios; inyección por correo o documentos; retención y eDiscovery de interacciones.
- **Controles:** preparación de datos (capítulo 7) antes de cada ola; piloto con áreas que tienen permisos ordenados; DLP por etiquetas; Insider Risk con la plantilla de uso riesgoso de IA; política de uso aceptable; formación de usuarios.
- **En Microsoft:** DSPM for AI, SharePoint Advanced Management, Restricted Content Discovery, DLP para Copilot, centro de administración de agentes, Purview Audit.
- **Error común:** esperar a tener todo etiquetado (nunca llega) o desplegar sin mirar permisos. Lo que funciona: remediar los sitios más expuestos, ocultar los críticos y avanzar por olas.

### 12.2 Chat corporativo multi-modelo

Empresas que ofrecen GPT, Claude o Gemini a todos los empleados con sus datos protegidos, en lugar del uso libre de servicios públicos, o como complemento de Copilot.

- **Arquitectura:** interfaz web o Teams con SSO → backend → AI gateway → modelos en Foundry, Bedrock o Vertex; logs al SIEM y al data lake.
- **Riesgos:** claves compartidas, costo sin dueño, logs con datos sensibles, modelos no aprobados.
- **Controles:** el token del usuario viaja hasta el gateway (cuotas y auditoría por persona); catálogo de modelos aprobados por nivel de dato (por ejemplo, confidencial solo en modelos con residencia regional); guardrails; logging con redacción; chargeback por área.
- **En Microsoft:** API Management como AI gateway, Foundry, Purview DSPM for AI para apps de IA empresariales, Defender for Cloud con contexto del usuario final.
- **Error común:** la identidad del usuario se pierde en el backend y todo llega al modelo como “la app”. Después nadie puede investigar un incidente.

### 12.3 RAG sobre conocimiento interno

Mesa de ayuda de TI o RR. HH., manuales operativos, normativa interna, contratos.

- **Arquitectura:** ingesta desde SharePoint o un lago de datos → fragmentación y embeddings → índice con ACL → orquestador → modelo, con citas.
- **Riesgos:** fuga por permisos; envenenamiento; instrucciones ocultas en documentos; respuestas desactualizadas; alucinaciones con impacto (una política de vacaciones inventada).
- **Controles:** filtrado por permisos en la consulta; fuentes curadas con dueño; limpieza del contenido al ingerir; detección de groundedness; citas obligatorias; permitir que el sistema responda “no lo sé”; set de preguntas de referencia para evaluar cada cambio.
- **En Microsoft:** Azure AI Search con control de acceso por documento, Foundry IQ, Prompt Shields para documentos, evaluadores de groundedness de Foundry.
- **Error común:** indexar con una cuenta de servicio que ve todo y no filtrar por usuario.

### 12.4 Agente de atención al cliente

Retail, telecomunicaciones y banca en web, app y WhatsApp: estado de pedidos, cambios de plan, reclamos.

- **Riesgos:** jailbreaks que comprometen a la marca; promesas que la empresa debe cumplir (en 2024 un tribunal de Canadá obligó a Air Canada a respetar una política de reembolso que su chatbot inventó); acceso a datos de otros clientes; costo por bots; fraude.
- **Controles:** autenticar al cliente antes de mostrar datos personales; herramientas que toman el ID del cliente **del token de sesión**, nunca de la salida del modelo; patrón Action-Selector; guardrails estrictos de salida; límites por sesión; derivación a un humano; aviso de que se habla con una IA (artículo 50 del EU AI Act); protección contra bots.
- **En Microsoft:** Copilot Studio o Foundry Agent Service, API Management delante de las APIs, Azure Front Door con WAF y protección de bots, guardrails de Foundry, Defender for Cloud.
- **Error común:** dejar que el modelo pase el ID del cliente a la API. Es una vulnerabilidad de autorización a nivel de objeto (BOLA) a través del LLM.

### 12.5 Agentes de código para desarrolladores

GitHub Copilot, Claude Code, OpenAI Codex y Cursor se adoptaron masivamente. En modo agente ejecutan comandos y editan archivos; en la nube abren pull requests.

- **Riesgos:** secretos en la estación de trabajo; comandos destructivos; inyección desde repos, issues o documentación (configuraciones maliciosas en el repo que el agente ejecuta al abrirlo); servidores MCP locales; paquetes inventados por el modelo que un atacante registra (slopsquatting); código vulnerable; malware que usa las CLIs de IA instaladas (caso s1ngularity).
- **Controles:** proveedores aprobados con contrato empresarial y SSO; configuración gestionada centralmente (permisos de comandos, lista permitida de MCP, prohibir el modo “saltarse permisos”); devcontainers o agentes en la nube con firewall de salida; nada de secretos de producción en estaciones de trabajo; revisión humana obligatoria de los PRs de agentes; push protection de secretos; análisis de dependencias; telemetría de las CLIs al SIEM.
- **En Microsoft:** políticas de GitHub Copilot Business y Enterprise, firewall del agente de código, GitHub Advanced Security, seguridad DevOps de Defender for Cloud, Intune para distribuir configuración, descubrimiento de agentes locales (Agent 365 y Defender) y protección de datos de Purview para agentes de código (preview desde Build 2026).
- **Error común:** prohibirlos (los desarrolladores los usan igual, sin control) o permitir todo sin configuración gestionada.

### 12.6 Agentes que ejecutan procesos de negocio

Procesamiento de facturas, conciliaciones, alta de empleados, tickets de TI, compras.

- **Riesgos:** agencia excesiva; fraude por documento (una factura con instrucciones ocultas para cambiar la cuenta bancaria del proveedor); errores en cascada; permisos de aplicación amplios; falta de trazabilidad.
- **Controles:** Plan-Then-Execute; aprobación humana por umbral (montos altos, y siempre doble control para cambios de datos bancarios); acciones idempotentes y reversibles; identidad propia con permisos mínimos; segregación de funciones (el agente que propone no aprueba); límites de volumen; logs completos.
- **En Microsoft:** Foundry Agent Service con Logic Apps o Power Automate para aprobaciones, Entra Agent ID, API Management para las herramientas, Sentinel para monitoreo.
- **Error común:** darle al agente el rol de un usuario avanzado “porque es más fácil”.

### 12.7 Agentes low-code creados por el negocio

Cientos o miles de agentes en Copilot Studio, Agentforce o ServiceNow, creados por usuarios de negocio.

- **Riesgos:** proliferación; agentes huérfanos; conexiones con credenciales del creador; conectores a servicios externos; agentes publicados sin autenticación; vulnerabilidades de plataforma (ShareLeak).
- **Controles:** zonas con requisitos crecientes (personal, equipo, toda la organización); DLP de conectores; entornos gestionados; inventario con dueño y sponsor; revisión antes de compartir con toda la empresa; ciclo de vida con expiración; formación de creadores.
- **En Microsoft:** centro de administración de Power Platform, Managed Environments, Agent 365, Entra Agent ID, protección en tiempo de ejecución de Defender, Purview.
- **Error común:** bloquear la creación (empuja al shadow AI) o permitir compartir con toda la organización sin revisión.

### 12.8 IA en el SOC

Triaje de alertas, resúmenes de incidentes, consultas KQL en lenguaje natural, agentes que investigan y acceso al SIEM por MCP.

- **Riesgos:** inyección a través de los datos que el agente analiza (un atacante escribe instrucciones en el cuerpo de un phishing o en un user agent); un agente con permisos de respuesta (aislar equipos, deshabilitar cuentas) manipulado; conclusiones inventadas en una investigación; pérdida de habilidades del equipo.
- **Controles:** agentes de SOC con identidad propia y solo lectura por defecto; acciones de respuesta con aprobación; datos de alertas tratados como no confiables; registro de cada acción del agente; medir la precisión del triaje con muestreo humano de lo que el agente cierra.
- **En Microsoft:** Security Copilot (incluido en E5) y sus agentes, servidor MCP de Sentinel, Defender XDR, playbooks de Logic Apps con aprobación.
- **Error común:** el agente de triaje cierra alertas sin que nadie revise una muestra.

### 12.9 Control de shadow AI

Programa para descubrir y gobernar el uso de IA no aprobada (detalle en el capítulo 7).

1. Descubrir con logs de CASB o SSE.
2. Clasificar las apps de IA por riesgo.
3. Ofrecer una alternativa aprobada.
4. Bloquear las de alto riesgo.
5. Aplicar DLP a las de riesgo medio.
6. Formar y medir.

- **En Microsoft:** Defender for Cloud Apps, Entra Internet Access, Edge for Business, Endpoint DLP, extensión de Purview para navegadores, Intune.
- **Error común:** una lista de bloqueo estática. Aparecen apps de IA nuevas cada semana; usa categorías y puntuación de riesgo, no listas fijas.

### 12.10 Modelos propios, fine-tuning y open-weights

Por soberanía, costo a escala o casos especializados: Llama, Mistral, Qwen, DeepSeek o gpt-oss en la nube o en infraestructura propia.

- **Riesgos:** modelos con código malicioso (archivos pickle) o puertas traseras; licencias; datos de entrenamiento con información personal que el modelo memoriza; ausencia de los guardrails del proveedor; servidores de inferencia expuestos sin autenticación.
- **Controles:** escanear modelos y preferir formatos seguros (safetensors); registro interno de modelos aprobados; procedencia documentada (model cards, AI BOM); red team antes de usar; guardrails propios en el gateway; aislamiento de red; datos de fine-tuning saneados.
- **En Microsoft:** catálogo de modelos de Foundry, escaneo de modelos de Defender (preview), registros de Azure Machine Learning, Foundry Local, AKS con GPUs.
- **Error común:** descargar un modelo de un repositorio público directo a producción.

### 12.11 Agentes de navegador y computer use

Automatizar portales sin API (proveedores, organismos públicos) o investigar en la web con agentes que controlan un navegador o un escritorio.

- **Riesgos:** toda página web es entrada no confiable; el agente tiene a su alcance las sesiones autenticadas del usuario; acciones en sitios financieros; ataques de clickbait dirigidos a navegadores agénticos.
- **Controles:** navegador o máquina virtual dedicados al agente, sin sesiones personales ni privilegiadas; lista de sitios permitidos; confirmación humana para enviar formularios, pagar o iniciar sesión; políticas del navegador empresarial que desactivan las funciones agénticas donde no estén aprobadas.
- **En Microsoft:** Windows 365 for Agents (Cloud PC aislado y gobernado, GA), políticas de Edge for Business, herramienta de computer use de Foundry en sandbox.
- **Error común:** usar el agente en el navegador principal de un administrador con sesiones abiertas.

### 12.12 Agentes entre empresas (A2A)

Todavía temprano, pero creciendo en cadena de suministro, cotizaciones, logística y seguros.

- **Riesgos:** suplantación de agentes; datos que salen hacia el socio; respuestas maliciosas o erróneas; responsabilidad contractual por lo que el agente acuerda.
- **Controles:** contrato y acuerdo de tratamiento de datos; mTLS u OAuth; Agent Cards firmadas; lista permitida de agentes; gateway A2A con inspección; minimización de datos; logs por contraparte; límites de autoridad (el agente no puede comprometer gastos por encima de un monto).
- **En Microsoft:** APIs A2A en API Management (GA), conexiones A2A de Foundry, federación de identidades de carga de trabajo en Entra, Sentinel.
- **Error común:** tratar la respuesta del agente del socio como si fuera un dato propio validado.

### Para repasar

1. Elige un escenario de tu empresa y aplica las seis preguntas del capítulo 4.
2. En el agente de atención al cliente, ¿por qué el ID del cliente nunca debe salir del modelo?
3. ¿Qué tres controles pondrías primero para agentes de código y por qué?

## 13. Roadmap de 90 días, modelo de madurez y checklist

Un programa de seguridad de IA arranca con **visibilidad**, sigue con **controles base** y termina el primer trimestre con **operación**: el SOC detecta y responde a incidentes de IA. Cada fase tiene una puerta: no avances sin cumplir su criterio.

&#91;embedded content: roadmap de 90 días · 3 fases, 2 puertas\]

La Puerta 1 exige que cada app y agente conocido tenga dueño; la Puerta 2, que ninguna aplicación llame a un modelo sin pasar por el gateway. Después de los 90 días el trabajo pasa a ser continuo: nuevas olas de Copilot, agentes más autónomos y certificación ISO/IEC 42001 si el negocio la necesita.

Para llevar este plan a proyectos concretos (landing zone, Copilot, Copilot Studio, Foundry, RAG, MCP, shadow AI y SOC), con criterios de aceptación medibles para cada uno, ve a la pestaña Proyectos de cliente.

### Modelo de madurez

| Dimensión | 1. Reactivo | 2. Visible | 3. Controlado | 4. Gestionado |
| --- | --- | --- | --- | --- |
| Inventario | No se sabe qué IA hay | Inventario manual de apps y agentes | Registro automático con dueño y nivel de riesgo | Inventario completo, incluidos agentes locales y de terceros, con revisión periódica |
| Identidad | API keys compartidas | Identidades por aplicación | Identidad por agente, sponsors, sin secretos estáticos | Acceso condicional y gobierno de identidades para agentes; cadena de delegación trazable |
| Datos | Sin clasificar; oversharing desconocido | Oversharing medido | Sitios críticos remediados, etiquetas y DLP para IA | DLP en tiempo de ejecución para agentes; métricas de exposición en descenso |
| Controles técnicos | Cada equipo llama a los modelos como quiere | Algunos guardrails por app | Todo el tráfico por el gateway con políticas comunes | Patrones de diseño seguros por defecto; gateway también para MCP y A2A |
| Operación | Sin logs de IA | Logs disponibles, sin detecciones | Detecciones y playbooks de IA en el SIEM | Red team continuo; evaluaciones como puerta de CI/CD; métricas de respuesta |
| Gobierno | Sin política | Política de uso aceptable | Proceso de aprobación por nivel de riesgo y comité activo | Sistema de gestión alineado a ISO/IEC 42001 y requisitos regulatorios mapeados |

La mayoría de las empresas que empiezan están entre 1 y 2. Un objetivo razonable para el primer año es llegar a 3 en todas las dimensiones.

### Métricas para reportar al comité

| Métrica | Qué mide |
| --- | --- |
| % de agentes con dueño, sponsor e identidad propia | Gobierno e identidad |
| % del tráfico a modelos que pasa por el gateway | Cobertura de controles |
| Sitios sobreexpuestos remediados frente a detectados | Reducción de oversharing |
| Interacciones con datos sensibles bloqueadas o advertidas | Efectividad de DLP |
| Apps de IA no aprobadas en uso y su tendencia | Shadow AI |
| Tasa de éxito de ataques en el último red team | Robustez de las apps críticas |
| Tiempo de detección y de respuesta a incidentes de IA | Madurez operativa |
| Costo de IA por área y por agente | Control financiero |

### Checklist del programa

**Gobierno**

- [ ] Comité de IA con mandato y apetito de riesgo aprobado
- [ ] Política de uso aceptable publicada y programa de formación en marcha
- [ ] Proceso de aprobación por nivel de riesgo para casos de uso nuevos
- [ ] Inventario de apps y agentes con dueño, sponsor y nivel de riesgo
- [ ] Requisitos regulatorios mapeados (EU AI Act si aplica, leyes locales de datos)

**Identidad**

- [ ] Autenticación local deshabilitada en servicios de IA
- [ ] Identidad propia por agente, sin secretos estáticos
- [ ] Políticas de acceso condicional para agentes
- [ ] Revisiones de acceso de agentes con su sponsor

**Datos**

- [ ] Evaluación de oversharing hecha y sitios críticos remediados u ocultos
- [ ] Etiquetas de sensibilidad en el contenido más crítico
- [ ] DLP para Copilot y apps de IA por etiqueta y por tipo de dato
- [ ] Retención y eDiscovery configurados para interacciones con IA
- [ ] Control de shadow AI en red, navegador y endpoint

**Plataforma**

- [ ] AI gateway delante de todos los modelos, con cuotas y logging
- [ ] Endpoints de modelos sin acceso público
- [ ] Guardrails por defecto (Prompt Shields, filtros, groundedness)
- [ ] Registro aprobado de servidores MCP y gateway para su tráfico
- [ ] Sandbox para ejecución de código de agentes

**Operación**

- [ ] Logs de IA en el SIEM con retención definida
- [ ] Detecciones de IA activas y mapeadas a MITRE ATLAS
- [ ] Playbooks de respuesta a incidentes de IA probados en un simulacro
- [ ] Red team antes de producción para cada caso de riesgo alto
- [ ] Evaluaciones automáticas como puerta del pipeline

### Para repasar

1. ¿Por qué la visibilidad va antes que los controles?
2. Ubica a tu empresa en el modelo de madurez: ¿cuál es la dimensión más débil?
3. ¿Qué tres métricas llevarías al directorio y por qué?

## 14. Ruta de estudio, certificaciones, glosario y fuentes

En ocho semanas, a unas cinco horas por semana, puedes recorrer el libro con práctica real. Lo que más acelera el aprendizaje es montar un laboratorio propio: un tenant de prueba de Microsoft 365, una suscripción de Azure y tus plantillas Bicep.

### Plan de ocho semanas

| Semana | Capítulos | Práctica |
| --- | --- | --- |
| 1 | 1 y 4 | Lee el OWASP Top 10 for LLM y el Agentic Top 10; juega al reto de inyección de prompts Gandalf de Lakera |
| 2 | 2 y 3 | Despliega los laboratorios del repositorio [Azure-Samples/AI-Gateway](https://github.com/Azure-Samples/AI-Gateway): límite de tokens, caché semántica, content safety y MCP |
| 3 | 5 | Prueba Prompt Shields con documentos que traen instrucciones ocultas; implementa spotlighting en una app de ejemplo |
| 4 | 6 | Crea un agente en Foundry o Copilot Studio y revisa su agent identity en Entra; crea una política de acceso condicional para agentes en modo report-only |
| 5 | 7 | Activa DSPM for AI, ejecuta una evaluación de oversharing y crea una política de DLP para Copilot por etiqueta |
| 6 | 8 | Publica un servidor MCP detrás de API Management con OAuth y prueba un caso de tool poisoning contra tu propio agente |
| 7 | 9 y 11 | Lleva las detecciones del capítulo 11 a reglas de Sentinel en Bicep; ejecuta el AI Red Teaming Agent o PyRIT contra una app de prueba |
| 8 | 10, 12 y 13 | Redacta una política de uso aceptable y un inventario de ejemplo; ubícate en el modelo de madurez |

Cada semana tiene laboratorios paso a paso con su resolución en la pestaña Laboratorios.

Recursos de Microsoft: la ruta de aprendizaje [Implement security for AI](https://learn.microsoft.com/training/paths/implement-ai-security/) en Microsoft Learn y la página [What's new in Microsoft AI security](https://learn.microsoft.com/en-us/security/security-for-ai/whats-new), que conviene revisar cada mes.

### Certificaciones

Microsoft renovó su catálogo de IA en 2026: AI-102 y AI-900 se retiraron el 30 de junio de 2026 y llegaron nuevos exámenes de la familia AB ([Vlad Talks Tech](https://vladtalkstech.com/microsoft-learning-and-credential-news/microsoft-certification-retirements-2026/), [CloudThat](https://www.cloudthat.com/resources/blog/microsoft-ab-certification-roadmap-2026-choose-the-right-course)). AZ-500 se retiró el 31 de agosto de 2026 y lo reemplaza SC-500, que suma la protección de cargas de IA. Confirma códigos y estado en Microsoft Learn antes de reservar.

| Certificación | Emisor | Para quién | Relación con este libro |
| --- | --- | --- | --- |
| SC-100 Cybersecurity Architect Expert | Microsoft | Arquitectos de seguridad | Arquitectura Zero Trust que incluye cargas de IA |
| SC-401 Information Security Administrator | Microsoft | Administradores de protección de datos | Purview, DLP y protección de datos para Copilot (capítulo 7) |
| SC-200 Security Operations Analyst | Microsoft | Analistas SOC | Defender XDR y Sentinel (capítulo 11) |
| SC-500 Cloud and AI Security Engineer (reemplaza a AZ-500) | Microsoft | Ingenieros de seguridad en Azure | Plataforma y cargas de IA: AI gateway, Defender for AI, guardrails de Foundry y Agent ID (capítulos 3, 5, 6 y 9) |
| AI-103 (sucesor de AI-102) | Microsoft | Desarrolladores de apps y agentes en Azure | Foundry, agentes, guardrails |
| AB-900 Copilot and Agent Administration Fundamentals | Microsoft | Administradores de Microsoft 365 | Administración de Copilot y agentes |
| AB-100 Agentic AI Business Solutions Architect | Microsoft | Arquitectos de soluciones con agentes | Diseño de soluciones agénticas |
| AAISM (Advanced in AI Security Management) | ISACA | Líderes de seguridad (requiere CISM o CISSP) | Gestión de seguridad de IA alineada a NIST AI RMF, ISO/IEC 42001, OWASP y ATLAS |
| AIGP (AI Governance Professional) | IAPP | Privacidad, legal, riesgo y cumplimiento | Gobierno y regulación (capítulo 10) |
| AAIA (Advanced in AI Audit) | ISACA | Auditores | Auditoría de sistemas de IA |
| SecAI+ | CompTIA | Profesionales técnicos de seguridad | Fundamentos técnicos de seguridad de IA |
| ISO/IEC 42001 Lead Implementer o Lead Auditor | Varios organismos | Responsables de sistemas de gestión | Implementar o auditar un AIMS |

Recomendación según tu perfil: si vienes de seguridad Microsoft, **SC-500, luego SC-100 + AAISM**; si vienes de gobierno o privacidad, **AIGP + ISO/IEC 42001 Lead Implementer**; si eres SOC, **SC-200** y mucha práctica de red team.

Qué capítulo y qué laboratorio cubre cada dominio de cada examen: Mapa de certificaciones.

### Glosario

| Término | Significado |
| --- | --- |
| A2A (Agent2Agent) | Protocolo abierto para que agentes se comuniquen y deleguen tareas entre sí |
| Agent Card | Documento JSON con las capacidades, el endpoint y los requisitos de autenticación de un agente A2A |
| Agent identity | Identidad de Entra específica para un agente, distinta de las de usuarios y aplicaciones |
| AI BOM | Inventario de los componentes de un sistema de IA: modelos, datos, herramientas, dependencias |
| AI gateway | Proxy que controla y observa el tráfico hacia modelos, herramientas y agentes |
| AI-SPM | Gestión de la postura de seguridad de las cargas de IA |
| Blueprint (agent identity blueprint) | Plantilla y base de autenticación de un tipo de agente en Entra |
| CIMD | Documento de metadatos del cliente: forma de registrar clientes OAuth en MCP mediante una URL |
| Denial of wallet | Ataque que agota el presupuesto de IA consumiendo tokens |
| Deployer | En el EU AI Act, quien usa un sistema de IA bajo su autoridad |
| Groundedness | Grado en que una respuesta está sustentada en las fuentes entregadas |
| HITL (human-in-the-loop) | Aprobación humana dentro del flujo de un agente |
| ID-JAG | Aserción firmada por el IdP que permite el acceso entre aplicaciones gestionado por la empresa (Cross App Access) |
| Inyección indirecta | Instrucciones maliciosas escondidas en contenido que el modelo lee (documentos, webs, respuestas de herramientas) |
| LLMjacking | Uso de credenciales robadas para consumir modelos de IA a costa de la víctima |
| MCP (Model Context Protocol) | Protocolo abierto para conectar agentes con herramientas y datos |
| OBO (on-behalf-of) | Flujo OAuth en el que un servicio obtiene un token para actuar en nombre del usuario |
| Oversharing | Exceso de permisos que la IA vuelve visible al encontrar y resumir contenido |
| Prompt Shields | Clasificadores de Microsoft que detectan jailbreaks e inyecciones indirectas |
| PTU | Unidades de throughput aprovisionado: capacidad reservada de un modelo en Azure |
| RAG | Generación aumentada por recuperación: el modelo responde con documentos recuperados |
| Regla de dos | Un agente no debe combinar entrada no confiable, acceso sensible y capacidad de actuar hacia afuera sin supervisión |
| Rug pull | Cambio malicioso de una herramienta después de haber sido aprobada |
| Security trimming | Filtrar los resultados de una búsqueda según los permisos del usuario |
| Spotlighting | Técnica para marcar contenido no confiable y que el modelo no lo trate como instrucción |
| Sponsor | Humano responsable de un agente en Entra Agent ID |
| Tool poisoning | Instrucciones maliciosas en la descripción de una herramienta MCP |
| Trifecta letal | Datos privados + contenido no confiable + canal de salida = exfiltración posible |

### Fuentes

Consultadas el 17 de octubre de 2026. En una segunda pasada se verificaron contra la fuente oficial: la especificación MCP 2026-07-28, la especificación A2A 1.0, el OWASP MCP Top 10, la documentación del AI gateway de API Management (en su repositorio público de Microsoft Docs), el anuncio de GA de Agent 365 y las versiones de los paquetes en PyPI. El resto proviene de resúmenes de terceros y está marcado en el texto; los estados de preview y GA de Microsoft cambian cada mes, así que confírmalos en Microsoft Learn antes de diseñar.

**Microsoft**

- [Microsoft Build 2026: Securing code, agents, and models across the development lifecycle](https://www.microsoft.com/en-us/security/blog/2026/06/02/microsoft-build-2026-securing-code-agents-and-models-across-the-development-lifecycle/)
- [AI gateway en Azure API Management](https://learn.microsoft.com/azure/api-management/genai-gateway-capabilities) y [notas de versión de API Management](https://github.com/Azure/API-Management/releases)
- [Tier AI Gateway de API Management en preview (InfoQ)](https://infoq.com/news/2026/08/azure-apim-ai-gateway-tier)
- [Agent identities en Entra Agent ID](https://learn.microsoft.com/entra/agent-id/agent-identities) y [owners, sponsors y managers](https://docs.azure.cn/en-us/entra/agent-id/agent-owners-sponsors-managers)
- [MC1395007: Conditional Access e ID Protection para agentes](https://mc.merill.net/message/MC1395007)
- [MC1261596: Security Copilot incluido en Microsoft 365 E5](https://mc.merill.net/message/MC1261596)
- [AZ571826: controles de agentes de Foundry en Agent 365](https://mc.merill.net/message/AZ571826)
- [Agent 365 GA el 1 de mayo de 2026](https://m365admin.handsontek.net/?p=19710) y [Microsoft 365 E7](https://www.trustedtechteam.com/blogs/news/microsoft-365-e7-everything-you-need-to-know)
- [DSPM for AI](https://learn.microsoft.com/purview/dspm-for-ai) y [AI security posture management en Defender for Cloud](https://learn.microsoft.com/azure/defender-for-cloud/ai-security-posture)
- [Nueva fecha de retiro de Sentinel en el portal de Azure](https://learn.microsoft.com/en-us/answers/questions/5824732/what-is-the-new-date-for-microsoft-sentinel-retire)
- [DLP para prompts de Copilot (cloudmagazin)](https://www.cloudmagazin.com/en/2026/05/07/microsoft-intelligent-purview-mai-2026-dlp-ki-prompts-agents/)

**Amenazas, protocolos e identidad**

- [OWASP Agentic Top 10 (Promptfoo)](https://www.promptfoo.dev/docs/red-team/owasp-agentic-ai/) y [análisis de identidad (Descope)](https://www.descope.com/blog/post/owasp-agentic-top-10-identity)
- [MITRE ATLAS explicado (Speakeasy)](https://www.speakeasy.com/blog/mitre-atlas-explained)
- [ShareLeak y prompt injection en Copilot Studio y Agentforce (VentureBeat)](https://venturebeat.com/security/microsoft-salesforce-copilot-agentforce-prompt-injection-cve-agent-remediation-playbook)
- [Crisis de seguridad de MCP (CSA)](https://labs.cloudsecurityalliance.org/research/csa-research-note-mcp-security-crisis-20260504-csa-styled/)
- [Changelog de la especificación MCP 2026-07-28](https://modelcontextprotocol.net/specification/2026-07-28/changelog) y [análisis de Descope](https://www.descope.com/blog/post/july-2026-mcp-revision)
- [Enterprise-Managed Authorization e ID-JAG (WorkOS)](https://workos.com/blog/mcp-enterprise-managed-authorization-id-jag) y [mcp.directory](https://mcp.directory/blog/mcp-enterprise-managed-authorization-2026)
- [Seguridad de A2A y Agent Cards firmadas](https://www.decryptiondigest.com/blog/a2a-protocol-security-mtls-signed-agent-cards)

**Mercado y adopción**

- [Mayfield: The agentic enterprise in 2026](https://www.mayfield.com/the-agentic-enterprise-in-2026/)
- [Gravitee: State of AI agent security 2026](https://www.gravitee.io/hubfs/Downloadable%20Resource/state_of_ai_agent_security_report_pdf_2026.pdf)
- [Palo Alto Networks compra Portkey](https://pulse2.com/palo-alto-networks-to-acquire-portkey-to-establish-ai-gateway-as-control-plane-for-autonomous-enterprise-agents/amp/)
- [Adquisiciones de CrowdStrike y Check Point (SiliconANGLE)](https://siliconangle.com/2025/09/16/crowdstrike-check-point-extend-ai-security-capabilities-new-acquisitions/)
- [Kong AI Gateway y MCP (Hexaware)](https://hexaware.com/blogs/kong-ai-gateway-and-mcp-securing-and-scaling-agentic-ai-in-the-enterprise/)
- [Shadow AI (TrueFoundry)](https://www.truefoundry.com/ar/blog/shadow-ai-detection-tools)

**Regulación**

- [Digital AI Omnibus (Cooley)](https://cdp.cooley.com/digital-ai-omnibus-delays-key-deadlines-introduces-new-rules/), [Jones Walker](https://www.joneswalker.com/en/insights/blogs/ai-law-blog/yes-august-2-still-matters-the-eu-approved-a-high-risk-ai-delay-but-most-trans.html) y [DPO Consulting](https://www.dpo-consulting.com/blog/ai-act-what-the-digital-omnibus-really-changes-for-companies)
- [Orden ejecutiva de EE. UU. sobre leyes estatales de IA (Gibson Dunn)](https://www.gibsondunn.com/president-trump-latest-executive-order-on-ai-seeks-to-preempt-state-laws/) y [aplazamiento de la Colorado AI Act (Greenberg Traurig)](https://www.gtlaw.com/en/insights/2025/9/colorado-delays-comprehensive-ai-law-with-further-changes-anticipated)
- [Regulación de IA en América Latina 2026 (Acento)](https://acento.com.do/radar-innovador/regulacion-de-la-ia-en-america-latina-quien-avanza-quien-frena-y-que-esta-en-juego-en-2026-9641659.html) y [Nodo](https://nodo.build/blog/regulacion-ia-latam-2026)
- [NIST Cyber AI Profile](https://www.nist.gov/node/1901136)
