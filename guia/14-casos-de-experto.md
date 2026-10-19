# Casos de experto

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Cinco casos que mezclan identidad, datos, plataforma, detección, licencias y regulación, como en la vida real. Responde por escrito antes de leer la respuesta modelo; una buena respuesta tuya puede ser distinta si contiene las ideas en negrita. Las empresas son ficticias.

## Caso 1. Un banco, Copilot y un agente de recursos humanos

**Contexto.** Un banco regional en Chile con 4.000 usuarios tiene Microsoft 365 E5 y 1.000 licencias de Copilot desde marzo de 2026. Las áreas crearon 60 agentes de Copilot Studio desde 2025. Un analista de riesgos le preguntó a un agente de recursos humanos “qué bonos se pagaron este año” y obtuvo los bonos de la gerencia.

**Preguntas.** ¿Qué falló? ¿Qué haces en las primeras 48 horas? ¿Qué plan de 90 días propones y qué licencia falta?

**Respuesta modelo.**

- **Qué falló:** el agente usa como conocimiento un sitio de SharePoint con **permisos demasiado amplios** y está compartido con toda la organización. Copilot y el agente respetaron los permisos; los permisos estaban mal. Además, al haber sido creado antes del 18 de marzo de 2026, el agente **no tiene identidad de Agent ID**, y sin **Agent 365** nadie ve su riesgo ni su comportamiento en Defender.
- **48 horas:** restringir la compartición del agente o despublicarlo; aplicar **RCD** al sitio de recursos humanos mientras se corrigen permisos; revisar en la auditoría de Purview (`CopilotInteraction`) quién consultó esos datos; conservar la evidencia; evaluar con legal y el DPO las obligaciones de notificación.
- **90 días:** evaluación de oversharing de DSPM y SharePoint Advanced Management; limpieza de permisos; etiqueta por defecto en las bibliotecas de recursos humanos y **DLP de Copilot** que la excluya; recrear con Agent ID los agentes que tocan datos sensibles; Insider Risk con Risky Agents; política de retención propia para Copilot.
- **Licencia que falta:** **Agent 365** para quienes crean o patrocinan agentes (el banco tiene E5, así que puede comprarlo), o E7. Sin ella no hay detección de amenazas ni DLP para agentes.

## Caso 2. Una fintech, un agente en Foundry y reembolsos por MCP

**Contexto.** Una fintech construyó un agente que atiende clientes y puede iniciar reembolsos llamando a un servidor MCP conectado al sistema central. El agente corre en Container Apps, llama a Azure OpenAI con una clave de API, y el servidor MCP usa una cuenta de servicio con permisos de administrador.

**Preguntas.** ¿Cuáles son los cinco riesgos principales? ¿Cómo es la arquitectura objetivo? ¿Qué criterios exiges antes de producción?

**Respuesta modelo.**

- **Riesgos:** inyección de instrucciones en los mensajes de clientes que dispara reembolsos (**OWASP LLM01, ASI01**); **agencia excesiva** y mal uso de herramientas (LLM06, ASI02); privilegios de administrador en el MCP (ASI03); **clave de API** que cualquiera puede reutilizar; y conversaciones de un cliente visibles para otro, porque Foundry no autoriza por usuario.
- **Arquitectura:** Agent ID para el agente, sin claves; gateway de IA con API Management delante del modelo y `user_security_context` en cada llamada; **gateway MCP** con lista de herramientas permitidas; la herramienta de reembolso con **límites de monto y aprobación humana** por encima de un umbral; una cuenta de servicio con permisos solo de reembolso; validación de la propiedad de la conversación en la app; guardrails con Prompt Shields; Agent 365 para la protección del agente publicado y las reglas MCP del paquete de Sentinel. Si los clientes inician sesión con Entra External ID, el agente puede actuar en su nombre; si no, la app debe limitar cada operación al cliente autenticado.
- **Criterios de aceptación:** ninguna clave en uso; una inyección de prueba no logra disparar un reembolso; los reembolsos sobre el umbral piden aprobación; un cliente no ve conversaciones de otro; la alerta de jailbreak identifica al cliente; red teaming documentado.

## Caso 3. Un retailer con shadow AI y solo E3

**Contexto.** Un retailer con 8.000 usuarios y Microsoft 365 E3 no tiene presupuesto para E5 este año. Los logs del firewall muestran 40 apps de IA en uso, y los desarrolladores pegan código en ChatGPT de consumo.

