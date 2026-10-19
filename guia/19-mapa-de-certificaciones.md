# Mapa de certificaciones

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 17, 2026 · Danilo Bustamante

Este mapa dice qué capítulos, pestañas y laboratorios del libro cubren cada dominio de diez certificaciones de seguridad y gobierno de IA. El cambio que más mueve tu plan: **AZ-500 se retiró el 31 de agosto de 2026** y su reemplazo, **SC-500**, dedica un dominio entero a proteger cargas de IA.

## Ruta corta por examen

Si solo tienes una semana para un examen, lee estos capítulos y haz estos laboratorios. La última columna dice qué tendrás que estudiar en Microsoft Learn o en el material del emisor.

| Examen | Emisor | Lee primero | Labs clave | Lo que el libro no cubre |
| --- | --- | --- | --- | --- |
| SC-500 Cloud and AI Security Engineer | Microsoft | Cap. 3, 5, 6 y 9 | 7, 8, 10, 13, 15 | Máquinas virtuales, contenedores, bases de datos y redes fuera del contexto de IA |
| SC-100 Cybersecurity Architect | Microsoft | Cap. 2, 6, 10 y 13 | 8, 15, 17 | MCSB y Cloud Adoption Framework en general; arquitectura de identidad y SOC sin IA |
| SC-401 Information Security Administrator | Microsoft | Cap. 7 y 9.3 | 14 | Retención, gestión de registros, eDiscovery y riesgo interno a fondo |
| SC-200 Security Operations Analyst | Microsoft | Cap. 9.5 a 9.7 y 11 | 6, 10, 17 | Defender for Endpoint, Identity y Office 365 a fondo; KQL general |
| AI-103 Azure AI Apps and Agents Developer | Microsoft | Cap. 3, 5, 8, 9.1 y MCP a fondo | 1, 4, 5, 7, 13, 15 | Visión, análisis de texto y extracción de información: entre 30 y 45 % del examen |
| AB-900 Copilot and Agent Administration Fundamentals | Microsoft | Cap. 7 y 9.2 a 9.4 | 14 | Exchange, SharePoint y Teams fuera de Copilot: entre 30 y 35 % del examen |
| AB-100 Agentic AI Business Solutions Architect | Microsoft | Cap. 2, 8, 12 y A2A a fondo | 15, 18 | Dynamics 365, Power Platform y análisis de retorno de inversión |
| AAISM | ISACA | Cap. 4, 5, 10 y 13 | 3, 17 | Gestión de terceros y métricas del programa con más detalle |
| AIGP | IAPP | Cap. 10, 12 y 13 | 17 | Detalle legal por jurisdicción, ISO/IEC 42005 y reglas de decisiones automatizadas |
| SecAI+ | CompTIA | Cap. 3, 4, 5, 11 y Ataques con IA | 1, 2, 3, 4, 6, 19 | Fundamentos de aprendizaje automático: tipos de modelos y entrenamiento |

AAISM y SecAI+ son los que mejor calzan con el libro: casi todo su temario está en los capítulos 3 a 11. AI-103 y AB-900 son los que más estudio extra piden, porque buena parte de su temario no es seguridad.

## Microsoft, seguridad

### SC-500 Cloud and AI Security Engineer

Reemplaza a AZ-500 y está disponible desde julio de 2026. Es el examen de Microsoft con más IA: el dominio de cómputo nombra nueve tareas de IA, casi todas tratadas en el libro.

| Dominio (peso) | Qué pide sobre IA | Dónde está | Labs |
| --- | --- | --- | --- |
| Identidad, acceso y gobierno (20–25 %) | Entra ID, PIM, Key Vault y Azure Policy como base de cualquier carga de IA | Cap. 2 (landing zone) y 6 | 8, 9 |
| Almacenamiento, bases de datos y redes (25–30 %) | Endpoints privados y aislamiento de red de los recursos de IA | Cap. 2 y 7 | 8 |
| Cómputo, incluidas cargas de IA (20–25 %) | Oversharing con DSPM; protección en tiempo real de agentes de Copilot Studio; agentes en el centro de administración de Microsoft 365; Conditional Access para Entra Agent ID; radio de impacto en Defender XDR; AI gateway de API Management para Foundry; Defender for AI Services; guardrails de Foundry; panel de seguridad de datos e IA correlacionado con Sentinel | Cap. 3, 5, 6, 7, 9.1, 9.2, 9.4 y 9.5 | 7, 13, 14, 15 |
| Postura y monitoreo (20–25 %) | Defender CSPM con AI-SPM, Sentinel, Purview Audit y Security Copilot | Cap. 9.5 a 9.7 y 11 | 6, 10, 17 |

