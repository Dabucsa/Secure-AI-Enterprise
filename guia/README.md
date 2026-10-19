# IA Empresarial Segura 2026: guía de estudio

Libro de estudio sobre arquitectura, seguridad, gobierno e identidad para IA generativa y agentes. Cada tema va primero en su versión agnóstica de fabricante y después en cómo se implementa con Microsoft: Entra Agent ID, Defender, Purview, Sentinel, Foundry, Azure API Management, Microsoft 365 Copilot y Agent 365. Los datos están verificados contra fuentes primarias a octubre de 2026.

Empieza por el [libro principal](00-ia-empresarial-segura-2026.md): su capítulo 0 trae el índice de los 14 capítulos y rutas de lectura por rol. Las demás partes profundizan un tema o sirven para practicar y repasar.

| Parte | Qué tiene | Úsala para |
|---|---|---|
| [IA Empresarial Segura 2026](00-ia-empresarial-segura-2026.md) | 14 capítulos: panorama, arquitectura de referencia, AI gateways, amenazas, controles, identidad, datos, MCP y A2A, el stack de Microsoft, gobierno y regulación, operaciones, casos de uso, roadmap de 90 días y ruta de estudio | Tener la visión completa |
| [Repaso en una página](01-repaso-en-una-pagina.md) | 20 ideas clave, las tres listas OWASP, el mapa de Microsoft, fechas y siglas | Repasar en 15 minutos antes de un examen o una reunión |
| [Respuestas de repaso](02-respuestas-de-repaso.md) | Respuestas modelo a todas las preguntas de repaso | Corregirte después de responder |
| [MCP a fondo](03-mcp-a-fondo.md) | Especificación, autorización, ataques, servidor protegido con Entra ID y gobierno de MCP | Diseñar o auditar servidores y clientes MCP |
| [A2A a fondo](04-a2a-a-fondo.md) | A2A 1.0, Agent Cards firmadas, riesgos y controles entre agentes | Conectar agentes con socios externos |
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
| [Memoria y extensibilidad](15-memoria-y-extensibilidad.md) | Memoria de agentes, su envenenamiento y la extensibilidad de Copilot | Gobernar agentes de Copilot, conectores y acciones |
| [Ataques con IA](16-ataques-con-ia.md) | Deepfakes, phishing con LLM, malware que usa IA, agentes atacantes y LLMjacking | Defenderte de atacantes que usan IA |
| [Residencia y LatAm](17-residencia-y-latam.md) | Residencia de datos en Azure y Copilot, leyes de seis países y plantilla de DPIA | Usar IA con datos personales desde Latinoamérica |
| [Laboratorios](18-laboratorios.md) | 24 prácticas con enunciado y resolución, la mayoría gratis | Practicar en tu computadora, en Azure, AWS o Google Cloud |
| [Mapa de certificaciones](19-mapa-de-certificaciones.md) | Qué capítulo cubre cada dominio de diez certificaciones | Preparar un examen |
| [Registro de cambios](20-registro-de-cambios.md) | Todos los cambios del libro, con fecha | Ver qué se actualizó desde tu última lectura |

## Código que acompaña a la guía

- [`ai-detections/`](../ai-detections/README.md): las detecciones de Microsoft Sentinel que se explican en Defender para IA, Visibilidad de agentes, MCP a fondo y A2A a fondo.
- [`ai-guardrails/`](../ai-guardrails/README.md): la iniciativa de Azure Policy de la pestaña Landing zone de IA.

## Sobre esta copia

La guía se escribe y se mantiene en un documento de Claude; esta carpeta es su exportación a Markdown del 19 de octubre de 2026. Los diagramas del documento se pasaron a Mermaid, que GitHub dibuja directamente. Una revisión automática actualiza el documento el día 1 de cada mes y anota los cambios en el [registro](20-registro-de-cambios.md). Esa revisión no toca esta carpeta: para traer sus cambios hay que volver a exportar el documento.

Los laboratorios usan archivos de prueba y datos ficticios. Nunca los ejecutes con secretos o datos reales.
