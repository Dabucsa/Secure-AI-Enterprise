# Purview para IA a fondo

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Purview es la capa que mira el **contenido**: qué datos entran en un prompt, qué datos salen en una respuesta, quién puede verlos y cuánto tiempo se guardan. Defender te dice que alguien usa una app de IA; Purview te dice si le pegó el contrato de un cliente.

Tres ideas ordenan esta pestaña:

1. **Copilot respeta los permisos, no los corrige.** Si un usuario puede abrir un archivo por un enlace demasiado amplio, Copilot también puede usarlo. El oversharing se trabaja antes de encender Copilot, no después.
2. **Purview solo ve lo que le llega.** Copilot llega solo; las apps empresariales llegan por conectores o por la API; la IA de consumo solo llega si el equipo está incorporado con la extensión del navegador, si usa Edge for Business o si el tráfico pasa por la red de Microsoft. Sin esa señal, ninguna política funciona.
3. **La licencia va por capas.** E3 audita y retiene; E5 o Purview Suite protege; el pago por uso (PAYG) cubre la IA que no es de Microsoft; Agent 365 o E7 cubre a los agentes.

**Nombres a la fecha del encabezado:** DSPM for AI se integró en el nuevo **DSPM** unificado (GA en mayo de 2026); las versiones “DSPM (classic)” y “DSPM for AI (classic)” se retiran entre el 30 de noviembre y el 31 de diciembre de 2026. Microsoft 365 E5 Compliance se llama **Purview Suite** desde el 1 de octubre de 2025. Ignite 2026 (17 al 20 de noviembre) traerá cambios: revisa las fechas antes de comprometerlas con un cliente.

## 1. Las tres familias de apps de IA

Purview clasifica las apps de IA en tres familias, y lo que puedes hacer depende de la familia. Los agentes heredan las capacidades de su app.

| Familia | Ejemplos | Cómo llega la señal | Qué puedes aplicar | Costo extra |
| --- | --- | --- | --- | --- |
| Copilot y agentes de Microsoft | Microsoft 365 Copilot, Copilot Chat, Cowork, Copilot Studio, Security Copilot, Copilot en Fabric | Nativa, por los registros de auditoría | DSPM, DLP, etiquetas, Insider Risk, Communication Compliance, auditoría, eDiscovery y retención | Ninguno más allá de la licencia base |
| Apps de IA empresariales | ChatGPT Enterprise, Claude Enterprise, apps registradas en Entra, Foundry | Conectores, integración con Foundry o la API de Purview | Auditoría, clasificación, Insider Risk, eDiscovery y retención; DLP en línea solo si la app consulta la API | Pago por uso para lo que no es de Microsoft |
| Otras apps de IA | ChatGPT y Gemini de consumo, DeepSeek, Copilot de consumo | Equipo incorporado con extensión, Edge for Business o red | DLP de equipo, navegador y red; DSPM; Insider Risk | Pago por uso para la actividad; Edge y Global Secure Access dejan de exigirlo en octubre de 2026 |

El conector de ChatGPT Enterprise sirve para auditoría, clasificación, Insider Risk, eDiscovery y retención, pero no para DLP en línea ni etiquetas, y sus escaneos se pagan por uso. El de Claude Enterprise figura en preview.

## 2. DSPM: descubrir, medir y priorizar

DSPM es el tablero desde donde se empieza cualquier proyecto de datos e IA. Responde qué apps de IA se usan, qué datos sensibles les llegan y qué contenido está sobreexpuesto.

**Lo nuevo de 2026.** El DSPM unificado agrega:

- **AI observability:** un inventario de agentes que incluye los de terceros. El nivel de riesgo, los patrones de riesgo y la remediación guiada solo cubren agentes de Microsoft 365 Copilot, Copilot Studio y Foundry; los de terceros aparecen sin puntuación. Los insights de agentes requieren Agent 365 o E7.
- **Agentes de Security Copilot:** el Data Security Posture Agent (GA en junio de 2026) y el Data Security Triage Agent (GA en diciembre de 2025), que puede ejecutarse con su propia identidad de Entra Agent ID.
- **Señales de terceros** de BigID, Cyera, OneTrust y Varonis, e informes personalizables (preview desde marzo de 2026).