### SC-100 Cybersecurity Architect

Para obtener la certificación necesitas además SC-200, SC-300 o SC-500 (AZ-500 sigue contando por un tiempo si ya la tenías). Las preguntas de IA son de diseño: qué controles van y en qué orden.

| Dominio (peso) | Qué pide sobre IA | Dónde está | Labs |
| --- | --- | --- | --- |
| Buenas prácticas y prioridades (20–25 %) | Soluciones de IA alineadas al Microsoft Cloud Security Benchmark; estrategia de adopción segura de IA con CAF y Well-Architected | Cap. 2 y 13 | 8 |
| Operaciones, identidad y cumplimiento (25–30 %) | Diseñar identidades de agentes con Entra Agent ID y Conditional Access | Cap. 6, 10 y 11 | 15, 17 |
| Infraestructura (25–30 %) | AI landing zone, gateway y aislamiento de red | Cap. 2 y 3 | 8, 13 |
| Aplicaciones y datos (20–25 %) | Seguridad de los datos que usan las cargas de IA | Cap. 5, 7, 8 y MCP a fondo | 5, 15 |

### SC-401 Information Security Administrator

Los tres dominios pesan entre 30 y 35 % cada uno. La IA aparece como grupo propio, “Proteger datos usados por servicios de IA”, dentro del tercer dominio.

| Dominio (peso) | Qué pide sobre IA | Dónde está | Labs |
| --- | --- | --- | --- |
| Protección de la información (30–35 %) | Etiquetas de sensibilidad que Copilot y los agentes respetan | Cap. 7 | 14 |
| DLP y retención (30–35 %) | DLP para Copilot y apps de IA; retención de interacciones | Cap. 7 | 14 |
| Riesgos, alertas y actividades (30–35 %) | DSPM for AI: requisitos, roles, políticas y monitoreo de actividad; controles de Purview y de Microsoft 365 para IA | Cap. 7, 9.3 y 11 | 14 |

### SC-200 Security Operations Analyst

Temario vigente desde el 28 de julio de 2026, con pesos tomados de fuentes de terceros. Agrega investigación con IA agéntica y el data lake de Sentinel.

| Dominio (peso) | Qué pide sobre IA | Dónde está | Labs |
| --- | --- | --- | --- |
| Gestionar el entorno de operaciones (40–45 %) | Conectores, reglas analíticas y data lake de Sentinel | Cap. 11 | 6, 10 |
| Responder a incidentes (35–40 %) | Investigar con IA agéntica y Security Copilot integrado | Cap. 9.7 y 11 | 17 |
| Threat hunting (20–25 %) | Jobs de KQL en el data lake, Sentinel graph y notebooks con el servidor MCP de Sentinel | Cap. 9.6, 11, MCP a fondo y Ataques con IA (cazas 1 a 3) | 6 |

## Microsoft, IA y Copilot

### AI-103 Azure AI Apps and Agents Developer

Sucesor de AI-102. Los dos primeros dominios suman entre 55 y 65 % del examen y el libro los cubre desde el lado de la seguridad; los otros tres no son de seguridad.

| Dominio (peso) | Qué pide | Dónde está | Labs |
| --- | --- | --- | --- |
| Planear y gestionar una solución de Azure AI (25–30 %) | Elegir el servicio en Foundry, desplegar, asegurar, cuotas, costos y monitoreo | Cap. 2, 3, 6 y 9.1 | 7, 8, 13 |
| Soluciones generativas y agénticas (30–35 %) | Agentes con herramientas, RAG, function calling, memoria y orquestación | Cap. 5, 8, 9.1, MCP a fondo, A2A a fondo y Memoria y extensibilidad | 1, 4, 5, 15, 18 |
| Visión, análisis de texto y extracción de información (10–15 % cada uno) | Servicios de visión, lenguaje y Document Intelligence | Fuera del libro: estudia en Microsoft Learn | Ninguno |

