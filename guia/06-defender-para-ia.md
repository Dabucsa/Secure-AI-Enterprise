# Defender para IA a fondo

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Ningún producto de Defender ve toda la IA de una empresa. Cada uno mira desde un lugar distinto: **Defender for Endpoint** (MDE) mira el equipo; **Defender for Cloud Apps** (MDA), las aplicaciones SaaS y las apps OAuth; **Defender for Cloud**, tus recursos de IA en la nube; y **Defender con Agent 365**, el comportamiento de los agentes gestionados. Ser experto es saber qué señal tiene cada uno, qué no ve y con qué se completa.

Tres ideas ordenan esta pestaña:

1. **Descubrir no es bloquear.** El inventario de agentes locales de MDE te dice quién usa Claude Code o Cursor y con qué servidores MCP, pero no impide que se ejecuten. Bloquear se hace con otras piezas: network protection, la protección en tiempo de ejecución o App Control.
2. **El contenido del prompt casi nunca lo ve Defender.** MDE ve procesos y conexiones cifradas, no lo que alguien escribe en un chat web. El contenido lo inspeccionan Purview (DLP de endpoint y del navegador, seguridad de datos en la red) y Global Secure Access. Las excepciones son las que analizan el prompt en el propio servicio o agente: Defender for AI Services en Azure OpenAI, la protección en tiempo de ejecución de MDE y las trazas de Agent 365.
3. **La seguridad de agentes cambió de licencia el 1 de julio de 2026.** El descubrimiento, la postura y la detección de amenazas de los agentes de Copilot Studio y Foundry ahora requieren **Microsoft Agent 365** (o Microsoft 365 E7). Muchos clientes con E5 todavía creen que MDA los cubre.

Estado a la fecha del encabezado: casi todo lo relacionado con agentes está en **preview**. Antes de comprometer una función con un cliente, revisa el estado en la página de Learn citada.

## 1. El mapa: qué protege cada Defender

| Producto | Qué protege de la IA | Señal principal | Estado | Licencia |
| --- | --- | --- | --- | --- |
| Defender for Endpoint | Equipos donde se usa IA y agentes locales (CLI, IDE, apps de escritorio) | Procesos, archivos y conexiones; inventario de agentes locales y sus MCP; inspección inline en agentes soportados | Descubrimiento y protección de agentes en **preview** | MDE Plan 2 |
| Defender for Cloud Apps | Apps SaaS de IA y apps OAuth conectadas a Microsoft 365 | Tráfico (por MDE o logs de red), catálogo de riesgo, sesiones | Categoría de IA generativa **GA** desde noviembre de 2023 | MDA o Microsoft 365 E5 |
| Defender for Cloud: Defender for AI Services | Modelos de Azure OpenAI y Azure AI Model Inference | Prompts y respuestas analizados en el servicio con Prompt Shields e inteligencia de amenazas | **GA** desde mayo de 2025 | Plan de Defender for Cloud, se cobra por tokens |
| Defender for Cloud: AI-SPM | Postura de los recursos de IA en Azure, AWS y Google Cloud | Configuración, inventario de componentes (AI BOM) y rutas de ataque | **GA** desde noviembre de 2024 | Defender CSPM |
| Defender XDR con Agent 365 (Security for AI) | Agentes de Copilot Studio, Foundry, Agent Builder, del Agent 365 SDK y locales | Trazas de observabilidad, inventario, riesgo, bloqueo en tiempo de ejecución | Herramientas de Agent 365 **GA**; Copilot Studio y Foundry en **preview** | Agent 365 o Microsoft 365 E7 |
| Defender for Office 365 Plan 2 | Correos que intentan inyectar instrucciones a un asistente de IA | Contenido del correo entrante | La página no indica preview | MDO Plan 2 |
| Security Dashboard for AI | Vista conjunta de la postura de IA de Defender, Entra y Purview | Inventario de agentes, modelos, servidores MCP y apps de IA | **GA** desde febrero de 2026 | Sin licencia adicional |

Una aclaración para clientes: Security Copilot está incluido en Microsoft 365 E5 desde noviembre de 2025, pero no hay un agente de Security Copilot dedicado a proteger la IA. La protección de la IA vive en los productos de esta tabla.

## 2. Defender for Endpoint: shadow AI y agentes en el equipo

El equipo del usuario es donde hoy aparece el riesgo más nuevo: agentes de programación que ejecutan comandos, leen archivos y se conectan a servidores MCP con las credenciales del desarrollador. MDE tiene tres piezas para eso.

### Descubrimiento de agentes locales (preview)