**Políticas de un clic.** DSPM for AI crea políticas listas para usar. Las más útiles: “Detect sensitive info added to AI sites” (DLP de equipo en modo auditoría para lo que se pega o sube a sitios de IA), “Block sensitive info from AI sites” (bloqueo con posibilidad de anular para usuarios con riesgo elevado, con Adaptive Protection), “Detect risky AI usage” (Insider Risk) y “Unethical behavior in AI apps” (Communication Compliance).

**Activity explorer** muestra los prompts y respuestas, las búsquedas web que Copilot usó para responder y los archivos citados. **Ver el texto de prompts y respuestas requiere E5**; con E3 ves qué apps se usan, exportas la actividad y los informes de datos sensibles referenciados.

**Evaluaciones de oversharing.** La evaluación por defecto analiza cada semana los 100 sitios de SharePoint más usados, con un límite de 200.000 elementos por ubicación y resultados en unas 48 horas. Las evaluaciones personalizadas no se actualizan: hay que crear una nueva. Desde marzo de 2026 puedes remediar elemento por elemento (quitar enlaces de uso compartido, etiquetar, avisar al dueño) y desde abril de 2026 también evaluar Fabric.

## 3. DLP para Microsoft 365 Copilot y Copilot Chat

Es la ubicación de DLP “Microsoft 365 Copilot and Copilot Chat”. Hace dos cosas distintas: **impide que Copilot procese contenido etiquetado** y **bloquea prompts con datos sensibles**.

| Función | Estado a octubre de 2026 |
| --- | --- |
| Excluir del procesamiento archivos con cierta etiqueta | GA; desde abril de 2026, en cualquier ubicación de Word, Excel y PowerPoint |
| Excluir correos con cierta etiqueta | GA, solo para correos enviados desde el 1 de enero de 2025 |
| Bloquear prompts que contienen tipos de información sensible: Copilot no responde ni usa el dato | GA desde el 31 de marzo de 2026 |
| Bloquear la búsqueda web cuando el prompt tiene datos sensibles, manteniendo el grounding interno | GA desde junio de 2026; cubre también agentes de Copilot Studio publicados en Copilot |
| Política por defecto “Protect sensitive M365 Copilot interactions” | Creada en modo simulación en todos los tenants |
| Excluir correos de remitentes externos del grounding | Preview desde julio de 2026; GA prevista en enero de 2027 |
| La misma política para Microsoft 365 Copilot Cowork | GA prevista en octubre de 2026 |
| Unidades administrativas | GA prevista en noviembre de 2026 |

La licencia de la exclusión por etiqueta es E5 o Purview Suite. La del bloqueo de prompts no está clara: la descripción del servicio dice que está disponible para todos los usuarios de Copilot y varios partners dicen que requiere E5. Confírmala en el tenant antes de cotizar.

**Límites que hay que contar al cliente:**

- Solo evalúa el **texto escrito** en el prompt. Los archivos que el usuario sube al chat no se inspeccionan.
- Las citas de la respuesta pueden seguir mostrando un archivo excluido, aunque su contenido no se use.
- En una misma regla no se pueden combinar “contiene información sensible” y “tiene la etiqueta”; usa reglas separadas en la misma política.
- Al elegir la ubicación de Copilot, la política no admite otras ubicaciones.

Cómo desplegarla: activa la política por defecto en simulación, revisa una o dos semanas qué habría bloqueado, empieza por excluir la etiqueta más alta (por ejemplo “Altamente confidencial”) y después activa el bloqueo de prompts con los tipos de información que importan al negocio.

## 4. DLP fuera de Copilot: equipo, navegador y red

