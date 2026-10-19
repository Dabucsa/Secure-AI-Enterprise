# Marcos y cómo aplicarlos

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Un cliente no necesita quince marcos; necesita saber **cuál responde cada pregunta**. El capítulo de gobierno explica NIST AI RMF, ISO/IEC 42001 y el EU AI Act. Esta pestaña agrega los marcos de Microsoft (CAF, WAF, MCSB v2, Zero Trust para IA, SFI) y muestra cómo combinarlos en un proyecto, con un modelo de madurez para medir al cliente.

La combinación que funciona casi siempre tiene cuatro piezas:

1. **La regulación** que aplica al cliente define lo obligatorio (EU AI Act, leyes locales de la pestaña Residencia y LatAm).
2. **Un sistema de gestión**: ISO/IEC 42001 si el cliente quiere certificar o le piden la certificación; si no, NIST AI RMF como lenguaje común de riesgos.
3. **Un catálogo de controles técnicos**: el dominio de IA de MCSB v2 en Azure y el pilar de IA de Zero Trust en el tenant.
4. **Un modelo de amenazas**: OWASP para la aplicación y los agentes, MITRE ATLAS para detecciones y red teaming.

## 1. Qué pregunta responde cada marco

| Marco | Tipo | Pregunta que responde | Estado a octubre de 2026 | Cómo se mide con Microsoft |
| --- | --- | --- | --- | --- |
| Cloud Adoption Framework para IA | Guía de adopción | ¿En qué orden adopto IA y con qué procesos? Fases Strategy, Plan, Ready y luego Govern, Secure y Manage de forma continua | Secure AI actualizado el 7 abr 2026; AI Ready el 14 oct 2026 | Listas de verificación de cada fase |
| Well-Architected Framework para IA | Guía de diseño de una carga | ¿Esta carga de IA está bien diseñada? La seguridad es transversal: “los controles se verifican, no se suponen del servicio administrado” | Sin página de seguridad propia; la seguridad recorre diseño, patrón y datos de grounding | AI workload assessment |
| AI Landing Zones | Implementación de referencia | ¿Cómo despliego la base? | GA desde el 17 nov 2025 según su repositorio | Lista de diseño (pestaña Landing zone de IA) |
| Microsoft cloud security benchmark v2 | Catálogo de controles técnicos en la nube | ¿Qué controles técnicos aplico en Azure? Agrega un dominio de seguridad de IA | Preview desde el 12 nov 2025; sin anuncio de GA | Cumplimiento normativo de Defender for Cloud (“MCSB v2 (preview)”) |
| Zero Trust para IA | Estrategia y plan de despliegue | ¿Qué hago en mi tenant, y en qué orden? | Anunciado el 19 mar 2026, ampliado el 4 ago 2026 con DevSecOps y memoria | Zero Trust Assessment (pilar de IA) y Workshop |
| Secure Future Initiative | Cómo se protege Microsoft | ¿Qué prácticas usa Microsoft? Seguro por diseño, por defecto y en operación | Informe de progreso de julio de 2026 | Patrones y prácticas del Trust Center |
| Responsible AI Standard | Principios de IA responsable | ¿Es justa, confiable, segura, inclusiva, transparente y con responsables? | Transparency Report 2026 (1 sep 2026) | Guardrails y evaluaciones de Foundry |
| NIST AI RMF 1.0 y perfil de IA generativa (AI 600-1) | Marco de gestión de riesgos | ¿Cómo gobierno, mapeo, mido y gestiono el riesgo de IA? | Voluntario; NIST anunció una revisión | Plantilla de Compliance Manager; la iniciativa de Azure Policy tiene una sola política |
| NIST Cyber AI Profile (IR 8596) | Perfil del CSF 2.0 | Proteger la IA, defender con IA y frenar ataques con IA | Borrador preliminar del 16 dic 2025 | — |
| NIST COSAiS (serie NISTIR 8605) | Overlays de controles SP 800-53 | ¿Qué controles 800-53 aplican a IA y a agentes? (8605D cubre agentes) | Sin borrador público a octubre de 2026; final previsto en 2027 | — |
| ISO/IEC 42001:2023 | Sistema de gestión certificable | ¿Puedo certificar cómo gestiono la IA? | Certificable; no es norma armonizada del AI Act | Plantilla premium de Compliance Manager |
| EU AI Act | Regulación | ¿Qué es obligatorio? | Calendario modificado por el Reglamento (UE) 2026/1744 (capítulo de gobierno) | Plantilla de Compliance Manager; iniciativa de Azure Policy con seis políticas |
| OWASP Top 10 para LLM (2025) y para aplicaciones agénticas (dic 2025) | Listas de riesgos | ¿Qué puede salir mal en mi app o agente? | Vigentes | Modelado de amenazas y pruebas |
| MITRE ATLAS | Tácticas y técnicas de ataque | ¿Cómo ataca un adversario a la IA? | v2026.09: 16 tácticas, 120 técnicas | Mapeo de detecciones y red teaming |
| CSA AI Controls Matrix | Matriz de controles para proveedores | ¿Qué controles le pido a un proveedor de IA? | v1.1 del 22 jun 2026: 247 controles en 18 dominios | Cuestionario AI-CAIQ y STAR for AI |