Desde junio de 2026, MDE descubre los agentes de IA que se ejecutan en equipos Windows y macOS incorporados, y los servidores MCP que tienen configurados ([Microsoft Learn, 7 oct 2026](https://learn.microsoft.com/en-us/defender-endpoint/local-agent-discovery-overview)).

- **Qué cubre:** agentes de línea de comandos, apps de escritorio, IDE agénticos, extensiones de VS Code y agentes tipo “Claw”. La matriz de soporte lista 60 agentes en Windows, 51 en macOS y 3 en WSL, entre ellos Claude Code, Codex CLI, Gemini CLI, GitHub Copilot CLI, Cursor, Windsurf, Ollama, LM Studio y OpenClaw ([matriz de soporte](https://learn.microsoft.com/en-us/defender-endpoint/ai-agent-support-matrix)).
- **Cómo descubre:** observando actividad del agente. No es un inventario de software: un agente instalado que nunca se usó no aparece. Para lo instalado sigue estando el inventario de software de Defender Vulnerability Management.
- **Qué muestra:** proveedor, modelo, proceso que lo aloja, si ese proceso es de confianza, si el agente **auto-aprueba** sus acciones, la cuenta y el equipo, y los MCP locales (con el comando que los inicia) y remotos. Cada entrada es la combinación usuario + equipo + tipo de agente.
- **Dónde:** portal de Defender, Assets > AI agents > Local agents, y la tabla `AgentsInfo` de Advanced Hunting con `Platform == "LocalAgents"`.
- **Requisitos:** nube comercial, MDE Plan 2 y Microsoft Defender Antivirus en modo activo con protección en tiempo real. No hay que desplegar nada más ([requisitos y licencias](https://learn.microsoft.com/en-us/defender-endpoint/discover-local-ai-agents)).
- **Licencia por capas:** con MDE P2 tienes inventario y hunting. El nivel de riesgo, los indicadores y las recomendaciones requieren Microsoft 365 E7, o Agent 365 más MDE P2.

Lo que más importa del inventario son dos columnas: **auto-aprobación** y **MCP locales**. Un agente que actúa sin pedir confirmación, con un servidor MCP que tiene acceso a producción, es el caso de la pestaña MCP a fondo hecho realidad en el equipo de un desarrollador.

### Protección en tiempo de ejecución de agentes locales (preview, solo Windows)

Aquí sí hay inspección de contenido. MDE revisa el prompt del usuario, cada llamada a herramienta y cada respuesta de herramienta buscando inyección de instrucciones, y puede bloquear ([Microsoft Learn, 8 oct 2026](https://learn.microsoft.com/en-us/defender-endpoint/ai-agent-runtime-protection-overview)). Tiene dos métodos:

| Método | Cómo funciona | Agentes cubiertos | Límite |
| --- | --- | --- | --- |
| Inspección nativa | Usa los hooks oficiales del agente | Claude Code, Claude Desktop en modo Code, GitHub Copilot CLI y app, extensiones de Claude Code y GitHub Copilot para VS Code; la página de introducción menciona también Codex CLI | Sin hooks del proveedor no hay protección |
| Inspección de red | Revisa el tráfico del agente hacia servicios de inferencia conocidos | OpenClaw, Ollama Desktop, ChatGPT Classic y Desktop | No funciona con certificate pinning ni HTTP/3 |

```powershell
# Empieza en Audit, revisa una o dos semanas y luego pasa a Block
Set-MpPreference -AiAgentProtection Audit
# La inspección de red no está en el perfil de Intune: se despliega con un script
Set-MpPreference -AiAgentNetworkInspection Audit
Get-MpPreference | Select-Object AiAgent*
```

- **Despliegue:** Intune > Endpoint security > Antivirus > perfil “Microsoft Defender AI agent runtime protection”, o el mismo perfil en el portal de Defender. La configuración queda protegida por tamper protection ([configuración](https://learn.microsoft.com/en-us/defender-endpoint/configure-ai-agent-runtime-protection)).
- **Alerta:** “Suspicious AI prompt injection”, informativa en Audit y de severidad baja a crítica en Block, con el agente afectado y el árbol de procesos.
- **Licencia:** MDE P2, Microsoft 365 E5, Agent 365 o E7. Requiere la versión de firmas 1.451.224.0 o superior.
- **Para verificar en el tenant:** las páginas de configuración de septiembre de 2026 todavía piden el canal Beta, pero las novedades de julio dicen que ya no hace falta para la inspección nativa. Hay una [página de demostración](https://learn.microsoft.com/en-us/defender-endpoint/defender-endpoint-demonstration-ai-agent-runtime-protection) con un prompt de prueba inofensivo.

### Bloquear apps de IA no autorizadas: MDA más network protection

El bloqueo de shadow AI web se arma entre dos productos ([Microsoft Learn, 3 jul 2026](https://learn.microsoft.com/en-us/defender-cloud-apps/mde-govern)):

1. MDE envía a MDA el tráfico de red de cada equipo, sin proxies. Los datos aparecen en el descubrimiento en hasta 2 horas.
2. En MDA marcas la app como **Unsanctioned** (bloquear) o **Monitored** (avisar y dejar continuar).
3. MDA convierte los dominios de la app en indicadores de URL de MDE, y network protection los bloquea en el equipo. El bloqueo puede tardar **hasta 3 horas** en llegar.

Requisitos: MDA más MDE (o Microsoft 365 E5), network protection en modo **block**, “Custom network indicators” activado y “Enforce app access” en MDA. Los perfiles con alcance permiten bloquear solo para ciertos grupos de equipos.

Los límites que un experto debe conocer ([network protection](https://learn.microsoft.com/en-us/defender-endpoint/network-protection)):

- Network protection lee el nombre del sitio en el saludo TLS; no descifra. **No funciona con QUIC ni con Encrypted Client Hello**: desactívalos en Chrome y Firefox o bloquea UDP 443.
- En Windows, Edge no pasa por network protection sino por SmartScreen.
- `DeviceNetworkEvents` puede mostrar `ConnectionSuccess` aunque el sitio se haya bloqueado, porque el bloqueo ocurre después del saludo TCP. Busca los bloqueos en `DeviceEvents`.
- El tenant admite 15.000 indicadores como máximo.
- Si el proveedor usa dominios que no están en el catálogo, el bloqueo puede ser inconsistente entre la web, la app de escritorio y el móvil.

### Lo que MDE no tiene para la IA

- **No hay categoría de IA en web content filtering.** El control por categoría está en el catálogo de MDA y en Global Secure Access.
- **No hay reglas de reducción de superficie de ataque específicas de IA.** Las genéricas siguen ayudando contra agentes que ejecutan código: bloquear ejecutables que no cumplen criterios de prevalencia o confianza, scripts ofuscados, y creación de procesos desde PsExec y WMI.
- **No hay un botón para bloquear un agente local desde el inventario.** Para impedir que se ejecute un agente no aprobado usa App Control for Business o indicadores de archivo o certificado. Es una recomendación propia: Microsoft no lo documenta como función de IA.
- La recomendación de Secure Score “AI-Readiness” (GA en septiembre de 2026) endurece el equipo frente a ataques acelerados con IA (TPM, VBS, HVCI, LAPS, Secure Boot). No controla el uso de IA.

## 3. Defender for Cloud Apps: apps de IA, apps OAuth y sesiones

MDA responde la primera pregunta de cualquier proyecto: **qué IA usa la gente hoy**. También gobierna las apps de IA que piden permisos sobre Microsoft 365.

**El catálogo.** La categoría **Generative AI** existe desde noviembre de 2023; después se sumaron **AI – MCP Server** y **AI – Model Provider**. El catálogo completo tiene más de 31.000 apps evaluadas con más de 90 factores de riesgo ([Microsoft Learn, 3 jul 2026](https://learn.microsoft.com/en-us/defender-cloud-apps/risk-score)). Los factores siguen siendo los generales (seguridad, cumplimiento, legales); no encontré factores documentados específicos de LLM. Para IA agrega tú las preguntas que el catálogo no hace: si entrena con tus datos, cuánto retiene los prompts, dónde los procesa y si ofrece una edición empresarial con SSO.

**Cómo trabajarlo** (guía oficial [Manage generative AI apps](https://learn.microsoft.com/en-us/microsoft-365/copilot/manage-generative-ai-apps), 8 abr 2026):

1. Conecta las fuentes de descubrimiento: la integración con MDE (la más simple), logs de firewall o proxy, o Global Secure Access, que usa el mismo catálogo para su descubrimiento de shadow AI.
2. Crea una política de descubrimiento con “Category equals Generative AI” para alertar o etiquetar apps nuevas.
3. Decide por app: **Sanctioned** (la empresarial aprobada), **Monitored** (aviso con posibilidad de continuar) o **Unsanctioned** (bloqueo vía MDE).
4. Revisa cada semana el insight **“Untagged GenAI apps”** del inventario de aplicaciones para que nada quede sin decisión ([inventario](https://learn.microsoft.com/en-us/defender-cloud-apps/applications-inventory)).

**Apps OAuth y app governance.** Cuando un usuario conecta un asistente de IA a su correo o a SharePoint, aparece una app OAuth con permisos de Graph. App governance (incluido con MDA) lista esas apps, marca las sobreprivilegiadas o de editor no verificado y tiene un insight **“Used by AI Agents”** para las apps que usan plataformas de agentes en Microsoft 365. Es el control para el “ChatGPT conectado a mi OneDrive”.

**Controles de sesión.** Con Conditional Access App Control puedes impedir subir archivos o copiar texto en una app de IA, o aplicar la protección dentro de Edge for Business. Requiere MDA y Entra ID P1, y **solo funciona con apps donde el usuario inicia sesión con su identidad corporativa**, como ChatGPT Enterprise o Claude Enterprise federados con Entra ([políticas de sesión](https://learn.microsoft.com/en-us/defender-cloud-apps/session-policy-aad)). Contra una cuenta personal en una app de consumo no sirve: ahí bloqueas o proteges el contenido con Purview en el navegador.

**Dos fechas para planificar:**

- **1 de julio de 2026:** el descubrimiento, la postura, la detección y la protección en tiempo real de los agentes de Copilot Studio pasaron a requerir Agent 365, y las alertas antiguas de MDA para Copilot Studio se retiraron ([transición](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/transition-agent-security-to-agent-365)). La misma página dice que la protección en tiempo real de Copilot Studio a través de MDA “sigue sin cambios” para quienes ya la usan; confirma el alcance con Microsoft antes de cotizar.
- **6 de enero de 2027:** se retiran las file policies de MDA y su función pasa a Purview DLP.

La actividad de Microsoft 365 Copilot llega a `CloudAppEvents` desde marzo de 2024 a través del conector de Microsoft 365 de MDA.

## 4. Defender for Cloud: amenazas contra tus modelos y postura de IA

### Defender for AI Services (GA)

Analiza en el servicio cada prompt y respuesta de tus despliegues de **Azure OpenAI** y **Azure AI Model Inference**, con Prompt Shields e inteligencia de amenazas de Microsoft, y envía las alertas a Defender XDR ([Microsoft Learn, 19 may 2026](https://learn.microsoft.com/en-us/azure/defender-for-cloud/ai-threat-protection)).

Alertas que conviene conocer ([lista completa](https://learn.microsoft.com/en-us/azure/defender-for-cloud/alerts-ai-workloads)): jailbreak bloqueado o detectado por Prompt Shields, ASCII smuggling, intento de robo de credenciales, URL de phishing compartida en una app de IA, **wallet attack** (volumen anómalo para agotar tu cuota), invocación anómala de herramientas, acceso desde Tor o IP sospechosa y, en preview, intento de reconocimiento del LLM.

**El detalle que separa a un experto:** sin contexto de usuario, la alerta dice “jailbreak en tu recurso” pero no quién lo intentó, porque la app llama al modelo con su propia identidad. La app debe enviar el contexto del usuario final en cada llamada ([contexto de usuario](https://learn.microsoft.com/en-us/azure/defender-for-cloud/gain-end-user-context-ai)):

```python
# Con el SDK de openai 1.61.1 o superior; todos los campos son opcionales
respuesta = cliente.chat.completions.create(
    model="gpt-4.1-mini",
    messages=mensajes,
    extra_body={"user_security_context": {
        "application_name": "portal-clientes",
        "end_user_id": usuario_oid,        # object ID de Entra, nunca el correo
        "end_user_tenant_id": tenant_id,
        "source_ip": ip_del_usuario,
    }},
)
```

Los nombres de campo son los del ejemplo oficial de Microsoft ([sample-app-aoai-chatGPT](https://github.com/microsoft/sample-app-aoai-chatGPT/blob/main/backend/security/ms_defender_utils.py)). Un error de escritura no rompe la llamada, así que valida en una alerta de prueba que el usuario aparece. No funciona con la API de Azure AI Model Inference.

**Límites:** solo texto (no imagen ni audio), solo Azure (no protege en tiempo de ejecución Bedrock ni Vertex) y sin nubes soberanas. La **evidencia del prompt** guarda solo fragmentos sospechosos, con datos sensibles redactados, y se puede desactivar. La prueba gratuita dura 30 días con un tope de 75.000 millones de tokens. La detección de amenazas para agentes de Foundry estuvo en este plan desde febrero de 2026 y pasó a Agent 365 el 1 de julio.

El plan tiene un componente opcional, **Data security for AI interactions**, que envía prompts y respuestas a Purview para DLP, Insider Risk, Communication Compliance y eDiscovery. Se paga aparte en Purview, no incluye agentes de Foundry y solo aplica políticas cuando la llamada lleva contexto de usuario ([activación](https://learn.microsoft.com/en-us/azure/defender-for-cloud/ai-onboarding)).

### AI-SPM en Defender CSPM (GA)

Es la postura, no la detección. Descubre el inventario de componentes de IA (AI BOM) desde el código hasta la nube, recomienda configuraciones, encuentra endpoints de IA expuestos a Internet y dibuja **rutas de ataque** hacia tus modelos y datos de grounding ([Microsoft Learn, 18 may 2026](https://learn.microsoft.com/en-us/azure/defender-for-cloud/ai-security-posture)). Cubre Azure OpenAI, Foundry, Azure Machine Learning, Amazon Bedrock y Google Vertex AI; la matriz multinube de septiembre de 2026 marca Google Cloud como no soportado, así que confirma ese caso.

Recomendaciones de 2026 que vale la pena conocer por su nombre ([referencia](https://learn.microsoft.com/en-us/azure/defender-for-cloud/recommendations-reference-ai)): un agente de Foundry con riesgo de inyección indirecta debe exigir aprobación humana para acciones de herramientas MCP; las herramientas MCP de un agente deben tener lista de herramientas permitidas; los guardrails deben incluir control de jailbreak; Bedrock debe tener activado el registro de invocaciones. Desde julio de 2026 el inventario y la postura de los **agentes** de Foundry y de terceros pasaron a Agent 365; Defender CSPM sigue viendo las cuentas y proyectos de Foundry.

**AI model security (preview, marzo de 2026)** escanea modelos en registros y workspaces de Azure Machine Learning en busca de malware, operadores inseguros y secretos: pickle, ONNX, safetensors, GGUF y más, hasta 10 GB por archivo, cada semana, y también desde la CLI en tu pipeline ([Microsoft Learn](https://learn.microsoft.com/en-us/azure/defender-for-cloud/ai-model-security)).

## 5. Agentes en tiempo de ejecución: Defender con Agent 365

Con licencia de Agent 365, Defender protege los agentes gestionados usando la **observabilidad**: las trazas que emiten Copilot Studio, Foundry, Agent Builder y los agentes integrados con el Agent 365 SDK ([Microsoft Learn, 7 ago 2026](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/defender-security-for-ai)). Agent 365 es un complemento de E5, A5 o Business Premium (15 USD por usuario al mes) y está incluido en Microsoft 365 E7 (99 USD); ambos son GA desde el 1 de mayo de 2026.

| Capacidad | Qué hace | Estado |
| --- | --- | --- |
| Inventario | Assets > AI agents > Agents: Copilot Studio, Foundry, Microsoft 365, plataformas no Microsoft del registro de agentes y agentes locales, con herramientas, MCP e identidades | Disponible con Agent 365 |
| Riesgo de postura | Niveles de riesgo con indicadores como instrucciones débiles, exposición a inyección indirecta, acceso privilegiado a sistemas de negocio, amenaza activa; para locales, usuario o equipo crítico | Preview ([riesgo](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-risk-assessment)) |
| Detección de amenazas | Jailbreak, inyección indirecta (XPIA), propagación de contenido malicioso, fuga de secretos, técnicas de evasión, reconocimiento del LLM y acceso sospechoso, correlacionados en incidentes | Preview ([detección](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-detection-protection)) |
| Protección en tiempo real | Revisa la petición a la herramienta y puede bloquearla: contenido malicioso, exfiltración de secretos, evasión y dominios de correo inseguros | **GA** para herramientas de Agent 365 (Work IQ MCP y MCP del cliente); preview en Copilot Studio y Foundry ([protección](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-real-time-protection)) |

Cómo funcionan las reglas: la regla “Default” audita todo; las reglas personalizadas bloquean y se acotan a agentes. **Las exclusiones solo existen para agentes con Entra Agent ID**, otra razón para dar identidad propia a cada agente (pestaña Agentes con Entra). Desde julio de 2026 las auditorías y los bloqueos se registran como *behaviors* en `BehaviorInfo`, no como alertas.

Requisitos de activación: Settings > Security for AI, el conector de Microsoft 365, rol de Security Administrator y, para Copilot Studio, el administrador de Power Platform. En Foundry solo se protegen **agentes publicados**, no los del playground. Las trazas se guardan 30 días y el inventario 180, en la UE o en EE. UU. según el tenant ([privacidad](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/privacy-defender-agent-365)).

**Lección del 1 de julio de 2026:** las reglas de bloqueo antiguas dejaron de bloquear y hubo que redefinirlas en Policies & rules. Después de cada transición de producto, prueba que tus bloqueos siguen bloqueando.

**Correo dirigido a asistentes.** Defender for Office 365 Plan 2 detecta correos entrantes con inyección de instrucciones (exfiltrar por URL, revelar el system prompt, descubrir herramientas) y los marca como phishing de alta confianza con la tecnología “Prompt injection protection”, sin configuración adicional ([Microsoft Learn, 2 sep 2026](https://learn.microsoft.com/en-us/defender-office-365/step-by-step-guides/prompt-injection-protection-defender-for-office-365)). Es la defensa en origen del caso EchoLeak del capítulo de amenazas.

## 6. Hunting con KQL: shadow AI, agentes y MCP

Estas consultas corren en Advanced Hunting de Defender XDR (y en Sentinel si llevas esas tablas con el conector de Defender XDR). Las validé con el servicio de lenguaje de Kusto contra los esquemas documentados en Learn; **no se ejecutaron contra un tenant real**, así que pruébalas primero. Advanced hunting también trae consultas listas en Queries > AI Agents.

**Inventario de agentes locales por proveedor y proceso.** `AgentsInfo` guarda un registro por cada cambio del perfil, por eso se queda con el último de cada agente:

```kusto
AgentsInfo
| where Platform == "LocalAgents"
| summarize arg_max(Timestamp, Name, Version, LifecycleStatus, RawAgentInfo) by AgentId
| where LifecycleStatus !in~ ("Deleted", "Uninstalled")
| extend Meta = RawAgentInfo.localAgentMetadata
| summarize Perfiles = count(), Equipos = dcount(tostring(Meta.deviceName)), Versiones = make_set(Version, 20)
    by Agente = Name, Proveedor = tostring(Meta.vendor), Proceso = tostring(Meta.relatedProcess)
| sort by Equipos desc
```

**Agentes que actúan sin pedir permiso o desde un proceso no confiable.** Ojo: `autoApprove` y `trustedProcess` vienen como texto, no como booleano:

```kusto
AgentsInfo
| where Platform == "LocalAgents"
| summarize arg_max(Timestamp, Name, Version, LifecycleStatus, RawAgentInfo) by AgentId
| where LifecycleStatus !in~ ("Deleted", "Uninstalled")
| extend Meta = RawAgentInfo.localAgentMetadata
| where tostring(Meta.autoApprove) == "true" or tostring(Meta.trustedProcess) == "false"
| project Agente = Name, Version, Equipo = tostring(Meta.deviceName), Cuenta = tostring(Meta.accountName),
          AutoAprueba = tostring(Meta.autoApprove), ProcesoConfiable = tostring(Meta.trustedProcess), McpLocales = Meta.localMcps
```

**Agentes en equipos críticos**, con el grafo de exposición (criticidad 0 es la más alta):

```kusto
let AgentesLocales = ExposureGraphNodes
    | where NodeLabel == "ai-agent"
    | where tostring(NodeProperties.rawData.aiAgentMetadata.platform) == "LocalAgents"
    | project AgenteNodo = NodeId, Agente = NodeName;
let Criticidad = ExposureGraphNodes
    | extend Nivel = toint(NodeProperties.rawData.criticalityLevel.criticalityLevel)
    | where isnotnull(Nivel)
    | project EquipoNodo = NodeId, Nivel;
ExposureGraphEdges
| where EdgeLabel == "runs on"
| join kind=inner AgentesLocales on $left.SourceNodeId == $right.AgenteNodo
| join kind=inner Criticidad on $left.TargetNodeId == $right.EquipoNodo
| where Nivel <= 1
| project Agente, Equipo = TargetNodeName, Nivel
| sort by Nivel asc
```

**Servidores MCP iniciados en equipos**, incluidos agentes que el descubrimiento todavía no soporta. Es un patrón propio, no documentado por Microsoft; ajusta la lista a lo que veas:

```kusto
DeviceProcessEvents
| where Timestamp > ago(7d)
| where ProcessCommandLine has_any ("@modelcontextprotocol/", "mcp-server", "mcp_server", "fastmcp")
| summarize Equipos = dcount(DeviceName), Cuentas = make_set(AccountName, 20), Ejemplo = take_any(ProcessCommandLine), Primera = min(Timestamp)
    by Padre = InitiatingProcessFileName, Proceso = FileName
| sort by Equipos desc
```

**Programas que llaman APIs de LLM fuera del navegador** (scripts, herramientas propias, agentes sin soporte). También es un patrón propio:

```kusto
let ApisLlm = dynamic(["api.openai.com", "api.anthropic.com", "generativelanguage.googleapis.com", "api.mistral.ai", "api.deepseek.com", "openrouter.ai", "api.groq.com"]);
let Navegadores = dynamic(["msedge.exe", "chrome.exe", "firefox.exe", "brave.exe", "safari"]);
DeviceNetworkEvents
| where Timestamp > ago(7d)
| where RemoteUrl has_any (ApisLlm)
| where InitiatingProcessFileName !in~ (Navegadores)
| summarize Conexiones = count(), Equipos = dcount(DeviceName), Destinos = make_set(RemoteUrl, 10)
    by InitiatingProcessFileName, InitiatingProcessFolderPath
| sort by Equipos desc
```

**Bloqueos efectivos de apps no autorizadas.** Mira `DeviceEvents`, no `DeviceNetworkEvents`:

```kusto
DeviceEvents
| where Timestamp > ago(7d)
| where ActionType in ("ExploitGuardNetworkProtectionBlocked", "SmartScreenUrlWarning")
| summarize Bloqueos = count(), Equipos = dcount(DeviceName), Cuentas = dcount(InitiatingProcessAccountName)
    by RemoteUrl, ActionType
| sort by Bloqueos desc
```

**Alertas de la protección en tiempo de ejecución de MDE**, por día, con equipos y usuarios:

```kusto
AlertInfo
| where Timestamp > ago(30d)
| where Title has "Suspicious AI prompt injection"
| join kind=inner (AlertEvidence | where EntityType in ("Machine", "User") | project AlertId, DeviceName, AccountUpn) on AlertId
| summarize Alertas = dcount(AlertId), Severidades = make_set(Severity),
            Equipos = make_set_if(DeviceName, isnotempty(DeviceName), 50), Usuarios = make_set_if(AccountUpn, isnotempty(AccountUpn), 50)
    by Dia = bin(Timestamp, 1d)
```

**Agentes en la nube publicados, con MCP y sin Entra Agent ID**: sin identidad propia no puedes excluirlos de reglas, aplicarles Conditional Access ni saber quién responde por ellos:

```kusto
AgentsInfo
| where Platform != "LocalAgents"
| summarize arg_max(Timestamp, *) by AgentId
| where LifecycleStatus == "Active" and PublishedStatus == "Published"
| where isnotempty(McpServers) and isempty(EntraAgentId)
| project AgentName, Platform, Model, Availability, Owners, McpServers
```

Tres advertencias. Primero, el esquema de `AgentsInfo` llama `AgentName` a la columna del nombre, pero la página de agentes locales usa `Name` en sus consultas; prueba cuál responde en tu tenant. Segundo, `AIAgentsInfo` se retiró el 1 de julio de 2026: las consultas guardadas en el portal se migraron solas, pero las que corren por API o en otras herramientas no. Tercero, para explorar los eventos de la protección en tiempo real empieza por `BehaviorInfo | summarize count() by ServiceSource, DetectionSource`, porque los valores exactos todavía no están documentados. El [paquete de detecciones](../ai-detections/README.md) de este repositorio convierte estos patrones en reglas programadas: AI-005 a AI-008 para procesos, red y Copilot; AI-010 y AI-011 sobre AgentsInfo (agentes locales que se aprueban solos y agentes publicados sin Agent ID); AI-012 para inyección de prompts contra agentes en varios equipos a la vez; AI-014 para el primer servidor MCP de un equipo; y AI-015 para intentos repetidos de entrar a apps de IA bloqueadas.

## 7. Hasta dónde se llega

Esta es la tabla que conviene tener en la cabeza en cualquier reunión con un cliente. “Contenido” es lo que la persona o el agente escribió y recibió.

| Producto | Ve | No ve | Cómo cerrar la brecha |
| --- | --- | --- | --- |
| MDE (EDR y network protection) | Proceso, línea de comandos, archivos, conexiones y nombre del sitio | El contenido de lo que viaja cifrado; QUIC y ECH escapan al bloqueo | Purview Endpoint DLP y protección en Edge para el contenido; bloquear QUIC |
| MDE, descubrimiento de agentes | Agente, versión, auto-aprobación, MCP locales y remotos | Conversaciones; agentes nunca usados; Linux nativo; no bloquea | App Control para impedir la ejecución; inventario de software para lo instalado |
| MDE, protección en tiempo de ejecución | Prompt, llamada y respuesta de herramienta en agentes soportados | Agentes sin hooks ni tráfico inspeccionable; macOS | Exigir agentes de la matriz; registrar en tu gateway lo que pase por MCP |
| MDA, descubrimiento y bloqueo | Qué apps de IA se usan, cuánto y quién | El contenido; apps fuera del catálogo | Purview para el contenido; pedir el alta en el catálogo |
| MDA, controles de sesión | Acciones en apps de IA con SSO corporativo | Cuentas personales en apps de consumo | Bloquear la app de consumo y ofrecer la empresarial |
| Defender for AI Services | Prompts y respuestas en Azure OpenAI, en el servicio | Usuario final si la app no envía contexto; Bedrock y Vertex; imágenes y audio | `user_security_context` en la app; controles nativos de AWS y Google más tu gateway |
| AI-SPM | Configuración, inventario y rutas de ataque en tres nubes | Ataques en curso | Defender for AI Services y Agent 365 para la detección |
| Defender con Agent 365 | Trazas de agentes gestionados, riesgo y bloqueo de herramientas | Agentes de frameworks propios sin el SDK; agentes de Foundry no publicados | Instrumentar con el Agent 365 SDK o enviar los logs de tu gateway a Sentinel |
| Defender for Office 365 P2 | Correo entrante con inyección | Documentos compartidos y páginas web con inyección | Prompt Shields y guardrails en el agente; Purview para el contenido compartido |

Las brechas que **ningún** Defender cierra solo son tres, y conviene nombrarlas con el cliente desde el principio:

1. **El contenido de los prompts a IA de consumo.** Se cubre con Purview (DLP de endpoint con la extensión en Chrome, protección en línea de Edge for Business, seguridad de datos en la red con Global Secure Access, GA en septiembre de 2026) o con Generative AI Insights de Global Secure Access, que registra el prompt completo mediante inspección TLS para 11 apps y el tráfico MCP (preview). Se ve en la pestaña Purview para IA.
2. **Los agentes que construyes con frameworks propios.** Si no emiten trazas a Agent 365, la única visibilidad es la que diseñes: identidad de Entra Agent ID, un gateway para modelos y herramientas, y sus logs en Sentinel (tablas `MCPGateway_CL` y `A2AGateway_CL` del paquete de detecciones).
3. **La IA en otras nubes en tiempo de ejecución.** AI-SPM ve la postura de Bedrock y Vertex, pero la detección en tiempo real depende de los controles de cada nube o de que el tráfico pase por tu gateway.

La vista combinada de Entra, Defender, Purview y Agent 365 por tipo de agente, con escenarios de ataque completos, está en la pestaña Visibilidad de agentes.

## 8. Licencias y prerrequisitos

| Capacidad | Licencia | Prerrequisitos clave |
| --- | --- | --- |
| Inventario de agentes locales y tabla `AgentsInfo` | MDE Plan 2 (incluido en E5 y E7) | Antivirus de Defender activo con protección en tiempo real; nube comercial |
| Riesgo, indicadores y recomendaciones de agentes locales | Microsoft 365 E7, o Agent 365 más MDE P2 | Lo anterior |
| Protección en tiempo de ejecución de agentes locales | MDE P2, E5, Agent 365 o E7 | Windows; firmas 1.451.224.0 o superior |
| Catálogo, descubrimiento y app governance | Defender for Cloud Apps o Microsoft 365 E5 | Integración con MDE o logs de red |
| Bloqueo de apps no autorizadas | MDA más MDE, o E5 | Network protection en modo block |
| Controles de sesión | MDA más Entra ID P1 | App federada con Entra o con un IdP integrado |
| Defender for AI Services | Plan de Defender for Cloud, por tokens | Prueba de 30 días; la integración con Purview se paga en Purview |
| AI-SPM | Defender CSPM | Conectores de AWS y Google Cloud para multinube |
| Seguridad de agentes de Copilot Studio y Foundry (inventario, riesgo, detección, bloqueo) | Agent 365 (15 USD por usuario al mes sobre E5, A5 o Business Premium) o Microsoft 365 E7 (99 USD) | Conector de Microsoft 365; prueba de Agent 365 de 25 puestos por 30 días |
| Inyección de prompts por correo | Defender for Office 365 Plan 2 | Ninguno |
| Security Dashboard for AI | Sin licencia adicional | Tener Defender, Entra o Purview |

Los precios son de lista en dólares a mayo de 2026 y cambian por país y acuerdo. Para la conversación comercial, la pregunta que ordena todo es: **¿el cliente tiene E5, y va a construir o usar agentes?** Si la respuesta es sí, Agent 365 o E7 deja de ser opcional para la seguridad de esos agentes.

## 9. Mitos y realidades

| Mito | Realidad |
| --- | --- |
| “Con Defender for Endpoint veo lo que la gente le escribe a ChatGPT.” | No. MDE ve el proceso y el nombre del sitio, no el contenido cifrado. El contenido lo ven Purview y Global Secure Access. |
| “Si el inventario me muestra el agente local, lo puedo bloquear desde ahí.” | El descubrimiento no bloquea. Bloqueas el comportamiento con la protección en tiempo de ejecución o la ejecución con App Control. |
| “Marcar la app como Unsanctioned la bloquea al instante.” | Puede tardar hasta 3 horas, exige network protection en modo block y no cubre QUIC ni Encrypted Client Hello. |
| “Defender for AI Services protege mis modelos en Bedrock y Vertex.” | Solo Azure OpenAI y Azure AI Model Inference. Para Bedrock y Vertex tienes postura con AI-SPM, no detección en tiempo real. |
| “Con E5 tengo cubiertos mis agentes de Copilot Studio y Foundry.” | Desde el 1 de julio de 2026 el descubrimiento, la postura y la detección de esos agentes requieren Agent 365 o E7. |
| “Las políticas de sesión controlan el ChatGPT personal de los empleados.” | Solo controlan apps donde el usuario inicia sesión con la identidad corporativa. La cuenta personal se bloquea o se protege con Purview en el navegador. |
| “La alerta de jailbreak me dice qué usuario fue.” | Solo si la aplicación envía `user_security_context`. Sin eso ves la identidad de la app. |
| “La protección de MDE cubre cualquier agente de IA.” | Solo los de la matriz: seis con hooks y cuatro por inspección de red, y solo en Windows. |
| “La evidencia del prompt guarda toda la conversación.” | Guarda fragmentos sospechosos con los datos sensibles redactados, y se puede desactivar. |
| “Web content filtering tiene una categoría de IA.” | No la tiene. El control por categoría de IA está en el catálogo de MDA y en Global Secure Access. |

## 10. Para repasar

1. Un desarrollador usa Claude Code con auto-aprobación y un servidor MCP local que lee la base de datos de producción. ¿Qué te muestra Defender, con qué licencia, y qué tres acciones tomas?
2. Marcaste una app de IA como Unsanctioned hace una hora y un usuario sigue entrando desde Chrome. Da tres causas posibles.
3. Tu SOC recibe “Jailbreak blocked by Prompt Shields” en Defender for Cloud y no sabe qué usuario fue. ¿Qué cambias y en qué parte de la solución?
4. Un cliente con E5 quiere detección de amenazas para sus agentes de Copilot Studio y Foundry. ¿Qué le falta y qué cambió en julio de 2026?
5. ¿Qué puedes y qué no puedes saber con MDE sobre el uso de un asistente de IA web, y qué productos completan la visibilidad?

Para practicar las consultas de la sección 6 con datos simulados, haz el Lab 22 de la pestaña Laboratorios.

## Fuentes

Páginas de Microsoft Learn consultadas el 18 de octubre de 2026 a través de una copia en Markdown que se actualiza varias veces al día; la fecha entre paréntesis es la de última actualización de cada página.

- [Descubrimiento de agentes locales](https://learn.microsoft.com/en-us/defender-endpoint/local-agent-discovery-overview), [requisitos](https://learn.microsoft.com/en-us/defender-endpoint/discover-local-ai-agents) y [matriz de soporte](https://learn.microsoft.com/en-us/defender-endpoint/ai-agent-support-matrix) (7 oct 2026)
- [Protección en tiempo de ejecución de agentes](https://learn.microsoft.com/en-us/defender-endpoint/ai-agent-runtime-protection-overview) (8 oct 2026) y su [configuración](https://learn.microsoft.com/en-us/defender-endpoint/configure-ai-agent-runtime-protection) (25 sep 2026)
- [Network protection](https://learn.microsoft.com/en-us/defender-endpoint/network-protection) (12 ago 2026) e [indicadores](https://learn.microsoft.com/en-us/defender-endpoint/indicators-overview)
- [Bloqueo de apps con MDE desde MDA](https://learn.microsoft.com/en-us/defender-cloud-apps/mde-govern), [catálogo y riesgo](https://learn.microsoft.com/en-us/defender-cloud-apps/risk-score) e [inventario de aplicaciones](https://learn.microsoft.com/en-us/defender-cloud-apps/applications-inventory) (jul–sep 2026)
- [Gestionar apps de IA generativa](https://learn.microsoft.com/en-us/microsoft-365/copilot/manage-generative-ai-apps) (8 abr 2026)
- [Defender for AI Services](https://learn.microsoft.com/en-us/azure/defender-for-cloud/ai-threat-protection) (19 may 2026), [alertas](https://learn.microsoft.com/en-us/azure/defender-for-cloud/alerts-ai-workloads), [contexto de usuario](https://learn.microsoft.com/en-us/azure/defender-for-cloud/gain-end-user-context-ai) y [AI-SPM](https://learn.microsoft.com/en-us/azure/defender-for-cloud/ai-security-posture)
- [Security for AI en Defender](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/defender-security-for-ai), [detección](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-detection-protection), [protección en tiempo real](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/ai-agent-real-time-protection) y [transición a Agent 365](https://learn.microsoft.com/en-us/defender-xdr/security-for-ai/transition-agent-security-to-agent-365) (jun–ago 2026)
- [Tabla AgentsInfo](https://learn.microsoft.com/en-us/defender-xdr/advanced-hunting-agentsinfo-table) (3 jun 2026)
- [Protección contra inyección en el correo](https://learn.microsoft.com/en-us/defender-office-365/step-by-step-guides/prompt-injection-protection-defender-for-office-365) (2 sep 2026)
- Disponibilidad general de Agent 365 y Microsoft 365 E7: [blog de Microsoft Security, 1 may 2026](https://www.microsoft.com/en-us/security/blog/2026/05/01/microsoft-agent-365-now-generally-available-expands-capabilities-and-integrations/) (leído por buscador)