Para la IA que no es de Microsoft hay tres puntos de control, y conviene combinarlos.

| Punto de control | Qué inspecciona | Requisitos | Estado y licencia |
| --- | --- | --- | --- |
| DLP de equipo (Endpoint DLP) | Pegar en el navegador y subir archivos a dominios de IA, definidos en grupos de dominios sensibles dentro de la regla | Equipo incorporado; extensión de Purview en Chrome y Firefox (Edge es nativo) | GA; E5 |
| Protección en línea de Edge for Business | Texto escrito o pegado y archivos subidos a ChatGPT, Gemini, DeepSeek, Copilot de consumo y otras apps de la lista | Solo Windows gestionado por Intune; funciona sin Endpoint DLP | Subida de archivos GA en enero de 2026; el pago por uso deja de exigirse a mediados y fines de octubre de 2026 (MC1470881) |
| Red con Global Secure Access | Texto, prompts y archivos de usuarios y del tráfico de agentes que actúan en su nombre | Cliente de Global Secure Access; inspección TLS | GA el 24 de septiembre de 2026; E7, o Purview E5 más Entra Internet Access, sin pago por uso desde octubre de 2026 (MC1478970) |
| Red con SASE de terceros | Lo que sale por el proxy del partner | Netskope e iboss (GA en noviembre de 2025); Palo Alto Prisma Access prevista para octubre de 2026 | Sigue requiriendo pago por uso |

Dos novedades útiles: desde Edge 148 (mayo de 2026), cuando DLP bloquea un prompt, Edge ofrece **llevar el mismo prompt a Microsoft 365 Copilot**, que convierte un bloqueo en una alternativa aprobada. Y desde abril de 2026 la DLP de equipo impide que Recall capture ventanas con contenido etiquetado en los Copilot+ PC.

Cómo elegir: equipo corporativo con Windows gestionado → Edge for Business y Endpoint DLP; Chrome corporativo → Endpoint DLP con la extensión; equipos no gestionados o tráfico de agentes → red con Global Secure Access; una app que no está en ninguna lista → la red, que desde diciembre de 2026 podrá aplicar políticas a cualquier sitio.

## 5. Etiquetas, cifrado y oversharing

**Cómo trata Copilot el contenido etiquetado** ([arquitectura de protección de datos, 7 abr 2026](https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-architecture-data-protection-auditing)):

- Si la etiqueta cifra, Copilot solo usa el contenido cuando el usuario tiene los derechos **EXTRACT y VIEW**. Una etiqueta con cifrado y sin EXTRACT es la forma de que Copilot no pueda resumir un archivo.
- Con **permisos definidos por el usuario**, los agentes de Copilot no pueden leer el archivo.
- Lo que Copilot genera a partir de fuentes etiquetadas **hereda la etiqueta de mayor prioridad** y su protección. La herencia está incluida en E3; el etiquetado automático y las etiquetas por defecto requieren E5.
- El etiquetado automático simula ahora hasta 20 millones de elementos y 50.000 sitios (GA en septiembre de 2026), y Azure AI Search respetará las etiquetas en sus indexadores para RAG (GA prevista en octubre de 2026).
- Con Double Key Encryption, Copilot casi seguro no puede procesar el contenido, porque DKE no admite búsqueda ni DLP en SharePoint; Microsoft no lo dice explícitamente para Copilot.

**Las herramientas de oversharing de SharePoint.** SharePoint Advanced Management (SAM) viene incluido cuando el tenant tiene al menos una licencia de Copilot.