## 2. El dominio de IA de MCSB v2

MCSB v2 agregó el dominio **Artificial Intelligence Security** con siete recomendaciones ([anuncio, 12 nov 2025](https://techcommunity.microsoft.com/blog/microsoftdefendercloudblog/announcing-microsoft-cloud-security-benchmark-v2-public-preview/4468523)). Es el catálogo técnico más directo para un proyecto en Azure:

| ID | Recomendación | Cómo se implementa con Microsoft |
| --- | --- | --- |
| AI-1 | Usar solo modelos aprobados | Política de modelos aprobados en Foundry, escaneo de modelos de Defender, catálogo interno en registros de Machine Learning |
| AI-2 | Filtrado de contenido en varias capas | Content Safety y Prompt Shields en el despliegue, guardrails de agentes, `llm-content-safety` en el gateway |
| AI-3 | Meta-prompts de seguridad | Mensaje de sistema con reglas de seguridad, versionado y probado |
| AI-4 | Mínimo privilegio para las funciones de los agentes | Agent ID, RBAC mínimo, lista de herramientas permitidas en MCP |
| AI-5 | Humano en el circuito | Aprobación de acciones de alto riesgo en Foundry y en el gateway MCP |
| AI-6 | Monitoreo y detección | Defender for AI Services, Agent 365, Sentinel con reglas de IA |
| AI-7 | Red teaming continuo | AI Red Teaming Agent de Foundry (preview) y PyRIT (v1.1.0, septiembre de 2026) |

Los títulos de AI-5 y AI-6 son el tema verificado, no la redacción literal. Un dato para la conversación con el cliente: en la iniciativa de Azure Policy de MCSB v2 (`e3ec7e09`), **solo AI-1 tiene políticas asignadas** (cinco, todas en preview). Las otras seis son controles de diseño y de proceso: el porcentaje de cumplimiento de Defender for Cloud no los mide.

## 3. Zero Trust para IA en la práctica

Es la herramienta más útil para empezar un proyecto, porque mide el tenant real. La **Zero Trust Assessment** es un módulo de PowerShell que, desde 2026, corre por defecto siete pilares: identidad, dispositivos, red, datos, infraestructura, operaciones de seguridad e **IA** ([repositorio](https://github.com/microsoft/zerotrustassessment)):

```powershell
Install-PSResource -Name ZeroTrustAssessment
Connect-ZtAssessment
Invoke-ZtAssessment
```

El **Zero Trust Workshop** convierte el resultado en un plan. Su pilar de IA tiene 106 tareas; las más útiles para un consultor:

| Área | Tareas del Workshop (ejemplos) |
| --- | --- |
| Identidad | Exigir Entra ID para hablar con agentes; Conditional Access por riesgo para agentes; sponsors y dueños; migrar workload identities que se comportan como agentes a Agent ID; revisar los inicios de sesión de agentes |
| Inventario | Registro de Agent 365 y sincronización de plataformas externas |
| Red | Global Secure Access para agentes y filtrado de apps de IA; Prompt Shield en el tráfico de IA |
| Datos | Auditoría, DSPM, evaluación y remediación de oversharing para Copilot, DLP para Copilot y agentes, Insider Risk para IA y agentes, herencia de etiquetas, retención de prompts |
| Plataforma | Gateway de IA, API Management obligatorio delante de los servidores MCP, aprobación de servidores y herramientas MCP, Azure Policy para despliegues de modelos, protección contra amenazas |
| Pruebas | AI Red Teaming Agent, red teaming obligatorio para agentes nuevos y con cadencia, groundedness antes y durante la ejecución |
| SOC | Conectores de Sentinel, detecciones de inyección, playbooks, protección de agentes en tiempo real, hunting |
| Shadow AI | Descubrir y bloquear apps de IA no aprobadas con MDA; agentes locales en equipos |

**SFI como argumento.** La Secure Future Initiative no se “aplica” a un cliente, pero sus patrones (modelado de amenazas de IA, defensa en profundidad para agentes, observabilidad de IA, respuesta a incidentes de IA) son la mejor prueba de que lo que recomiendas es lo que Microsoft hace consigo misma.

## 4. Un control, varios marcos

Cuando un cliente tiene que responder a varios marcos a la vez, trabaja por **control**, no por marco. Esta tabla une los controles técnicos con los riesgos que mitigan y la herramienta que los implementa. Las funciones de NIST AI RMF son Govern, Map, Measure y Manage.

| Control | MCSB v2 | OWASP | MITRE ATLAS | NIST AI RMF | Con Microsoft |
| --- | --- | --- | --- | --- | --- |
| Modelos y componentes aprobados | AI-1 | LLM03 Supply Chain; ASI04 Agentic Supply Chain | AML.T0010 | Map, Manage | Política de modelos aprobados, AI-SPM, escaneo de modelos |
| Filtrado de entradas y salidas | AI-2 | LLM01 Prompt Injection; ASI01 Agent Goal Hijack | AML.T0051, AML.T0054 | Measure, Manage | Prompt Shields, guardrails, Defender for AI Services |
| Instrucciones de sistema protegidas | AI-3 | LLM07 System Prompt Leakage | — | Manage | Mensaje de sistema versionado; DLP sobre lo que el agente revela |
| Mínimo privilegio para agentes | AI-4 | LLM06 Excessive Agency; ASI02 Tool Misuse; ASI03 Identity and Privilege Abuse | — | Manage | Agent ID, RBAC, herramientas MCP permitidas |
| Aprobación humana | AI-5 | LLM06; ASI09 Human-Agent Trust Exploitation | — | Govern, Manage | Aprobaciones en Foundry y en el gateway MCP |
| Monitoreo y detección | AI-6 | LLM10 Unbounded Consumption; ASI10 Rogue Agents | AML.T0034 | Measure | Defender for AI Services, Agent 365, Sentinel |
| Pruebas adversarias | AI-7 | Todos | Todas las tácticas | Measure | AI Red Teaming Agent, PyRIT |
| Protección de datos sensibles | Dominio de protección de datos | LLM02 Sensitive Information Disclosure | AML.T0057 | Map, Manage | Purview: etiquetas, DLP, DSPM |
| Memoria y contexto | — | ASI06 Memory and Context Poisoning | — | Manage | Pestaña Memoria y extensibilidad |
| Comunicación entre agentes | — | ASI07 Insecure Inter-Agent Communication | — | Manage | Pestaña A2A a fondo; gateway A2A |

## 5. Cómo combinarlos en un proyecto

Una receta que funciona con la mayoría de los clientes:

1. **Obligaciones.** Lista la regulación que aplica (EU AI Act si opera en la UE o sus resultados se usan allá, leyes de datos y de IA locales) y clasifica cada caso de uso por riesgo.
2. **Sistema de gestión.** Si el cliente necesita certificar o se lo piden sus clientes, ISO/IEC 42001. Si no, NIST AI RMF como lenguaje de riesgos. Haz el seguimiento en Purview Compliance Manager con las plantillas de EU AI Act, ISO/IEC 42001, ISO/IEC 23894 y NIST AI RMF.
3. **Arquitectura.** CAF para el proceso, AI Landing Zones y la arquitectura de referencia de Foundry para la base, WAF para revisar cada carga.
4. **Controles técnicos.** MCSB v2 en Defender for Cloud para Azure; la Zero Trust Assessment y el Workshop para el tenant de Microsoft 365, Entra y Purview.
5. **Amenazas.** OWASP LLM y Agentic para el modelado de amenazas de cada app o agente; MITRE ATLAS para mapear detecciones y planificar el red teaming.
6. **Terceros.** El cuestionario AI-CAIQ de la CSA AI Controls Matrix para evaluar a los proveedores de IA.

Ejemplo: un banco en México que lanza un asistente de crédito y Copilot para sus empleados. La regulación local y su regulador definen las obligaciones; el asistente de crédito sería de alto riesgo bajo el EU AI Act si atendiera clientes en la UE, así que se documenta con ese estándar aunque no sea obligatorio; el banco adopta NIST AI RMF y deja ISO/IEC 42001 para el segundo año; la carga del asistente se construye sobre AI Landing Zones con la iniciativa de políticas; Copilot se prepara con la Zero Trust Assessment y DSPM; el red team usa ATLAS y el Top 10 agéntico.

## 6. Modelo de madurez

Sirve para la primera reunión y para medir avance trimestral. Cada celda describe la evidencia mínima del nivel.

| Dimensión | 1. Inicial | 2. Visible | 3. Controlado | 4. Gestionado | 5. Optimizado |
| --- | --- | --- | --- | --- | --- |
| Inventario y gobierno | No se sabe qué IA se usa | Inventario de apps y agentes con MDA y DSPM | Registro de agentes con dueño, sponsor y clasificación de riesgo | Comité de IA con aprobación por riesgo y revisión trimestral | Sistema de gestión certificado o auditado |
| Identidad de agentes | Agentes con secretos compartidos | Agentes identificados en Entra | Agent ID para todo agente propio, sin secretos | Conditional Access por riesgo y revisiones de acceso | Acceso just-in-time y permisos mínimos medidos |
| Datos | Sin etiquetas ni DLP para IA | Auditoría y DSPM activos, oversharing medido | Etiquetas y DLP de Copilot en producción | DLP en equipo, navegador y red; Insider Risk para IA | Protección de datos en agentes propios vía API |
| Plataforma y red | IA con claves y endpoints públicos | Políticas de IA en Audit | Políticas en Deny, private endpoints, gateway de IA | Salida cerrada, gateway MCP, guardrails como código | Landing zone de IA como producto con versiones |
| Detección y respuesta | Sin alertas de IA | Defender for AI Services y alertas en el SOC | Reglas de IA en Sentinel y playbook de incidente de IA | Protección de agentes en tiempo real y hunting | Simulacros de incidente de IA y métricas de respuesta |
| Pruebas y mejora | Nunca se probó un ataque | Pruebas manuales antes de lanzar | Red teaming antes de producción | Red teaming automatizado en el pipeline | Red teaming continuo y aprendizaje compartido |

Cómo puntuar: un nivel se alcanza solo con la evidencia del nivel completo. Un cliente que tiene DLP de Copilot pero no mide el oversharing sigue en el nivel 2 de datos.

## 7. Errores comunes

| Creencia | Realidad |
| --- | --- |
| “Microsoft está certificada en ISO/IEC 42001, así que nosotros también.” | Los certificados de Microsoft (Foundry Models y Security Copilot en 2025; Microsoft 365 Copilot recertificado en 2026) cubren sus sistemas. Tu sistema de gestión de IA es tuyo. |
| “Con ISO/IEC 42001 cumplimos el EU AI Act.” | Ayuda mucho, pero no es una norma armonizada del AI Act: no da presunción de conformidad. |
| “Defender for Cloud dice 90 % en MCSB v2, estamos cubiertos en IA.” | Solo AI-1 tiene políticas. Las otras seis recomendaciones de IA requieren evidencia de diseño y proceso. |
| “OWASP es un estándar de cumplimiento.” | Es una lista de riesgos para diseñar y probar. No se certifica. |
| “Zero Trust para IA es un producto.” | Es una estrategia con una herramienta de evaluación y un plan de tareas. Los productos son los que ya conoces. |
| “MCSB v2 ya es el estándar por defecto.” | Sigue en preview; el estándar por defecto de Defender for Cloud es MCSB v1. Actívalo a propósito. |

## 8. Para repasar

1. Un cliente te pide “cumplir con todos los marcos de IA”. ¿Cómo reduces el pedido a cuatro decisiones?
2. ¿Qué te dice y qué no te dice el porcentaje de cumplimiento de MCSB v2 en Defender for Cloud sobre la seguridad de IA?
3. ¿Qué herramienta usarías en la primera semana para medir el tenant de un cliente frente a Zero Trust para IA, y qué entregas después?
4. Mapea “un agente borra registros porque una página web le dio instrucciones” a OWASP, MCSB v2 y a dos controles de Microsoft.
5. ¿En qué nivel de madurez de identidad está un cliente cuyos agentes usan app registrations con secretos en Key Vault, y qué le falta para subir?

## Fuentes

- Repositorios públicos de Microsoft leídos el 18 de octubre de 2026: Cloud Adoption Framework, [Zero Trust Assessment](https://github.com/microsoft/zerotrustassessment) (pilar de IA y guía del Workshop), [Azure Policy](https://github.com/Azure/azure-policy) (iniciativas MCSB v2, NIST AI RMF y EU AI Act), [PyRIT](https://github.com/microsoft/PyRIT), [OWASP Top 10 para LLM](https://github.com/OWASP/www-project-top-10-for-large-language-model-applications) y [MITRE ATLAS](https://github.com/mitre-atlas/atlas-data)
- Microsoft Security Blog: [Zero Trust para IA](https://www.microsoft.com/en-us/security/blog/2026/03/19/new-tools-and-guidance-announcing-zero-trust-for-ai/) (19 mar 2026), [ampliación para agentes y DevSecOps](https://www.microsoft.com/en-us/security/blog/2026/08/04/advance-zero-trust-for-ai-new-tools-and-guidance-to-secure-ai-agents-and-devsecops/) (4 ago 2026), [informe de SFI de julio de 2026](https://www.microsoft.com/en-us/security/blog/2026/07/10/securing-our-future-july-2026-progress-report-on-microsofts-secure-future-initiative/)
- [Anuncio de MCSB v2](https://techcommunity.microsoft.com/blog/microsoftdefendercloudblog/announcing-microsoft-cloud-security-benchmark-v2-public-preview/4468523) (12 nov 2025) y [dominio de seguridad de IA](https://learn.microsoft.com/en-us/security/benchmark/azure/mcsb-v2-artificial-intelligence-security)
- NIST: [IR 8596, Cyber AI Profile](https://csrc.nist.gov/pubs/ir/8596/iprd) y [COSAiS](https://csrc.nist.gov/projects/cosais); CSA: AI Controls Matrix v1.1 (22 jun 2026)
- Leídas solo por buscador: el estado de NIST COSAiS, los títulos de AI-5 y AI-6 de MCSB v2 y el alcance de los certificados ISO/IEC 42001 de Microsoft (confírmalo en el Service Trust Portal).
