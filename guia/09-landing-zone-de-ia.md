# Landing zone de IA segura

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Cuando un cliente dice “queremos una landing zone de IA”, la primera frase del experto es la del Cloud Adoption Framework: **las cargas de IA no necesitan otra arquitectura de landing zone ni otro modelo de gobierno** ([CAF, AI Ready, 14 oct 2026](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ai/ready)). Usas la misma jerarquía de management groups (la IA interna bajo **Corp**, la expuesta a Internet bajo **Online**), las mismas políticas base de la plataforma, y le agregas los controles propios de la IA. Esta pestaña dice cuáles son, cómo se imponen y qué evidencia le entregas al cliente.

## 1. Seis principios

1. **Misma landing zone, controles adicionales.** No inventes management groups de IA; asigna una iniciativa de IA sobre Corp y Online.
2. **Un recurso Foundry por carga en producción.** Es la frontera de red y de identidad: los private endpoints son por recurso, no por proyecto.
3. **Nada expuesto a Internet salvo la entrada con WAF.** Application Gateway o Front Door es el único recurso público; todo lo demás, por private endpoint.
4. **Salida cerrada por defecto.** Los agentes navegan y llaman herramientas: la salida va por un firewall con lista de dominios permitidos.
5. **Sin claves.** Entra ID e identidades administradas en todo; una identidad de Entra Agent ID por agente.
6. **Primero auditar, después bloquear.** Las políticas empiezan en Audit y pasan a Deny cuando el cumplimiento está limpio.

## 2. Controles por capa

| Capa | Control | Cómo se impone | Evidencia para el cliente |
| --- | --- | --- | --- |
| Gobierno | IA bajo Corp u Online; políticas base de la plataforma más una iniciativa de IA. La iniciativa `Enforce-Guardrails-OpenAI` de la librería de Azure Landing Zones viene asignada con **enforcementMode DoNotEnforce**: hay que activarla a propósito | Azure Policy en el management group | Informe de cumplimiento del management group |
| Identidad | Acceso por clave deshabilitado en AI Services y AI Search; identidades administradas; RBAC mínimo (*Cognitive Services OpenAI User*, *Azure AI User*); PIM con aprobación para roles de administración; Agent ID por agente; conexiones de Foundry a nivel de proyecto | Azure Policy, Entra, IaC | Cumplimiento de las políticas de identidad; exportación de asignaciones de roles; informe de PIM |
| Red de entrada | Private endpoints para todos los servicios de IA y sus dependencias; zonas DNS privadas centrales (`privatelink.services.ai.azure.com`, `privatelink.openai.azure.com`, `privatelink.cognitiveservices.azure.com`); NSG en todas las subredes; WAF; DDoS en la IP pública | Azure Policy e IaC | Diagrama de red, cumplimiento de las políticas de red |
| Salida | Azure Firewall con lista de dominios permitidos; subred delegada para la salida de los agentes con ruta al firewall; managed VNet en modo “allow only approved outbound” para hubs y Machine Learning; sin inspección TLS en el tráfico de los agentes y con la etiqueta `AzureActiveDirectory` permitida | Firewall policy, rutas, Azure Policy | Exportación de reglas del firewall; logs de salida |
| Gateway de IA | API Management delante de los modelos: valida el token de Entra, usa identidad administrada hacia el modelo, limita tokens, aplica Content Safety y emite métricas por consumidor | Políticas de APIM como código | Política XML en el repositorio; logs del gateway |
| Modelos | Solo publicadores o modelos aprobados; sin modelos en preview; filtro de contenido o guardrail por despliegue, gestionado como código | Azure Policy e IaC | Inventario de despliegues comparado con la lista aprobada |
| Datos | Clave administrada por el cliente cuando la política de datos lo exige; Key Vault dedicado a Foundry; integración con Purview; tipo de despliegue (Global, Data Zone o regional) según la residencia requerida | Azure Policy, decisión de arquitectura | Configuración de cifrado; registro de decisiones de residencia |
| Aplicación | Validar en la app que cada conversación pertenece al usuario; restringir el portal de Foundry en producción; crear proyectos solo por pipeline; un proyecto por patrón de acceso | Diseño y revisión de código | Modelo de amenazas y prueba de penetración |
| Monitoreo y detección | Logs de diagnóstico a Log Analytics; Defender for AI Services, Defender CSPM con AI-SPM, Defender for Servers, App Service y Cosmos DB; alertas base de Azure Monitor para IA; Sentinel con reglas de IA | Azure Policy y Defender for Cloud | Secure Score, alertas de prueba, reglas activas |