| Herramienta | Qué hace | Lo que no hace |
| --- | --- | --- |
| Informes de gobierno de acceso (DAG) | Sitios con enlaces amplios, “Everyone except external users” y etiquetas | No corrige nada por sí solo |
| Restricted Content Discovery (RCD) | Saca un sitio de la búsqueda de la organización y de Copilot | No cambia permisos: quien tiene acceso sigue abriendo los archivos. No aplica a OneDrive. En sitios de más de 500.000 elementos puede tardar más de una semana |
| Restricted Access Control (RAC) | Limita el acceso a un sitio a ciertos grupos | Requiere decidir quién debe entrar |
| Restricted SharePoint Search (RSS) | Lista de hasta 100 sitios permitidos para Copilot | **Se retira:** desde el 31 de julio de 2026 no se puede activar en tenants nuevos; usa RCD |
| Microsoft 365 Archive | El contenido archivado sale del índice de Copilot y sigue bajo retención y eDiscovery | GA en septiembre de 2026 |

Orden que funciona en proyectos: primero el informe de DSPM y los de SAM para ver la exposición real; después quitar los enlaces amplios en los sitios críticos; mientras tanto, RCD en esos sitios para que Copilot no los use; luego etiquetas por defecto en bibliotecas y etiquetado automático; al final, DLP de Copilot por etiqueta. RCD es un torniquete, no la cura.

## 6. Insider Risk, Communication Compliance, auditoría, eDiscovery y retención

| Capacidad | Qué hace con IA | Detalle que importa | Licencia |
| --- | --- | --- | --- |
| Insider Risk, plantilla Risky AI usage | Detecta prompts riesgosos e intentos de inyección, y respuestas con datos sensibles en Copilot, apps empresariales y otras apps de IA; alimenta Adaptive Protection | Desde junio de 2026 eliges qué app vigila cada indicador. El indicador de otras apps de IA se paga por uso desde el 1 de abril de 2026; los de Copilot siguen incluidos | E5 |
| Insider Risk para agentes (Risky Agents) | Agentes expuestos a prompts riesgosos, que generan respuestas sensibles, acceden a archivos sensibles o comparten fuera | GA mundial entre junio y julio de 2026; en gobierno, octubre de 2026. Microsoft todavía la etiqueta de forma inconsistente como preview | Agent 365 o E7 |
| Communication Compliance | Plantilla para interacciones de Copilot con Prompt Shields y detección de material protegido | Para apps de IA que no son de Microsoft 365 se paga por uso | E5 |
| Auditoría | Registros `CopilotInteraction`, `ConnectedAIAppInteraction` y `AIAppInteraction` | 180 días en Audit Standard; para conservar más, Audit Premium con una política de retención de auditoría propia. Las apps que no son de Microsoft se pagan por uso | E3 |
| eDiscovery | Las interacciones de Copilot se guardan en el buzón del usuario; también Copilot Pages y archivos referenciados | E3 busca, retiene y exporta; E5 además borra, de a 10 elementos por buzón. Borrar la conversación no borra la memoria de Copilot | E3 y E5 |
| Retención | Ubicaciones propias: “Microsoft Copilot experiences”, “Enterprise AI apps” y “Other AI apps” | **En octubre de 2026 las políticas antiguas de chats de Teams dejan de cubrir Copilot (RM-571306): crea políticas específicas para Copilot** | E3; otras apps por uso |

La fila de retención es la que más clientes van a pasar por alto este trimestre: si su retención de Copilot dependía de la política de Teams, desde octubre ya no la tienen.

## 7. Apps y agentes propios: la API de Purview

Purview no intercepta el tráfico de una app que tú construyes. **Tu app tiene que preguntarle** antes de enviar el prompt al modelo y antes de mostrar la respuesta. Para eso está la API `dataSecurityAndGovernance` de Microsoft Graph, en v1.0 desde junio de 2025:

| Llamada | Para qué | Permiso |
| --- | --- | --- |
| `protectionScopes/compute` | Saber qué actividades están bajo política y en qué modo; se guarda en caché | ProtectionScopes.Compute.User |
| `processContent` | Evaluar un prompt o una respuesta y recibir la acción (hoy solo `restrictAccess`) | Content.Process.User |
| `contentActivities` | Registrar la interacción para auditoría, DSPM y eDiscovery sin evaluarla en línea | ContentActivity.Write |

