# Repaso en una página

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Lo esencial del libro para repasar antes de un examen, una entrevista o una reunión de arquitectura. Cada línea remite a un capítulo donde está el detalle.

Las respuestas a todas las preguntas de repaso del libro están en Respuestas de repaso.

## Veinte ideas clave

1. **La IA empresarial de 2026 son agentes con identidad, herramientas y datos**, no chats con un modelo. La seguridad se juega en gateway, identidad, datos y gobierno (cap. 0 y 1).
2. **La capa de uso siempre es tuya**, aunque compres el copiloto: identidad, datos y comportamiento de usuarios (cap. 1).
3. **Todo el tráfico a modelos, herramientas y agentes pasa por un AI gateway**, y el modelo no debe ser alcanzable por otro camino (cap. 2 y 3).
4. **Un gateway cuenta tokens, no peticiones**, entiende streaming, MCP y A2A, y aplica guardrails en ambos sentidos (cap. 3).
5. **El modelo no separa instrucciones de datos.** Todo lo que lee puede ser una orden (cap. 4).
6. **Trifecta letal:** datos privados + contenido no confiable + canal de salida = exfiltración posible. **Regla de dos:** un agente no combina las tres sin supervisión (cap. 4).
7. **La inyección no se resuelve en el modelo, se contiene en la arquitectura:** Action-Selector, Plan-Then-Execute, Dual LLM, Code-Then-Execute (cap. 5).
8. **Los clasificadores reducen la probabilidad; el diseño reduce el impacto.** Prompt Shields, Bedrock Guardrails y Model Armor son una capa, no la solución (cap. 5, labs 7, 11 y 12).
9. **Cierra los canales de exfiltración en la salida:** imágenes y enlaces a dominios no aprobados (cap. 5).
10. **Cada agente necesita identidad propia, un humano responsable y permisos que no superen los del usuario** (cap. 6).
11. **Sin secretos estáticos:** identidades administradas y federación; nunca API keys en código ni en prompts (cap. 6, lab 9).
12. **El mayor riesgo de datos es el oversharing,** y se arregla con permisos antes que con DLP (cap. 7).
13. **En un RAG, el filtro por permisos lo pone el código antes del modelo;** nunca el prompt (cap. 7, lab 5).
14. **Cada servidor MCP es código de terceros con privilegios** y todo lo que devuelve entra al contexto. Registro con huella, gateway y servidores locales en contenedor (MCP a fondo).
15. **La respuesta de otro agente (A2A) es entrada no confiable,** aunque sea de un socio (A2A a fondo).
16. **Los componentes de IA son cadena de suministro:** modelos en formatos seguros, fijados por hash, escaneados y firmados (cap. 5, lab 19).
17. **Gobernar es poder responder con evidencia:** qué IA hay, qué riesgo tiene, quién responde y qué controles se aplicaron (cap. 10).
18. **EU AI Act:** prohibiciones y GPAI ya aplican; transparencia desde agosto 2026; alto riesgo del Anexo III el 2 de diciembre de 2027 (cap. 10).
19. **Un SOC no investiga lo que no registró:** usuario, agente, modelo, prompt de sistema, documentos recuperados y herramientas llamadas (cap. 11).
20. **Primero visibilidad, después controles, después operación:** el roadmap de 90 días y sus dos puertas (cap. 13).

## Diez ideas más para el nivel de experto

1. **Defender ve el comportamiento, Purview el contenido, Entra la identidad.** Ningún producto ve todo; el experto sabe cuál completa a cuál (pestaña Visibilidad de agentes).
2. **MDE descubre agentes locales y sus MCP, pero descubrir no es bloquear.** El bloqueo está en la protección en tiempo de ejecución (preview, Windows) y en App Control.
3. **Desde el 1 de julio de 2026, la seguridad de agentes de Copilot Studio y Foundry requiere Agent 365 o E7.** E5 ya no alcanza.
4. **La alerta de Defender for AI Services solo nombra al usuario si la app envía `user_security_context`.**
5. **La DLP de Copilot no inspecciona los archivos subidos al chat, y RCD oculta sin cambiar permisos.**
6. **Las políticas de retención de Teams dejaron de cubrir Copilot en octubre de 2026.** Hay que crear políticas propias.
7. **Tu app propia solo respeta Purview si llama a `processContent`.** Necesita E5 y pago por uso; si no, la API responde 402.
8. **La IA no necesita otra landing zone:** va bajo Corp u Online con una iniciativa de políticas de IA, salida cerrada y un gateway.
9. **Foundry Agent Service no autoriza conversaciones por usuario.** La app debe validar a quién pertenece cada una.
10. **Un control vale si tiene evidencia medible.** El modelo de madurez y el cuestionario del Kit del consultor piden evidencia, no documentos.

## Las tres listas de OWASP en una tabla

