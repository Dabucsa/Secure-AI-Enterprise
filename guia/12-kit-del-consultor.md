# Kit del consultor

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Herramientas listas para usar con un cliente: un cuestionario con puntaje que lleva al modelo de madurez de la pestaña Marcos y cómo aplicarlos, cuatro talleres, una plantilla de informe, una hoja de ruta de 90 días, respuestas a las objeciones más comunes y una hoja de licencias. Todo se puede copiar a los documentos del cliente.

## 1. Cuestionario de evaluación

Veinticuatro preguntas, cuatro por dimensión. Cada respuesta vale de 0 a 4 y **solo cuenta con evidencia**: si el cliente dice que sí pero no puede mostrarlo, vale 1.

| Puntos | Significado |
| --- | --- |
| 0 | No existe |
| 1 | Existe de manera informal o sin evidencia |
| 2 | Existe en parte (algunos equipos, algunos sistemas) |
| 3 | Implementado en todo el alcance, con evidencia |
| 4 | Implementado, medido y revisado de forma periódica |

| # | Dimensión | Pregunta | Evidencia que pides |
| --- | --- | --- | --- |
| 1 | Inventario y gobierno | ¿Hay un inventario de apps de IA, modelos y agentes con dueño? | Exportación del registro de Agent 365, de MDA o de DSPM |
| 2 | Inventario y gobierno | ¿Hay una política de uso aceptable de IA publicada y comunicada? | Documento y registro de comunicación o formación |
| 3 | Inventario y gobierno | ¿Los casos de uso se clasifican por riesgo antes de aprobarse? | Formulario de alta y tres casos clasificados |
| 4 | Inventario y gobierno | ¿Un comité o responsable aprueba los casos de alto riesgo y los revisa? | Actas de las dos últimas reuniones |
| 5 | Identidad de agentes | ¿Los agentes propios usan Agent ID o identidades administradas, sin secretos? | Lista de identidades de agentes y sus credenciales |
| 6 | Identidad de agentes | ¿Cada agente tiene sponsor y permisos mínimos revisados? | Registro de sponsors y última revisión de acceso |
| 7 | Identidad de agentes | ¿Hay Conditional Access para agentes que bloquee el riesgo alto? | Política en el centro de administración de Entra |
| 8 | Identidad de agentes | ¿Los logs distinguen las acciones de agentes de las de personas? | Consulta de inicios de sesión filtrada por tipo de agente |
| 9 | Datos | ¿Se midió el oversharing antes de Copilot y se remedió? | Evaluación de DSPM antes y después |
| 10 | Datos | ¿Hay etiquetas en uso y DLP de Copilot que las respete? | Política de DLP y prueba con un archivo etiquetado |
| 11 | Datos | ¿Hay DLP para IA de consumo en equipos y navegador? | Política de DLP de equipo o de Edge y alertas recientes |
| 12 | Datos | ¿Auditoría y retención de interacciones de IA configuradas? | Política de retención en la ubicación de Copilot (no la de Teams) |
| 13 | Plataforma y red | ¿Las políticas de IA de Azure (sin claves, acceso privado) están en Deny? | Informe de cumplimiento del management group |
| 14 | Plataforma y red | ¿Hay un gateway de IA delante de los modelos? | Política del gateway y diagrama |
| 15 | Plataforma y red | ¿La salida de los agentes está restringida a destinos aprobados? | Reglas del firewall y prueba de bloqueo |
| 16 | Plataforma y red | ¿Los servidores MCP están registrados y detrás de un gateway? | Registro de servidores y configuración del gateway |
| 17 | Detección y respuesta | ¿Defender for AI Services está activo y sus alertas identifican al usuario? | Alerta de prueba con el usuario visible |
| 18 | Detección y respuesta | ¿Hay reglas de detección de IA en el SIEM, cada una con un evento de prueba? | Lista de reglas y resultado de las pruebas |
| 19 | Detección y respuesta | ¿Hay un playbook de incidente de IA probado (deshabilitar un agente)? | Playbook y registro de la última prueba |
| 20 | Detección y respuesta | ¿Se inventarían y protegen los agentes locales en los equipos? | Inventario de agentes locales de MDE y configuración de la protección |
| 21 | Pruebas y mejora | ¿Se hace red teaming antes de pasar a producción? | Informe del último red teaming |
| 22 | Pruebas y mejora | ¿Hay evaluaciones automáticas de seguridad y groundedness en el pipeline? | Configuración del pipeline y últimos resultados |
| 23 | Pruebas y mejora | ¿Hubo un simulacro de incidente de IA en el último año? | Informe del simulacro con acciones |
| 24 | Pruebas y mejora | ¿Se reportan métricas de seguridad de IA a la dirección? | Último informe o tablero |