Este es el patrón mínimo, con los campos del ejemplo oficial de Graph. Lo probé contra un servidor local que imita la respuesta de bloqueo; no contra Purview real:

```python
import uuid
from datetime import datetime, timezone

import requests

GRAPH = "https://graph.microsoft.com/v1.0"


def prompt_permitido(token_graph: str, usuario_oid: str, prompt: str, app_id: str) -> bool:
    """Pregunta a Purview si las políticas permiten este prompt antes de enviarlo al modelo."""
    ahora = datetime.now(timezone.utc).isoformat()
    cuerpo = {"contentToProcess": {
        "contentEntries": [{
            "@odata.type": "microsoft.graph.processConversationMetadata",
            "identifier": str(uuid.uuid4()),
            "content": {"@odata.type": "microsoft.graph.textContent", "data": prompt},
            "name": "Prompt del portal de clientes",
            "correlationId": str(uuid.uuid4()),
            "sequenceNumber": 0,
            "isTruncated": False,
            "createdDateTime": ahora,
            "modifiedDateTime": ahora,
        }],
        "activityMetadata": {"activity": "uploadText"},
        "deviceMetadata": {"deviceType": "Unmanaged"},
        "protectedAppMetadata": {
            "name": "portal-clientes", "version": "1.0",
            "applicationLocation": {"@odata.type": "microsoft.graph.policyLocationApplication", "value": app_id},
        },
        "integratedAppMetadata": {"name": "portal-clientes", "version": "1.0"},
    }}
    respuesta = requests.post(f"{GRAPH}/users/{usuario_oid}/dataSecurityAndGovernance/processContent",
                              json=cuerpo, headers={"Authorization": f"Bearer {token_graph}"}, timeout=10)
    respuesta.raise_for_status()
    if respuesta.status_code != 200:  # 202 o 204: Purview no devolvió una decisión en línea
        return True
    acciones = respuesta.json().get("policyActions", [])
    return not any(a.get("restrictionAction") == "block" for a in acciones)
```

Decisiones de diseño que debes tomar tú: si Purview no responde o devuelve 202, ¿dejas pasar o bloqueas? Para datos regulados conviene fallar cerrado. Guarda en caché el resultado de `protectionScopes/compute` y vuelve a calcularlo cuando una respuesta traiga `protectionScopeState = modified`.

**Lo que hay que saber antes de prometerlo:**

- Requiere **E5 más pago por uso** configurado; sin pago por uso la API responde **402**.
- Para apps registradas en Entra, la DLP hoy solo admite **bloquear prompts por tipo de información sensible**, y la política se crea por PowerShell con `New-DlpCompliancePolicy -EnforcementPlanes @("Application")` y el App ID como ubicación.
- **Microsoft Agent Framework** trae un middleware que hace esto por ti: `agent-framework-purview` en Python y `Microsoft.Agents.AI.Purview` en .NET. Evalúa prompt y respuesta y bloquea con “Prompt blocked by policy”. Está en **preview** (versión de Python del 15 de octubre de 2026).
- **Foundry** tiene un interruptor de Purview por suscripción (GA en mayo de 2026, rol Cognitive Services Security Integration Administrator). Las políticas solo se aplican si la llamada lleva **token del usuario** o contexto de usuario; con la identidad del servicio solo hay auditoría. La DLP en línea de prompts de Foundry está en preview, con GA prevista en octubre de 2026. El método anterior desde Defender for Cloud se retira y no incluía agentes.
- **Copilot Studio** admite casi todo Purview salvo el cifrado sin etiqueta. Ojo: los controles de conectores de Copilot Studio son las directivas de datos de Power Platform, que no son Purview DLP.
- **Agent 365:** cada instancia de agente entra en políticas de DLP e Insider Risk **como si fuera un usuario**. La auditoría y la clasificación se activan solas. Detalle de diseño: **el agente no se entera de que lo bloquearon**, así que los flujos que dependen de él deben tolerarlo.
- Para agentes locales de programación (Claude Code, Codex, Copilot CLI), Purview se anunció en Build 2026 como preview o “próximamente”.