### AB-900 Copilot and Agent Administration Fundamentals

Examen de fundamentos; temario del 22 de julio de 2026. El dominio más pesado es protección de datos para Copilot, que es justo el capítulo 7.

| Dominio (peso) | Qué pide | Dónde está | Labs |
| --- | --- | --- | --- |
| Funciones y objetos de Microsoft 365 (30–35 %) | Licencias, centros de administración, Zero Trust y Entra ID | Cap. 6, solo la parte de identidad | Ninguno |
| Protección de datos y gobierno para Microsoft 365 y Copilot (35–40 %) | Purview, permisos que usa Copilot, oversharing en SharePoint y descubrimiento de datos sensibles | Cap. 7 y 9.3 | 14 |
| Administración de Copilot y agentes (25–30 %) | Licencias y facturación, tipos de agentes, creación, aprobación y monitoreo de uso | Cap. 9.2, 9.4 y Memoria y extensibilidad | 14 |

### AB-100 Agentic AI Business Solutions Architect

No encontré pesos publicados que pudiera confirmar. La guía oficial nombra MCP y A2A como protocolos abiertos que el arquitecto debe conocer.

| Dominio | Qué pide | Dónde está | Labs |
| --- | --- | --- | --- |
| Planear soluciones de negocio con IA | Casos de uso, priorización y retorno de inversión | Cap. 1, 12 y 13 | Ninguno |
| Diseñar arquitecturas de IA y agentes | Diseño centrado en agentes, multiagente, MCP y A2A | Cap. 2, 8, MCP a fondo y A2A a fondo | 15, 18 |
| Desplegar, monitorear y gobernar IA a escala | Agent 365, ciclo de vida de agentes y operación | Cap. 9.4, 10 y 11 | 17 |

## Neutrales

### AAISM (ISACA)

Requiere CISM o CISSP vigente. Son 90 preguntas en 150 minutos y se aprueba con 450 sobre 800. Las preguntas son de gestión: quién decide, en qué orden y con qué evidencia.

| Dominio (peso) | Qué cubre | Dónde está | Labs |
| --- | --- | --- | --- |
| Gobierno y gestión del programa de IA (31 %) | Políticas, roles, inventario, comité y ciclo de vida | Cap. 10 y 13 | 17 |
| Gestión de riesgos y oportunidades de IA (31 %) | Identificar, analizar y tratar riesgos de IA; threat modeling | Cap. 4, 10 y 12 | 3, 17 |
| Tecnologías y controles de IA (38 %) | Arquitectura, gateway, identidad, datos, agentes y cadena de suministro | Cap. 3, 5, 6, 7 y 8 | 1, 2, 4, 5, 19 |

### AIGP (IAPP)

El temario 2.1 rige desde el 2 de febrero de 2026. Agregó arquitecturas agénticas en el dominio IV y amplió la gestión de terceros en el dominio I. No encontré pesos oficiales por dominio.

| Dominio | Qué cubre | Dónde está | Labs |
| --- | --- | --- | --- |
| I. Fundamentos del gobierno de IA | Principios, roles, políticas, uso aceptable y riesgo de terceros | Cap. 1 y 10 | Ninguno |
| II. Leyes, estándares y marcos | EU AI Act, NIST AI RMF, ISO/IEC 42001 y leyes de protección de datos | Cap. 10 | Ninguno |
| III. Gobernar el desarrollo de IA | Evaluación de impacto, pruebas y red teaming | Cap. 4, 5 y 11 | 3 |
| IV. Gobernar el despliegue y el uso | Modelos propios o de terceros, agentes, monitoreo e incidentes | Cap. 6, 9.4, 12 y 13 | 17 |

### SecAI+ (CompTIA)

Examen CY0-001, lanzado el 17 de febrero de 2026. Es el más técnico de los tres y el 40 % trata de asegurar sistemas de IA.

