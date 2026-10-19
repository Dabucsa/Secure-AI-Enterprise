# Ruta de referente

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 18, 2026 · Danilo Bustamante

Ser referente en seguridad de IA con Microsoft no es saberlo todo. Es que clientes y colegas te busquen porque das respuestas correctas, con fuente y fecha, y porque sabes decir “eso no se puede, pero esto sí”. Se construye sobre tres cosas: **profundidad demostrable** (laboratorios, código, casos), **criterio** (qué recomendar y qué no, para cada cliente) y **visibilidad** (que otros vean lo que sabes).

## 1. Tus tesis

Un referente tiene un punto de vista que repite con ejemplos. Estas siete salen del libro y se sostienen con fuentes:

1. **El agente es una identidad.** Sin Entra Agent ID no hay Conditional Access, ni riesgo, ni investigación que una las piezas.
2. **Copilot respeta los permisos, no los corrige.** El oversharing se arregla antes de encender Copilot.
3. **Defender ve el comportamiento, Purview el contenido, Entra la identidad.** Ningún producto ve todo; el diseño los combina.
4. **La IA no necesita otra landing zone.** Necesita políticas de IA, salida cerrada y un gateway.
5. **La inyección de prompts no se resuelve en el modelo; se contiene.** Mínimo privilegio, aprobación humana y monitoreo.
6. **La seguridad de agentes tiene licencia propia desde julio de 2026.** Agent 365 o E7 para los agentes de Copilot Studio y Foundry.
7. **Un control vale si tiene evidencia medible.** Los documentos no protegen nada.

## 2. Plan de seis meses

| Mes | Objetivo | Actividades | Evidencia de avance |
| --- | --- | --- | --- |
| 1 | Dominar la base | Leer las pestañas de nivel experto; hacer los labs 20 a 24; responder el repaso sin mirar las respuestas | Tus respuestas comparadas con las del libro |
| 2 | Tener un laboratorio propio | Cuenta gratuita de Azure y las pruebas gratuitas de Microsoft 365 y de los productos de seguridad (suelen durar entre 30 y 90 días; revisa cuáles están disponibles en tu país); desplegar `ai-guardrails` y el paquete de detecciones | Una demostración de 20 minutos que puedes repetir |
| 3 | Primer caso real | Aplicar el Kit del consultor a un cliente o a un área de tu empresa: cuestionario, línea base e informe | Un informe entregado y discutido |
| 4 | Publicar | Un artículo por mes y una charla en un grupo de usuarios o evento interno | Publicaciones con comentarios de otros |
| 5 | Certificar | Las certificaciones de tu perfil según el Mapa de certificaciones (por ejemplo, SC-100 o SC-500, más SC-401 o SC-200) | Certificados obtenidos |
| 6 | Comunidad | Responder preguntas en Microsoft Tech Community, contribuir a repositorios, hacer mentoría; considerar programas de comunidad como Microsoft MVP | Personas que te consultan por tu nombre |

## 3. Tu demostración de 20 minutos

Una demostración bien armada vale más que cualquier presentación. Esta usa lo que ya construiste con el libro:

| Minuto | Qué muestras | De dónde sale |
| --- | --- | --- |
| 0 a 4 | Las apps de IA que usa la empresa y cómo se bloquea una | Defender for Cloud Apps y network protection (pestaña Defender para IA) |
| 4 a 8 | Un agente local que se aprueba solo, encontrado con KQL | Lab 22 |
| 8 a 12 | Una app propia que consulta a Purview y bloquea un prompt con una tarjeta | Lab 23 |
| 12 a 16 | Un agente que obtiene tokens sin claves y el error cuando la audiencia es incorrecta | Lab 21 |
| 16 a 20 | La auditoría de una landing zone y la iniciativa de políticas | Lab 24 y módulo `ai-guardrails` |

Cierra siempre con la tabla “hasta dónde se llega”: mostrar los límites es lo que más confianza genera.

## 4. Cómo mantenerte al día

Esta área cambia cada mes. Una rutina corta evita quedar desactualizado:

- **Cada semana (30 minutos):** las páginas “What's new” de Defender XDR, Defender for Endpoint, Defender for Cloud, Entra Agent ID y Purview; el Microsoft 365 Roadmap filtrado por Purview y Copilot; el centro de mensajes si tienes un tenant.
- **Cada mes:** el resumen “What's new in Microsoft Security” del blog de seguridad de Microsoft; las versiones de MITRE ATLAS y de la especificación de MCP; la tarea programada de actualización de este libro.
- **Cada trimestre:** los anuncios de RSAC, Build e Ignite; revisar las tablas de licencias y las fechas de retiro.
- **Cuando Learn no responde:** los repositorios públicos de documentación de Microsoft en GitHub muestran qué cambió y cuándo (`ms.date` de cada página).

## 5. Cómo responder como referente

- **Con estado, fecha y licencia.** “Está en preview desde junio de 2026, solo Windows, requiere MDE Plan 2.”
- **Con límites y alternativa.** “Defender no ve el texto del prompt; para eso está Purview en el navegador o en la red.”
- **Separando lo verificado de lo inferido.** “La documentación dice X; mi lectura es Y; lo confirmo en tu tenant.”
- **Con una recomendación, no un catálogo.** El cliente quiere saber qué hacer primero.

Tres ejemplos de respuestas cortas:

| Pregunta | Respuesta de referente |
| --- | --- |
| “¿Defender ve lo que escriben en ChatGPT?” | “No: ve que se conectan y puede bloquear el sitio. El contenido lo ve Purview, con la extensión en el navegador, Edge for Business o la red de Global Secure Access.” |
| “¿Necesitamos Agent 365?” | “Si tienen agentes de Copilot Studio o Foundry en producción y quieren detectar ataques contra ellos, sí: desde julio de 2026 esa capacidad está ahí. Se licencia por usuario, no por agente.” |
| “¿Copilot es seguro?” | “Copilot hereda tus permisos. Es tan seguro como tu SharePoint: medimos el oversharing en dos semanas y lo sabemos.” |

## 6. Lo que te quita credibilidad

- Presentar funciones en preview como si estuvieran disponibles.
- Citar precios o licencias de memoria.
- Recomendar todos los productos a todos los clientes.
- No conocer los límites de lo que recomiendas.
- Decir “Microsoft se encarga” de algo que es responsabilidad del cliente.

Para practicar con situaciones completas, sigue con la pestaña Casos de experto.