Tres detalles que salen de la arquitectura de referencia de Foundry y que casi nadie conoce ([baseline de Foundry, 17 jun 2026](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/architecture/baseline-microsoft-foundry-chat)):

- **Foundry Agent Service no autoriza las conversaciones por usuario.** Si tu app no valida que la conversación pertenece a quien la pide, un usuario puede leer la de otro (BOLA, OWASP API1:2023).
- **Todos los agentes de prompt de un proyecto comparten la identidad administrada del proyecto,** que en modo Standard tiene permisos casi totales sobre su Storage, AI Search y Cosmos DB. Separa proyectos por patrón de acceso y aísla esas dependencias de los datos de la carga. Los hosted agents sí reciben su propia identidad de agente.
- **La herramienta de búsqueda web sale por fuera de la subred de salida de los agentes.** Prueba cada herramienta contra el firewall; no asumas que todo pasa por él.

Y uno de la guía de gateways: el gateway de IA **ve los prompts y las respuestas en claro**, así que entra en el alcance de cumplimiento y de protección de datos. Microsoft lo dice explícitamente: no lo implementes si no puedes proteger lo que ve.

## 3. El módulo de políticas del repositorio

Este repositorio trae la carpeta [`ai-guardrails/`](../ai-guardrails/README.md): una iniciativa de Azure Policy con 12 definiciones integradas que se asigna a un management group. Los IDs, parámetros y efectos permitidos se tomaron del repositorio oficial `Azure/azure-policy` el 18 de octubre de 2026.

| Grupo | Políticas integradas | Efecto |
| --- | --- | --- |
| Identidad | Acceso por clave deshabilitado en AI Services (`71ef260a`) y AI Search (`6300012e`); identidad administrada en AI Services (`fe3fd216`) | `guardrailEffect` |
| Red | Restringir el acceso de red (`037eea7a`); Private Link (`d6759c02`, solo Audit); AI Search sin red pública (`ee980b6d`); managed VNet con salida solo aprobada en hubs y Machine Learning (`6ddb1705`) | `guardrailEffect` |
| Modelos | Solo modelos aprobados en Foundry (`aafe3651`); requisitos de elegibilidad, sin modelos en preview (`8791d062`, preview) | `modelEffect` |
| Datos | Clave administrada por el cliente (`67121cc7`) | `cmkEffect` |
| Monitoreo | Logs de diagnóstico (`1b4d1c4e`); Defender for AI Services activado (`c2c0c6d8`) | AuditIfNotExists |

```bash
az deployment mg create \
  --management-group-id mg-landingzones-corp \
  -l eastus \
  -f ai-guardrails/main.bicep \
  -p ai-guardrails/main.bicepparam
```

Cómo desplegarla con un cliente:

1. Despliega con todo en **Audit** y espera la primera evaluación de cumplimiento (o fuérzala con `az policy state trigger-scan`).
2. Corrige o exime lo que no cumple. Lo típico: AI Services con claves habilitadas, endpoints públicos y modelos de publicadores fuera de la lista.
3. Pasa `guardrailEffect` y `modelEffect` a **Deny**. Deny bloquea lo nuevo o lo que se modifica; **no borra lo que ya existe**, que se remedia a mano.
4. Deja la clave administrada en Audit salvo que la política de datos la exija.