| # | LLM Top 10 (2025) | Agentic Top 10 (2026) | MCP Top 10 (2025, beta) |
| --- | --- | --- | --- |
| 01 | Prompt injection | Secuestro del objetivo del agente | Tokens y secretos mal gestionados |
| 02 | Divulgación de información sensible | Mal uso de herramientas | Escalada por crecimiento de alcance |
| 03 | Cadena de suministro | Abuso de identidad y privilegios | Tool poisoning |
| 04 | Envenenamiento de datos y modelos | Cadena de suministro agéntica | Cadena de suministro y dependencias |
| 05 | Manejo inseguro de salidas | Ejecución inesperada de código | Inyección de comandos y ejecución |
| 06 | Agencia excesiva | Envenenamiento de memoria y contexto | Subversión del flujo de intención |
| 07 | Fuga del prompt de sistema | Comunicación insegura entre agentes | Autenticación y autorización insuficientes |
| 08 | Debilidades de vectores y embeddings | Fallas en cascada | Falta de auditoría y telemetría |
| 09 | Desinformación | Explotación de la confianza humano-agente | Servidores MCP en la sombra |
| 10 | Consumo ilimitado | Agentes deshonestos | Inyección de contexto y oversharing |

**Truco para memorizarlas:** la lista LLM mira el **modelo y sus datos**; la Agentic mira **lo que el agente hace** (objetivo, herramientas, identidad, memoria, otros agentes); la MCP mira **la conexión con herramientas** (tokens, servidores, autenticación, telemetría). Detalle en el capítulo 4 y en MCP a fondo.

## Microsoft en una tabla

| Necesidad | Producto |
| --- | --- |
| Construir agentes con código | Microsoft Foundry y Agent Framework |
| Agentes creados por el negocio | Copilot Studio |
| Inventario y control de todos los agentes | Agent 365 |
| Identidad y acceso condicional para agentes | Entra Agent ID |
| Tráfico a modelos, MCP y A2A | Azure API Management (AI gateway) |
| Registro de servidores MCP | Azure API Center |
| Guardrails | Prompt Shields y guardrails de Foundry |
| Datos que ve la IA | Purview (DSPM for AI, DLP, etiquetas) y SharePoint Advanced Management |
| Postura y amenazas en cargas de IA | Defender for Cloud (AI-SPM y protección contra amenazas de IA) |
| Shadow AI | Defender for Cloud Apps, Entra Internet Access, Edge for Business |
| Detección y respuesta | Sentinel, Defender XDR y Security Copilot |
| Cumplimiento | Purview Compliance Manager |

## Fechas clave

| Fecha | Hito |
| --- | --- |
| Aug 2, 2028 | EU AI Act: alto riesgo del Anexo I (productos regulados) |
| Dec 2, 2027 | EU AI Act: alto riesgo del Anexo III (empleo, educación, crédito) |
| Mar 31, 2027 | Sentinel deja el portal de Azure; solo portal de Defender |
| 6 ene 2027 | Se retiran las file policies de Defender for Cloud Apps; su función pasa a Purview DLP |
| 30 nov a 31 dic 2026 | Se retiran DSPM (classic) y DSPM for AI (classic); queda el DSPM unificado |
| Dec 2, 2026 | EU AI Act: fin de la gracia para el marcado de contenido de sistemas existentes |
| oct 2026 | Azure MCP Server 3.0 estable; las políticas de retención de Teams dejan de cubrir Copilot; Edge for Business y la DLP de red con Global Secure Access dejan de exigir pago por uso |
| sep 2026 | DLP de red de Purview con Global Secure Access en GA, también para agentes que actúan por el usuario |
| ago 2026 | EU AI Act: aplicación general y transparencia (artículo 50) |
| jul 2026 | Especificación MCP 2026-07-28 (sin estado); Digital Omnibus en vigor; tier AI Gateway de API Management en preview; la seguridad de agentes de Copilot Studio y Foundry pasa a Agent 365 (1 de julio) |
| jun 2026 | Build 2026; Enterprise-Managed Authorization de MCP estable; APIs A2A en API Management en GA; retiro de AI-102 y AI-900; descubrimiento y protección de agentes locales en Defender for Endpoint (preview) |
| may 2026 | Agent 365 y Microsoft 365 E7 en GA |
| abr–jun 2026 | Security Copilot incluido en Microsoft 365 E5 |
| mar 2026 | A2A v1.0 con Agent Cards firmadas; Copilot Studio crea identidades de Agent ID para los agentes nuevos (18 de marzo); Zero Trust para IA |
| dic 2025 | OWASP Top 10 for Agentic Applications; MCP pasa a la Agentic AI Foundation |
| nov 2025 | Ignite: Microsoft Foundry, Foundry Control Plane y Agent 365 |
| ago 2025 | EU AI Act: obligaciones de modelos de propósito general |
| jun 2025 | EchoLeak (CVE-2025-32711) en Microsoft 365 Copilot |

## Siglas que tienes que dominar

| Sigla | Significado |
| --- | --- |
| A2A | Agent2Agent: protocolo entre agentes |
| AI-SPM | Gestión de la postura de seguridad de IA |
| ASR | Tasa de éxito de ataques en red teaming |
| CIMD | Documento de metadatos del cliente OAuth |
| DSPM | Gestión de la postura de seguridad de los datos |
| GPAI | Modelo de IA de propósito general |
| HITL | Aprobación humana dentro del flujo |
| ID-JAG | Aserción del IdP para acceso entre aplicaciones |
| MCP | Model Context Protocol |
| OBO | Flujo on-behalf-of |
| PRM | Metadatos de recurso protegido (RFC 9728) |
| PTU | Capacidad reservada de modelos en Azure |
| RAG | Generación aumentada por recuperación |
| RCD | Restricted Content Discovery |
| XPIA | Ataque de inyección de prompts entre dominios (indirecta) |