**Cómo convertirlo en nivel.** Promedia las cuatro preguntas de cada dimensión. El nivel de madurez de esa dimensión es **la parte entera del promedio más uno**, con un máximo de 5: un promedio de 1,75 es nivel 2 (Visible); un promedio de 3,0 es nivel 4 (Gestionado). No promedies las dimensiones entre sí para dar un número único: el cliente necesita ver dónde está flojo, y un promedio general esconde justo eso.

Ejemplo: un cliente con Copilot desplegado y agentes de Copilot Studio responde 2, 1, 1, 0 en gobierno (promedio 1,0, nivel 2) y 3, 2, 2, 1 en datos (promedio 2,0, nivel 3). La conversación no es “están en 2,5” sino “protegen bien los datos, pero nadie sabe cuántos agentes hay ni quién responde por ellos”.

## 2. Talleres

### Taller de visión y riesgo de IA (2 horas, dirección)

| Tiempo | Bloque | Lo que sale del bloque |
| --- | --- | --- |
| 20 min | Qué cambió en 2026: agentes con identidad, regulación vigente, ataques reales (EchoLeak, agentes de programación) | Lenguaje común |
| 30 min | Casos de uso actuales y previstos, y su valor para el negocio | Lista priorizada de casos de uso |
| 30 min | Riesgos por caso de uso: datos, acciones, terceros, regulación | Mapa de riesgos de alto nivel |
| 25 min | Resultados de la línea base (si ya se midió) | Hallazgos que la dirección entiende |
| 15 min | Decisiones: apetito de riesgo, responsable, presupuesto | Dueño del programa y siguiente paso |

### Taller técnico de evaluación (medio día, equipos técnicos)

| Tiempo | Bloque | Lo que sale del bloque |
| --- | --- | --- |
| 45 min | Cuestionario por dimensión con los responsables de cada área | Puntaje con evidencia |
| 60 min | Revisión en vivo: Zero Trust Assessment, MDA, DSPM, cumplimiento de Azure Policy, inventario de agentes | Datos para la línea base |
| 45 min | Arquitectura de una carga de IA representativa | Brechas de diseño |
| 30 min | Licencias actuales frente a capacidades necesarias | Brechas de licencia |
| 30 min | Priorización de hallazgos | Borrador de hoja de ruta |

### Taller de modelado de amenazas de un caso de uso (3 horas)

1. Diagrama del flujo: usuario, app o agente, modelo, herramientas, datos, terceros (30 min).
2. Recorrido con OWASP LLM y Agentic Top 10 por cada flecha del diagrama (60 min).
3. Técnicas de MITRE ATLAS que aplican y qué se detectaría hoy (30 min).
4. Controles existentes y faltantes, con MCSB v2 como lista (45 min).
5. Riesgos residuales y quién los acepta (15 min).

Salida: modelo de amenazas firmado por el dueño del caso de uso, con los controles que bloquean el paso a producción.

### Simulacro de incidente de IA (2 horas)

Usa el escenario del Lab 17 o uno de los escenarios de la pestaña Visibilidad de agentes. Participan el SOC, el dueño del agente, comunicaciones y legal. Se mide cuánto se tarda en detectar, en saber qué agente fue, en deshabilitarlo y en decidir si hay que notificar.

## 3. Plantilla de informe

1. **Resumen ejecutivo** (una página): nivel por dimensión, los tres riesgos principales en lenguaje de negocio y las decisiones que se piden.
2. **Alcance y método:** qué se evaluó, con qué herramientas y en qué fechas.
3. **Línea base:** resultados de la Zero Trust Assessment, MDA, DSPM, Azure Policy e inventario de agentes.
4. **Hallazgos**, uno por fila, ordenados por severidad.
5. **Hoja de ruta** a 30, 60 y 90 días, con dueños.
6. **Riesgos aceptados** y quién los aceptó.
7. **Anexos:** cuestionario con evidencias, consultas usadas, capturas.

