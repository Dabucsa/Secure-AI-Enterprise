# Proyectos de cliente

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Ocho tipos de proyecto cubren casi todo lo que un cliente pide sobre seguridad de IA con Microsoft. Cada guía tiene el mismo formato: cuándo aplica, preguntas de descubrimiento, controles mínimos, licencias, entregables, criterios de aceptación medibles y errores comunes. El detalle técnico de cada control está en la pestaña que se indica.

## Cómo arranca cualquier proyecto

**Quién tiene que estar en la sala.** Seguridad (CISO o su equipo), plataforma o infraestructura, datos o privacidad (DPO), legal o cumplimiento, y el dueño del negocio del caso de uso. Si falta el dueño del negocio, nadie puede aceptar el riesgo residual; si falta privacidad, el proyecto se frena en la evaluación de impacto.

**Cinco preguntas que siempre se hacen:**

1. ¿Qué casos de uso de IA hay hoy en producción o en piloto, y cuáles vienen en los próximos seis meses?
2. ¿Qué licencias tiene (E3, E5, E7, Copilot, Agent 365, planes de Defender for Cloud) y qué está dispuesto a comprar?
3. ¿Qué datos tocará la IA y cómo están clasificados? ¿Hay etiquetas de Purview en uso?
4. ¿Qué regulación aplica (sector, país, EU AI Act) y quién la interpreta en la empresa?
5. ¿Quién opera la seguridad (SOC propio, MSSP, Sentinel, otro SIEM)?

**El primer entregable siempre es el mismo:** una línea base medida (Zero Trust Assessment con el pilar de IA, informe de shadow AI de Defender for Cloud Apps, evaluación de oversharing de DSPM y cumplimiento de las políticas de IA en Azure). Sin línea base no hay forma de demostrar avance.

## 1. Landing zone de IA en Azure

**Cuándo:** el cliente va a construir apps o agentes propios en Foundry o Azure OpenAI y quiere una base común. Detalle en la pestaña Landing zone de IA.

**Preguntas de descubrimiento:**

- ¿Tiene platform landing zone (hub, firewall, DNS privado, Log Analytics) o hay que construirla?
- ¿Qué modelos y publicadores están aprobados? ¿Quién los aprueba?
- ¿Las apps serán internas, para clientes o ambas?
- ¿Qué requisitos de residencia tiene (despliegue global, Data Zone o regional)?
- ¿Los agentes necesitan salir a Internet o a APIs de terceros?

**Controles mínimos:** IA bajo Corp u Online con la iniciativa de políticas de IA; sin claves de acceso; private endpoints y DNS privado; salida por firewall con lista de dominios; gateway de IA con API Management; Defender for AI Services y Defender CSPM; logs de diagnóstico en Log Analytics.

**Licencias:** consumo de Azure (Foundry, API Management, Azure Firewall), Defender for AI Services (por tokens) y Defender CSPM.

**Entregables:** diseño de la landing zone con decisiones registradas; IaC (AI Landing Zones o propia) con la iniciativa de políticas; política del gateway como código; lista de modelos aprobados; runbook de operación.

**Criterios de aceptación:**

- Cero recursos de IA con acceso por clave y la política en Deny.
- Ningún servicio de IA ni dependencia con acceso público, salvo la entrada con WAF.
- Una llamada de prueba a un dominio no permitido desde un agente es bloqueada por el firewall.
- Una alerta de prueba de Defender for AI Services llega al SOC con el usuario identificado.

**Errores comunes:** crear un management group “IA”; dejar el jumpbox con roles amplios; olvidar que la búsqueda web de Foundry no pasa por la subred de salida; pasar a Deny sin remediar lo existente.

## 2. Despliegue de Microsoft 365 Copilot

**Cuándo:** el cliente compró o va a comprar Copilot y quiere hacerlo sin exponer datos. Es el proyecto más pedido. Detalle en las pestañas Purview para IA y Memoria y extensibilidad.

**Preguntas de descubrimiento:**

- ¿Cuántos sitios de SharePoint y equipos tiene, y cuántos con enlaces “Everyone except external users”?
- ¿Hay etiquetas de confidencialidad publicadas y en uso real?
- ¿Qué retención necesita para las conversaciones de Copilot?
- ¿Va a permitir agentes, conectores y la búsqueda web?
- ¿Qué grupo piloto y qué casos de uso medirá el negocio?

**Controles mínimos:** evaluación de oversharing de DSPM y de SharePoint Advanced Management; limpieza de enlaces amplios en sitios críticos y RCD como medida temporal; etiquetas por defecto en bibliotecas sensibles; DLP de Copilot que excluya la etiqueta más alta; política de retención propia para Copilot (las de Teams dejaron de cubrirlo en octubre de 2026); gestión de agentes en el centro de administración; auditoría activa.