## 8. Licencias

| Capa | Qué incluye para IA |
| --- | --- |
| Con cualquier licencia de Copilot | SharePoint Advanced Management (RCD, RAC, informes de acceso) |
| E3 | Auditoría de Copilot y apps de IA; retención de interacciones; eDiscovery para buscar, retener y exportar; etiquetas manuales y herencia en las respuestas; DSPM básico sin ver prompts |
| E5, o E3 más Purview Suite (12 USD) | DSPM completo con prompts y respuestas; DLP de Copilot por etiqueta; DLP de equipo; etiquetado automático; Insider Risk y Adaptive Protection; Communication Compliance; eDiscovery con borrado |
| E5 más pago por uso | Actividad, auditoría, retención y Communication Compliance de IA que no es de Microsoft; indicador de Insider Risk de otras apps; la API de Purview para apps propias; SASE de terceros; conector de ChatGPT Enterprise |
| Sin pago por uso desde octubre de 2026 | Protección en línea de Edge for Business; DLP de red con Global Secure Access (E7, o Purview E5 más Entra Internet Access) |
| Agent 365 (15 USD) o E7 (99 USD) | DSPM e insights de agentes, Insider Risk para agentes, DLP para agentes, herencia de etiquetas por agentes, retención y Communication Compliance para agentes |