**Preguntas.** ¿Qué puedes hacer solo con E3? ¿Qué comprarías primero y para quién? ¿Cómo mides el éxito?

**Respuesta modelo.**

- **Con E3:** ofrecer **Copilot Chat** como alternativa aprobada para trabajo con datos de la empresa; publicar una política de uso aceptable; bloquear los dominios de IA no aprobados con indicadores de Defender for Endpoint (con revisión manual, sin el catálogo de MDA); auditoría activa. No alcanza para ver el contenido: la DLP de equipo y de Edge requiere E5.
- **Primera compra:** priorizar por riesgo. Defender Suite (MDA y MDE P2) da el descubrimiento y el bloqueo por catálogo; Purview Suite (12 USD sobre E3) da la DLP de equipo y navegador. Para el código pegado en ChatGPT, lo urgente es **Purview para los desarrolladores**, con la condición de licenciar a cada usuario que se beneficia de la protección y limitar las políticas a esos usuarios.
- **Métricas:** apps de IA sin decisión (hacia cero), uso de la alternativa aprobada (en aumento), eventos de DLP en el grupo de desarrolladores (primero suben al medir, después bajan) y bloqueos repetidos por usuario (regla AI-015).

## Caso 4. Un repositorio con instrucciones ocultas

**Contexto.** Cinco desarrolladores clonaron un fork interno de un repositorio público. Su README tiene instrucciones ocultas para que el agente lea `~/.aws/credentials` y lo envíe a un webhook. Esta mañana se disparó la regla AI-012: inyección de prompts en tres equipos en la misma hora. La protección en tiempo de ejecución estaba en Audit.

**Preguntas.** ¿Qué haces en la primera hora? ¿Cómo sabes si algo salió? ¿Qué cambias para que no vuelva a pasar?

**Respuesta modelo.**

- **Primera hora:** como estaba en **Audit, asume que la acción se ejecutó**. Rota las credenciales de AWS y los tokens de los cinco desarrolladores; bloquea el dominio del webhook con un indicador; aísla los equipos si hay señales de salida; identifica quién más clonó el repositorio y retira el fork.
- **Qué salió:** `DeviceNetworkEvents` hacia el dominio del webhook desde los procesos del agente o de sus MCP; las evidencias de las alertas; y los logs de uso de las claves en AWS (CloudTrail) para ver si alguien las usó desde fuera.
- **Para que no vuelva:** protección en tiempo de ejecución en **Block**; sin auto-aprobación en equipos con acceso a la nube; credenciales de corta vida con SSO en lugar de archivos en el disco; revisión de contenido de repositorios externos antes de forkearlos; la regla AI-014 para servidores MCP nuevos; y un simulacro con este escenario.

## Caso 5. Una multinacional, la UE y Latinoamérica

**Contexto.** Un holding con filiales en España, México y Colombia. Recursos humanos en España usa IA para preseleccionar currículums. El directorio pide un solo marco para todas las filiales.

**Preguntas.** ¿Qué obligaciones aplican y desde cuándo? ¿Qué sistema de gestión propones? ¿Qué herramientas de Microsoft ayudan a reunir evidencia?

**Respuesta modelo.**

- **Obligaciones:** la preselección de currículums es **alto riesgo del Anexo III (empleo)**, con obligaciones desde el **2 de diciembre de 2027** tras el Digital Omnibus. La transparencia del artículo 50 aplica desde agosto de 2026 a los chatbots, y la alfabetización del artículo 4 desde febrero de 2025. En México y Colombia rigen sus leyes de datos personales (pestaña Residencia y LatAm).
- **Sistema de gestión:** **ISO/IEC 42001** como paraguas certificable para todas las filiales, con NIST AI RMF como lenguaje de riesgos. Aclara que ISO/IEC 42001 no da presunción de conformidad con el AI Act.
- **Evidencia con Microsoft:** plantillas de Compliance Manager (EU AI Act, ISO/IEC 42001, NIST AI RMF); auditoría y DSPM de Purview; evaluaciones de Foundry para sesgo y calidad; cumplimiento normativo de Defender for Cloud. La iniciativa de Azure Policy del EU AI Act tiene solo seis políticas técnicas: el grueso de la evidencia es de proceso.