**Licencias:** licencia de Copilot (trae SharePoint Advanced Management); E3 para auditoría y retención; E5 o Purview Suite para DSPM completo, DLP por etiqueta, etiquetado automático e Insider Risk.

**Entregables:** informe de oversharing con plan de remediación; políticas de DLP, etiquetas y retención; política de uso de Copilot y agentes; materiales de formación; tablero de adopción y riesgo.

**Criterios de aceptación:**

- Ningún sitio clasificado como crítico con enlaces amplios, o todos bajo RCD con fecha de remediación.
- DLP de Copilot en modo bloqueo para la etiqueta más alta, probado con un archivo de prueba.
- Política de retención en la ubicación “Microsoft Copilot experiences”.
- Una prueba de inyección con un correo de prueba no logra exfiltrar datos.

**Errores comunes:** encender Copilot y “ver qué pasa”; usar RCD como solución definitiva; asumir que la retención de Teams cubre Copilot; no medir el oversharing antes y después.

## 3. Agentes con Copilot Studio y Power Platform

**Cuándo:** el negocio crea agentes sin código y el cliente quiere ponerles reglas antes de que haya cientos. Detalle en las pestañas Agentes con Entra, Defender para IA y Visibilidad de agentes.

**Preguntas de descubrimiento:**

- ¿Cuántos entornos de Power Platform hay y quién puede crear agentes en cada uno?
- ¿Qué conectores usan los agentes y hacia qué sistemas de negocio?
- ¿Hay agentes publicados sin autenticación o compartidos con toda la organización?
- ¿Los agentes se crearon antes del 18 de marzo de 2026? Desde esa fecha Copilot Studio crea identidades de Agent ID para los agentes nuevos; los anteriores usan service principals que Entra trata como apps comunes.
- ¿Quién responde por cada agente?

**Controles mínimos:** estrategia de entornos (personal, equipo, producción) con Managed Environments; directivas de datos de Power Platform que separen conectores de negocio y conectores externos; autenticación obligatoria y límites de compartición; Agent ID para todos los agentes de producción; dueño y sponsor registrados; DLP de Purview para el contenido; protección en tiempo real de Defender (preview) y Agent 365 para inventario y detección.

**Licencias:** Copilot Studio (capacidad o por mensaje), Agent 365 o E7 para la seguridad de los agentes desde el 1 de julio de 2026, E5 para Purview completo.

**Entregables:** estrategia de entornos y directivas de datos; inventario de agentes con dueño y riesgo; plan para recrear con Agent ID los agentes antiguos (no hay migración automática: se crea un agente nuevo y se retira el viejo); proceso de aprobación de agentes.

**Criterios de aceptación:**

- Ningún agente de producción sin autenticación ni sin dueño.
- Todos los agentes de producción con Agent ID, o con fecha de recreación acordada.
- Una directiva de datos bloquea un conector no aprobado en el entorno de producción (probado).
- Los agentes aparecen en el inventario de Defender y en el registro de Agent 365.

**Errores comunes:** confundir las directivas de datos de Power Platform con Purview DLP (controlan conectores, no contenido); un único entorno para todos; creer que la licencia de Defender for Cloud Apps sigue cubriendo la seguridad de los agentes; no tener a quién llamar cuando un agente falla.

## 4. Agentes y apps propios en Foundry

**Cuándo:** desarrollo propio con Foundry Agent Service, Agent Framework u otros frameworks. Detalle en Agentes con Entra, Landing zone de IA y MCP a fondo.

**Preguntas de descubrimiento:**

- ¿Los agentes actúan en nombre del usuario, solos o de las dos formas?
- ¿Qué herramientas tienen y cuáles pueden cambiar o borrar datos?
- ¿Qué framework y dónde se ejecutan (Foundry, Container Apps, AKS, otra nube)?
- ¿Quién ve las conversaciones y por cuánto tiempo se guardan?
- ¿Hay un proceso de pruebas adversarias antes de publicar?

**Controles mínimos:** Agent ID por agente, sin secretos (credencial federada en el blueprint); un proyecto de Foundry por patrón de acceso; guardrails con Prompt Shields en el modelo y en el agente; aprobación humana para herramientas de alto riesgo; la app valida la propiedad de cada conversación; `user_security_context` en las llamadas a Azure OpenAI; Purview con el token del usuario; red teaming antes de producción.

**Licencias:** consumo de Foundry, Defender for AI Services, Agent 365 para la seguridad de agentes publicados, E5 más pago por uso si se usa la API de Purview.

**Entregables:** modelo de amenazas con OWASP Agentic y ATLAS; diseño de identidades; guardrails como código; informe de red teaming; runbook de incidente para deshabilitar un agente.

**Criterios de aceptación:**