Agent 365 solo se puede asignar a usuarios con E5, o con E3 más Defender Suite y Purview Suite: un cliente con E3 más Copilot no puede comprarlo directamente. Precios de lista en dólares de la [página de precios de Purview](https://www.microsoft.com/en-us/security/microsoft-purview-pricing) y de las [preguntas frecuentes de Agent 365](https://www.microsoft.com/licensing/faqs/122), consultadas el 18 de octubre de 2026.

## 9. Hasta dónde llega Purview

| Mito | Realidad |
| --- | --- |
| “Con DLP para Copilot nadie puede filtrar un archivo confidencial por Copilot.” | DLP excluye contenido etiquetado y bloquea prompts con datos sensibles, pero no inspecciona los archivos que el usuario sube al chat, y las citas pueden mostrar el archivo excluido. |
| “RCD protege los sitios sensibles.” | RCD los oculta de Copilot y de la búsqueda. Los permisos quedan igual y quien tenía acceso sigue entrando. |
| “Purview ve lo que los empleados escriben en ChatGPT.” | Solo con el equipo incorporado y la extensión, con Edge for Business en Windows gestionado o con la red de Global Secure Access. En un equipo personal sin nada de eso, no ve nada. |
| “Si activo Purview en Foundry, mis agentes quedan protegidos.” | Las políticas necesitan el token o el contexto del usuario. Un agente que llama con su identidad de servicio solo queda auditado. |
| “Mi app propia queda protegida con crear la política DLP.” | La app tiene que llamar a `processContent` y obedecer la respuesta. Sin esa llamada, la política no hace nada. |
| “Borrar la conversación de Copilot con eDiscovery borra todo.” | Borra de a 10 elementos por buzón y no borra la memoria de Copilot, que se elimina aparte. |
| “Mi política de retención de Teams cubre Copilot.” | Desde octubre de 2026 ya no. Hay que crear políticas en las ubicaciones de IA. |

Otros límites: la protección de Edge solo cubre las apps de su lista hasta la ampliación de noviembre de 2026 a enero de 2027; los equipos no gestionados solo se cubren por red (y por MAM en 2027); las nubes de gobierno van entre tres y seis meses atrás.

## 10. Secuencia de despliegue para un cliente

1. **Semanas 1 y 2, visibilidad:** auditoría activada, DSPM con sus políticas de descubrimiento, la DLP por defecto de Copilot en simulación y la evaluación de oversharing. Entregable: qué IA se usa, qué datos le llegan y dónde está la exposición.
2. **Semanas 2 a 6, oversharing:** informes de SAM, limpieza de enlaces amplios en sitios críticos, RCD como medida temporal, etiquetas por defecto en bibliotecas.
3. **Semanas 6 a 10, protección:** DLP de Copilot por etiqueta y por tipo de información; DLP de equipo y Edge para IA de consumo; políticas de retención en las ubicaciones de IA.
4. **Semanas 10 a 12, riesgo interno:** Insider Risk con Risky AI usage y Adaptive Protection; Communication Compliance si el negocio lo exige.
5. **Continuo:** revisión mensual de DSPM, apps nuevas sin decisión, agentes nuevos y las fechas de cambio de Microsoft.

## 11. Para repasar

1. Un cliente activó Copilot y un usuario de ventas obtuvo un resumen de un archivo de recursos humanos. ¿Qué falló, qué haces esta semana y qué haces en el próximo mes?
2. ¿Qué necesitas para ver y bloquear lo que los empleados pegan en ChatGPT de consumo desde Chrome en un equipo corporativo, y qué cambia si el equipo es personal?
3. Tu equipo construye un agente con Agent Framework que llama a Azure OpenAI con identidad administrada. ¿Cómo haces que respete las políticas de DLP del usuario?
4. ¿Qué diferencia hay entre excluir un archivo etiquetado con DLP de Copilot y ocultar su sitio con RCD?
5. ¿Qué cambió en octubre de 2026 en la retención de Copilot y qué tiene que hacer el cliente?

Para practicar la API de Purview con una app propia y la DLP de Copilot, haz el Lab 23 de la pestaña Laboratorios.

## Fuentes

Las páginas de Learn de Purview no se pudieron descargar desde el entorno donde se escribió esta pestaña; se verificaron con extractos de búsqueda, el feed oficial del Microsoft 365 Roadmap (descargado el 18 de octubre de 2026) y documentación de Microsoft en GitHub. Lo marcado como “prevista” sale del roadmap y puede moverse.

- [Copilot Control System: seguridad y gobierno](https://learn.microsoft.com/en-us/copilot/microsoft-365/copilot-control-system/security-governance) (25 feb 2026) y [base segura para Copilot](https://learn.microsoft.com/en-us/microsoft-365/copilot/configure-secure-governed-data-foundation-microsoft-365-copilot) (17 abr 2026)
- [Arquitectura de protección de datos y auditoría de Copilot](https://learn.microsoft.com/en-us/copilot/microsoft-365/microsoft-365-copilot-architecture-data-protection-auditing) (7 abr 2026)
- [Funciones de Copilot por licencia E3, E5 y E7](https://learn.microsoft.com/en-us/microsoft-365/copilot/microsoft-365-copilot-license-feature-overview)
- [API processContent de Microsoft Graph](https://learn.microsoft.com/en-us/graph/api/userdatasecurityandgovernance-processcontent) y [ejemplos de la API de Purview](https://github.com/microsoft/purview-api-samples)
- Microsoft Security Blog: [RSAC, 20 mar 2026](https://www.microsoft.com/en-us/security/blog/2026/03/20/secure-agentic-ai-end-to-end/), [Build, 2 jun 2026](https://www.microsoft.com/en-us/security/blog/2026/06/02/microsoft-build-2026-securing-code-agents-and-models-across-the-development-lifecycle/) y [novedades de septiembre de 2026](https://www.microsoft.com/en-us/security/blog/2026/09/24/whats-new-in-microsoft-security-september-2026/)
- [Microsoft 365 Roadmap](https://www.microsoft.com/microsoft-365/roadmap): RM-532728 (DSPM), RM-515945 (bloqueo de prompts), RM-548671 (búsqueda web), RM-571306 (retención), RM-516032 (Purview para agentes)