Formato de un hallazgo:

| Campo | Ejemplo |
| --- | --- |
| ID y título | IA-07 Agentes de Copilot Studio sin identidad de agente |
| Severidad | Alta |
| Evidencia | 38 de 41 agentes publicados se crearon antes del 18 de marzo de 2026 y usan service principals comunes (consulta de `AgentsInfo` sin `EntraAgentId`) |
| Riesgo | No se les puede aplicar Conditional Access para agentes ni detectar su riesgo en ID Protection; un agente comprometido no se distingue de una app |
| Recomendación | Recrear con Agent ID los 10 agentes con acceso a datos sensibles en 60 días; el resto en 120 |
| Esfuerzo y licencia | Medio; Agent 365 o E7 para la seguridad de agentes |
| Marco | MCSB v2 AI-4; OWASP ASI03; Zero Trust Workshop (identidad) |

## 4. Hoja de ruta de 90 días

Una plantilla que se ajusta con el puntaje del cuestionario. Complementa el plan de 90 días del capítulo de implementación, que es para la empresa; esta es para un compromiso de consultoría.

| Dimensión | Días 1 a 30: ver y frenar lo urgente | Días 31 a 60: controlar | Días 61 a 90: operar y medir |
| --- | --- | --- | --- |
| Inventario y gobierno | Inventario inicial con MDA, DSPM y registro de agentes; política de uso aceptable en borrador | Dueño y riesgo para cada agente y app; proceso de alta | Comité funcionando y primera revisión trimestral |
| Identidad de agentes | Lista de agentes sin identidad propia | Agent ID para los agentes críticos; Conditional Access por riesgo | Revisiones de acceso de agentes; plan para el resto |
| Datos | Evaluación de oversharing; RCD en sitios críticos; DLP de Copilot en simulación; retención de Copilot corregida | Limpieza de permisos; etiquetas por defecto; DLP en bloqueo; DLP de equipo y Edge | Insider Risk para IA; medición de oversharing antes y después |
| Plataforma y red | Políticas de IA de Azure en Audit | Políticas en Deny; gateway de IA; salida restringida | Gateway MCP; guardrails como código |
| Detección y respuesta | Defender for AI Services; alertas al SOC | Reglas de IA con eventos de prueba; protección de agentes locales en Audit | Playbook probado en un simulacro; protección en Block |
| Pruebas y mejora | Lista de casos de uso que necesitan red teaming | Red teaming del caso más crítico | Evaluaciones en el pipeline; métricas a la dirección |

Regla para elegir los primeros 30 días: todo lo que **reduce riesgo sin depender de nadie más** (activar auditoría, poner políticas en Audit, RCD en sitios críticos, corregir la retención de Copilot). Las decisiones que necesitan al negocio, como bloquear apps o cambiar permisos, van en el segundo mes con la línea base como argumento.

## 5. Objeciones y cómo responderlas

| Objeción | Respuesta |
| --- | --- |
| “Copilot respeta los permisos, no necesitamos nada más.” | Justamente por eso: Copilot usa todo lo que el usuario puede ver, incluido lo que nunca debió poder ver. La evaluación de oversharing muestra cuánto es, con datos del propio tenant. |
| “Bloqueemos ChatGPT y listo.” | El uso se va a los teléfonos personales y se pierde la visibilidad. Bloquea lo que no tiene alternativa empresarial, ofrece una aprobada y protege el contenido con Purview. |
| “No tenemos presupuesto para E5.” | Hay mucho que hacer con lo que ya tienen: auditoría y retención en E3, SharePoint Advanced Management con la licencia de Copilot, políticas de Azure sin costo de licencia. La línea base muestra qué riesgo queda sin E5 y cuánto cuesta cerrarlo. |
| “Microsoft se encarga de la seguridad de Foundry.” | Microsoft protege el servicio. La identidad de los agentes, los permisos, la salida a Internet, quién ve cada conversación y las pruebas adversarias son responsabilidad del cliente; la propia guía de Microsoft lo dice. |
| “Todavía no usamos agentes.” | El inventario suele decir otra cosa: agentes de Copilot Studio creados por el negocio y agentes de programación en los equipos de desarrollo. Mide antes de afirmarlo. |
| “Los desarrolladores necesitan auto-aprobación para ser productivos.” | En equipos sin acceso a producción, puede ser razonable. Con acceso a producción, un issue con instrucciones ocultas basta para filtrar secretos. Separa entornos y protege con la protección en tiempo de ejecución de MDE. |
| “Agent 365 es caro.” | Compara con el costo de no saber qué hizo un agente comprometido. Licencia por usuario, no por agente; empieza por los usuarios que crean o patrocinan agentes de riesgo. |
| “Nuestro SIEM no es Sentinel.” | Las señales de Defender, Entra y Purview se exportan a otros SIEM; lo importante es que los logs del gateway lleven el ID del agente y del usuario. |
| “El EU AI Act no nos aplica.” | Puede ser cierto. Igual conviene usarlo como estándar de documentación para los casos de alto riesgo: los reguladores de Latinoamérica lo usan de referencia y tus clientes europeos lo pedirán. |
| “Ya tenemos una política de IA aprobada.” | Una política sin controles técnicos que la midan es una intención. El cuestionario pide evidencia, no documentos. |