- Ningún agente con secretos; todos con Agent ID y sponsor.
- Una inyección indirecta de prueba (documento o página con instrucciones) no ejecuta la herramienta de alto riesgo.
- Un usuario no puede leer la conversación de otro (probado contra la API de la app).
- La alerta de jailbreak de prueba identifica al usuario final.

**Errores comunes:** dar a todos los agentes de un proyecto los mismos permisos sin darse cuenta; usar la identidad del servicio para todo y perder el contexto del usuario; publicar sin red teaming; probar en el playground y creer que está protegido como un agente publicado.

## 5. RAG sobre datos de la empresa

**Cuándo:** una app o agente responde con documentos internos (políticas, contratos, tickets). Es donde más se filtran datos sin que nadie lo note.

**Preguntas de descubrimiento:**

- ¿De dónde salen los documentos y quién puede verlos en el origen?
- ¿El índice copia los permisos del origen o todos los usuarios ven todo?
- ¿Hay documentos con etiquetas de confidencialidad o datos personales?
- ¿La app consulta con la identidad del usuario o con la del servicio?
- ¿Los documentos pueden contener texto de terceros (correos, páginas web) que actúe como instrucciones?

**Controles mínimos:** recorte por permisos en el índice o consulta al origen con el token del usuario; respeto de etiquetas de Purview en el índice (Azure AI Search lo tendrá en GA en octubre de 2026 según el roadmap); minimizar datos personales en el índice; spotlighting y Prompt Shields para documentos; evaluaciones de groundedness; private endpoints en AI Search y en el almacenamiento.

**Licencias:** consumo de AI Search y Foundry; E5 para clasificación y etiquetado automático de las fuentes.

**Entregables:** matriz de fuentes con su clasificación y modelo de permisos; diseño del recorte por usuario; conjunto de pruebas de fuga y de inyección; métricas de groundedness.

**Criterios de aceptación:**

- Un usuario sin acceso a un documento en el origen no obtiene su contenido en la respuesta (probado con dos usuarios).
- Un documento con instrucciones ocultas no cambia el comportamiento del agente.
- Ningún documento etiquetado como “Altamente confidencial” entra al índice, salvo que el recorte por usuario esté probado.

**Errores comunes:** indexar todo con la identidad del servicio y “filtrar en el prompt”; no probar el recorte con usuarios reales; olvidar que el índice es una copia que también hay que proteger y retener.

## 6. MCP, plataformas de agentes y agentes de programación

**Cuándo:** la empresa conecta agentes a herramientas internas con MCP, o sus desarrolladores usan agentes como Claude Code, Codex o GitHub Copilot. Detalle en MCP a fondo, A2A a fondo y Defender para IA.

**Preguntas de descubrimiento:**

- ¿Qué servidores MCP existen, quién los construyó y con qué credenciales acceden a los sistemas?
- ¿Los clientes MCP se conectan directo o a través de un gateway?
- ¿Qué agentes de programación usan los desarrolladores, con auto-aprobación o sin ella?
- ¿Hay secretos de producción en los equipos de desarrollo?
- ¿Quién aprueba un servidor MCP nuevo o una herramienta nueva?

**Controles mínimos:** registro de servidores MCP aprobados con huella de sus herramientas; gateway MCP con API Management y autenticación de Entra; herramientas permitidas por agente y aprobación humana para las de alto riesgo; descubrimiento de agentes locales en MDE y protección en tiempo de ejecución en Audit y luego Block; sin auto-aprobación para agentes con acceso a producción; secretos fuera de los equipos.

**Licencias:** MDE Plan 2 para inventario y protección de agentes locales; E7 o Agent 365 más MDE P2 para su riesgo y recomendaciones; consumo de API Management.

**Entregables:** registro de servidores MCP y proceso de alta; política de uso de agentes de programación; configuración del gateway; reglas de detección (MCP-001 a MCP-004 del paquete de Sentinel).

**Criterios de aceptación:**

- Ningún servidor MCP accesible sin pasar por el gateway.
- Un cambio en las herramientas de un servidor dispara la alerta de huella distinta.
- El inventario de agentes locales no muestra agentes con auto-aprobación en equipos con acceso a producción.
- La protección en tiempo de ejecución bloquea el prompt de prueba de Microsoft.

**Errores comunes:** pensar que el MCP local es “solo del desarrollador”; aprobar un servidor una vez y no vigilar sus cambios; usar tokens personales de larga vida en los agentes.

## 7. Uso seguro de IA generativa (shadow AI)

**Cuándo:** el cliente sabe o sospecha que los empleados usan ChatGPT, Gemini u otras apps con datos de la empresa. Suele ir junto con el proyecto de Copilot. Detalle en Defender para IA y Purview para IA.

**Preguntas de descubrimiento:**