Un detalle que rompe despliegues: la política de modelos aprobados marca como no conforme **todo** despliegue si las dos listas (publicadores y asset IDs) están vacías. Y es una política de modo de datos (`Microsoft.CognitiveServices.Data`): evalúa los despliegues de modelos, no la cuenta.

Lo que la iniciativa no cubre, a propósito: la iniciativa en preview *Guardrail for Cognitive Services Deployments* (`5207647b`), que exige acordar 40 parámetros de umbrales de filtros; las políticas que despliegan configuración (como `359a48a3`, que activa Defender for AI Services), que necesitan identidad y roles en la asignación; y los controles de plataforma que ya ponen las políticas de Azure Landing Zones. El módulo pasa `bicep build` y `bicep lint` sin advertencias, pero **no se desplegó en un tenant real**: usa `what-if` primero. El commit está en la rama local, pendiente de subir cuando haya permisos de GitHub.

## 4. Implementaciones de referencia de Microsoft

| Implementación | Qué despliega | Cuándo usarla | Estado |
| --- | --- | --- | --- |
| [AI Landing Zones](https://github.com/Azure/AI-Landing-Zones) | Dos arquitecturas: **Agent Landing Zone** (Foundry, AI Search, Cosmos DB, Container Apps, Key Vault, con private endpoints, Bastion y DNS privado) y **AI Gateway Landing Zone** (API Management delante de los modelos de Foundry). Bicep (`bicep-ptn-aiml-landing-zone` v2.7.3), Terraform (v0.5.3) y con la app incluida (`agent-landing-zone` v4.3.0, 14 oct 2026) | Clientes que quieren una application landing zone lista, con o sin platform landing zone | GA desde el 17 nov 2025 según su página de novedades; el README todavía dice preview |
| [Baseline de chat con Foundry](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/architecture/baseline-microsoft-foundry-chat) y su versión en landing zone | Application Gateway con WAF, Azure Firewall, Foundry Agent Service en modo Standard con dependencias propias, App Service; código en `Azure-Samples/microsoft-foundry-baseline` | Para entender las decisiones de seguridad y justificar cada control ante el cliente | Architecture Center, 17 jun 2026 |
| Guía de gateways para modelos de Foundry | Patrones de API Management: autenticación, límites de tokens, varios modelos, monitoreo | Cuando hay varios consumidores o varios modelos | Architecture Center, 30 abr 2026 |
| Librería de Azure Landing Zones | Iniciativas `Enforce-Guardrails-OpenAI`, `Enforce-Guardrails-CognitiveServices` y `Enforce-Guardrails-MachineLearning` | Clientes que ya usan Azure Landing Zones | Asignadas en DoNotEnforce por defecto |

Antes de entregar la Agent Landing Zone como “segura para producción”, revisa tres cosas: el jumpbox recibe roles amplios (Contributor y Data Owner); el parámetro `allowedIpRanges` abre excepciones a “solo privado” en siete servicios; y el plano de control de Azure Resource Manager sigue siendo público aunque los servicios no lo sean. La versión 2 de la plantilla Bicep (mayo de 2026) agregó `deploymentMode = ailz-integrated` para reutilizar el firewall, el DNS y Log Analytics del hub.

## 5. Lista de revisión de una landing zone de IA

Basada en la lista de diseño de AI Landing Zones (IDs entre paréntesis). Úsala en una revisión de arquitectura:

- [ ] Políticas de IA asignadas en cada management group con IA (G-R1) y modelos permitidos de Audit a Deny (G-R5)
- [ ] Content Safety con Prompt Shields como filtro base en cada despliegue (G-R4)
- [ ] Identidades administradas con mínimo privilegio y Entra ID en lugar de claves (I-R1, I-R3, I-R6)
- [ ] PIM y Conditional Access para el plano de control (I-R2, I-R4)
- [ ] Ningún servicio PaaS ni endpoint de modelo accesible desde Internet (N-R3)
- [ ] NSG en todas las subredes y WAF en la entrada (N-R4, N-R5)
- [ ] API Management como gateway de IA con Entra ID y límites de tokens (N-R6)
- [ ] Firewall con ruta forzada y zonas DNS privadas centrales (N-R7, N-R8)
- [ ] Salida restringida por defecto a destinos aprobados (N-R9)
- [ ] Defender for Cloud con AI-SPM y protección contra amenazas de IA (S-R1)
- [ ] Modelado de amenazas con MITRE ATLAS y OWASP GenAI (S-R4) y red teaming antes de producción
- [ ] Logs de diagnóstico en Log Analytics, alertas base y Sentinel (M-R\*)
- [ ] La app valida la propiedad de cada conversación
- [ ] Una identidad de Agent ID por agente, con sponsor

## 6. Errores comunes

| Creencia | Realidad |
| --- | --- |
| “Con private endpoints la IA no sale a Internet.” | Los private endpoints controlan la entrada. La salida de agentes y herramientas es otro control, y la búsqueda web de Foundry ni siquiera pasa por la subred de salida. |
| “Paso las políticas a Deny y se arreglan los recursos.” | Deny solo frena lo nuevo o modificado. Lo existente se remedia a mano o con políticas de despliegue. |
| “Asigné la iniciativa NIST AI RMF de Azure Policy, ya cumplo NIST AI RMF.” | Esa iniciativa tiene una sola política (logs de diagnóstico). La de EU AI Act tiene seis. El resto de los marcos son controles organizativos. |
| “La plantilla de Microsoft ya es segura para producción.” | Es una muy buena base. El jumpbox con roles amplios, las excepciones de IP y el portal de Foundry abierto son decisiones tuyas. |
| “Foundry protege las conversaciones de cada usuario.” | Agent Service no autoriza por usuario. La app debe validar que la conversación es de quien la pide. |
| “El gateway no agrega riesgo.” | Ve los prompts y respuestas en claro: es un sistema más en el alcance de cumplimiento. |

## 7. Para repasar

1. Un cliente quiere crear un management group “IA” con sus propias políticas. ¿Qué le recomiendas y por qué?
2. Pasaste la política de modelos aprobados a Deny y siguen existiendo despliegues de un modelo no aprobado. ¿Es un error de la política?
3. Nombra tres controles de la arquitectura de referencia de Foundry que no se pueden imponer con Azure Policy y dónde se controlan.
4. ¿Por qué la salida de los agentes necesita un control distinto de los private endpoints, y qué herramienta de Foundry es la excepción?
5. ¿Qué evidencia le entregas al cliente para demostrar que ningún modelo usa claves de acceso?

Para auditar una landing zone real con Resource Graph y compararla con la iniciativa de políticas, haz el Lab 24 de la pestaña Laboratorios.

## Fuentes

Leídas desde los repositorios públicos de Microsoft en GitHub el 18 de octubre de 2026:

- Cloud Adoption Framework: [AI Ready](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ai/ready) (14 oct 2026), [seguridad](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ai/platform/security) y [gobierno de PaaS para IA](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ai/platform/governance) (9 oct 2026), [redes](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ai/platform/networking)
- [AI Landing Zones](https://github.com/Azure/AI-Landing-Zones) y su lista de diseño (`docs/architecture/design-checklist.md`)
- Azure Architecture Center: [baseline de chat con Foundry](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/architecture/baseline-microsoft-foundry-chat) y [en landing zone](https://learn.microsoft.com/en-us/azure/architecture/ai-ml/architecture/baseline-microsoft-foundry-landing-zone) (17 jun 2026)
- [Definiciones integradas de Azure Policy](https://github.com/Azure/azure-policy) y [librería de Azure Landing Zones](https://github.com/Azure/Azure-Landing-Zones-Library) (versión 2026.10.0)
- Las URLs de Learn del CAF se infirieron de la ruta de cada archivo en el repositorio; si alguna cambió, busca el título.