| Dominio (peso) | Qué cubre | Dónde está | Labs |
| --- | --- | --- | --- |
| Conceptos básicos de IA para ciberseguridad (17 %) | Tipos de IA, LLM, agentes y superficie de ataque | Cap. 1 y 4 | Ninguno |
| Asegurar sistemas de IA (40 %) | Inyección, gateway, guardrails, identidad, datos, MCP, A2A y modelos | Cap. 3 a 8, MCP a fondo y A2A a fondo | 1, 2, 4, 5, 16, 19 |
| Seguridad asistida por IA (24 %) | IA en el SOC, detección y respuesta | Cap. 9.7, 11 y Ataques con IA | 3, 6 |
| Gobierno, riesgo y cumplimiento de IA (19 %) | Marcos, regulación y modelo operativo | Cap. 10 | Ninguno |

## Pestañas de nivel experto por certificación

Las pestañas agregadas en octubre de 2026 profundizan los dominios de estas certificaciones. Úsalas después de los capítulos indicados arriba.

| Certificación | Pestañas que la refuerzan | Labs |
| --- | --- | --- |
| SC-500 Cloud Security Engineer | Landing zone de IA, Defender para IA (Defender for Cloud), Agentes con Entra | 21 y 24 |
| SC-100 Cybersecurity Architect | Marcos y cómo aplicarlos, Landing zone de IA, Visibilidad de agentes, Proyectos de cliente | 24 |
| SC-401 Information Security Administrator | Purview para IA | 23 |
| SC-200 Security Operations Analyst | Defender para IA, Visibilidad de agentes | 22 y el paquete de detecciones |
| AI-103 | Agentes con Entra, Landing zone de IA | 21 |
| AB-900 Copilot and Agent Administration Fundamentals | Purview para IA, Proyectos de cliente (Copilot y Copilot Studio) | 23 |
| AB-100 | Agentes con Entra, Visibilidad de agentes, Proyectos de cliente | 21 |
| AAISM, AIGP y SecAI+ | Marcos y cómo aplicarlos, Kit del consultor, Casos de experto | — |

## Cómo se armó y fuentes

Desde el entorno donde armé este mapa no pude abrir Microsoft Learn, ISACA, IAPP ni CompTIA. Los pesos vienen de las guías oficiales tal como las citan resúmenes de terceros. SC-500 y AB-900 los contrasté con repositorios de cursos que copian el temario oficial. Microsoft anunció cambios de temario en SC-100 y SC-200 para el 21 de octubre de 2026: abre la guía oficial antes de reservar.

**Guías oficiales (para confirmar)**

- [SC-500](https://learn.microsoft.com/credentials/certifications/exams/sc-500/), [SC-100](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/sc-100), [SC-401](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/sc-401), [SC-200](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/sc-200)
- [AI-103](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/ai-103), [AB-900](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/ab-900), [AB-100](https://learn.microsoft.com/en-us/credentials/certifications/resources/study-guides/ab-100)
- [AAISM en ISACA](https://www.isaca.org/credentialing/aaism), [AIGP Body of Knowledge en IAPP](https://iapp.org/certify/body-of-knowledge-aigp)

**Fuentes consultadas**

- [Temario SC-500 replicado por Tim Warner](https://github.com/timothywarner-org/sc500/blob/main/docs/exam-objectives.md) y [guía AB-900](https://github.com/timothywarner-org/ab900/blob/main/shared-resources/references/AB-900-EXAM-GUIDE.md)
- [Retiro de AZ-500 y reemplazo por SC-500](https://trainingcamp.com/articles/az-500-retires-august-31-2026-sc-500-replaces-it-2/) y [retiros de 2026](https://vladtalkstech.com/microsoft-learning-and-credential-news/microsoft-certification-retirements-2026/)
- [SC-200 tras el cambio de julio de 2026](https://www.certcrush.app/blog/how-to-pass-sc-200-2026-8-week-study-plan) y [SC-401](https://charbelnemnom.com/sc-401-exam-study-guide/)
- [AI-103 por dominio](https://open-exam-prep.com/blog/microsoft-ai-103-practice-questions-skills-2026)
- [AAISM: formato y dominios](https://destcert.com/resources/aaism-exam-structure/), [AIGP 2.1: qué cambió](https://trainingcamp.com/articles/how-to-study-for-the-aigp-a-learning-path-built-around-the-bok-v2-1-blueprint/)
- [SecAI+ CY0-001](https://www.acilearning.com/blog/comp-tia-sec-ai-a-complete-guide-to-the-ai-security-certification/)