- ¿Qué apps de IA se usan hoy, cuánto y desde qué equipos?
- ¿Los equipos están gestionados con Intune y tienen MDE? ¿Qué navegadores usan?
- ¿Hay una alternativa aprobada (Copilot Chat, ChatGPT Enterprise) para ofrecer?
- ¿Qué datos no pueden salir nunca (clientes, salud, código fuente)?
- ¿Existe una política de uso aceptable de IA?

**Controles mínimos:** descubrimiento con MDA (integración con MDE) y decisión por app (aprobada, vigilada o bloqueada); bloqueo de las apps no aprobadas con network protection; DLP de equipo con la extensión y protección en línea de Edge for Business para el contenido; Insider Risk con Risky AI usage; una alternativa aprobada y comunicada; formación.

**Licencias:** E5 (o MDA y MDE, y Purview Suite); pago por uso para algunos indicadores de apps que no son de Microsoft; Entra Internet Access si se usa la red.

**Entregables:** informe de shadow AI con los datos de uso; política de uso aceptable; lista de apps con su decisión; políticas de DLP; plan de comunicación.

**Criterios de aceptación:**

- Ninguna app de IA generativa con uso significativo sin decisión registrada.
- Pegar un dato de prueba sensible en una app de IA de consumo desde un equipo gestionado es bloqueado o avisado según la política.
- El uso de la alternativa aprobada crece mes a mes.

**Errores comunes:** bloquear todo sin ofrecer alternativa (el uso se va a los teléfonos personales); olvidar QUIC y Encrypted Client Hello; creer que los controles de sesión sirven para cuentas personales.

## 8. SOC con IA y detección de amenazas de IA

**Cuándo:** el cliente quiere que su SOC detecte y responda a incidentes de IA, y a la vez usar IA en el SOC. Detalle en el capítulo de operaciones, Ataques con IA, Visibilidad de agentes y el [paquete de detecciones](../ai-detections/README.md) de este repositorio.

**Preguntas de descubrimiento:**

- ¿Qué SIEM usa y qué conectores de Microsoft tiene activos?
- ¿Las alertas de Defender for AI Services, Agent 365 y Purview llegan hoy al SOC?
- ¿Hay playbooks para un incidente de IA (deshabilitar un agente, revocar tokens, retener evidencia)?
- ¿Usa Security Copilot? Viene incluido con E5 desde noviembre de 2025 (400 unidades al mes por cada 1.000 licencias, hasta 10.000).
- ¿Quién investiga cuando el incidente involucra a un agente y no a una persona?

**Controles mínimos:** conectores de Entra (inicios de sesión, auditoría y riesgo), Defender XDR y auditoría de Purview; reglas de detección de IA (paquete de Sentinel); logs del gateway de IA y MCP con el ID del agente y del usuario; playbook de incidente de IA probado en un simulacro; retención de trazas mayor a los 30 días de Agent 365.

**Licencias:** Sentinel por ingesta o data lake; E5 para Security Copilot incluido; Agent 365 para la detección en agentes.

**Entregables:** catálogo de detecciones de IA mapeado a MITRE ATLAS; playbooks; informe del simulacro (Lab 17); tablero de incidentes de IA.

**Criterios de aceptación:**

- Cada regla de IA tiene un evento de prueba que la dispara.
- El SOC deshabilita la identidad de un agente comprometido en menos de 15 minutos en el simulacro.
- Los incidentes de IA tienen el agente como entidad y se pueden unir con el usuario.

**Errores comunes:** activar reglas sobre tablas que no reciben datos; no saber cómo “apagar” un agente; tratar la protección de prompts como si fuera la única defensa.

## Proyectos que suelen ir juntos

| Si el cliente pide | Suele necesitar también | Por qué |
| --- | --- | --- |
| Copilot | Shadow AI | Mientras se prepara Copilot, la gente sigue usando IA de consumo |
| Agentes en Copilot Studio | Visibilidad de agentes y SOC | Sin inventario ni detección, cada agente nuevo es un punto ciego |
| Agentes propios en Foundry | Landing zone de IA y MCP | Los agentes necesitan base, salida controlada y herramientas gobernadas |
| RAG | Purview (etiquetas y oversharing) | El índice hereda los problemas de permisos del origen |

## Para repasar

1. ¿Cuál es el primer entregable de cualquier proyecto de seguridad de IA y por qué?
2. Un cliente con agentes de Copilot Studio creados en 2025 quiere aplicarles Conditional Access para agentes. ¿Qué le explicas y qué plan propones?
3. Escribe dos criterios de aceptación medibles para un proyecto de RAG.
4. ¿Por qué un proyecto de shadow AI que solo bloquea apps suele fracasar?
5. ¿Qué tiene que poder hacer el SOC en un simulacro para dar por cerrado un proyecto de detección de IA?