## 6. Hoja de licencias

Resumen de las pestañas Defender para IA y Purview para IA. Precios de lista en dólares a octubre de 2026; cambian por país y acuerdo.

| Necesidad | Licencia mínima | Nota |
| --- | --- | --- |
| Auditar y retener interacciones de Copilot | E3 | La retención necesita políticas propias desde octubre de 2026 |
| Ver prompts y respuestas en DSPM, DLP de Copilot por etiqueta, etiquetado automático | E5, o E3 más Purview Suite (12 USD) | El bloqueo de prompts por tipo de información puede no exigir E5: confírmalo |
| SharePoint Advanced Management | Incluido con licencias de Copilot | Salvo funciones del complemento Plan 1 |
| Descubrir y bloquear apps de IA | Defender for Cloud Apps más MDE, o E5 | Network protection en modo block |
| DLP para IA de consumo | E5 (equipo); Edge for Business sin pago por uso desde octubre de 2026 | Edge solo en Windows gestionado por Intune |
| DLP de red | E7, o Purview E5 más Entra Internet Access | SASE de terceros sigue con pago por uso |
| Inventario de agentes locales | MDE Plan 2 | Riesgo y recomendaciones: E7 o Agent 365 más MDE P2 |
| Protección de agentes locales | MDE P2, E5, Agent 365 o E7 | Solo Windows, preview |
| Protección de modelos en Azure | Defender for AI Services, por tokens | Solo Azure OpenAI y AI Model Inference |
| Postura de IA multinube | Defender CSPM | Bedrock y Vertex; confirma Google Cloud |
| Seguridad de agentes de Copilot Studio y Foundry, Insider Risk y DLP para agentes | Agent 365 (15 USD) o E7 (99 USD) | Agent 365 requiere E5, o E3 más Defender Suite y Purview Suite |
| API de Purview para apps propias | E5 más pago por uso | Sin pago por uso la API responde 402 |
| Security Copilot | Incluido en E5 | 400 unidades al mes por cada 1.000 licencias, hasta 10.000 |

## 7. Cómo presentar a la dirección

- **Una frase de riesgo por dimensión, en lenguaje de negocio.** “Cualquier empleado puede obtener por Copilot los sueldos de su área” dice más que “oversharing en 42 sitios”.
- **Un número que se pueda volver a medir.** Sitios críticos con enlaces amplios, agentes sin identidad, apps de IA sin decisión. El trimestre siguiente se muestra el mismo número.
- **La decisión que necesitas.** Presupuesto, un dueño o la aceptación formal de un riesgo. Si no pides nada, no pasa nada.

## 8. Para repasar

1. Un cliente responde “sí, tenemos inventario de agentes” pero solo muestra una planilla del año pasado. ¿Cuántos puntos le das y por qué?
2. Con promedios de 1,5 en identidad y 3,25 en plataforma, ¿qué nivel tiene cada dimensión y qué le dirías a la dirección?
3. ¿Qué tres acciones pondrías en los primeros 30 días de un cliente con Copilot ya desplegado, y por qué esas?
4. Responde la objeción “Microsoft se encarga de la seguridad de Foundry” con dos ejemplos concretos.
5. Un cliente con E3 y Copilot quiere DLP para agentes. ¿Qué necesita comprar?
