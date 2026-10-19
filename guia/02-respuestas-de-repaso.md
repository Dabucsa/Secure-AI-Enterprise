# Respuestas de repaso

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Respuestas modelo a las preguntas “Para repasar” de cada capítulo y de las pestañas MCP, A2A, Ataques con IA, Residencia y LatAm, Memoria y extensibilidad, Agentes con Entra, Defender para IA, Purview para IA, Visibilidad de agentes, Landing zone de IA, Marcos y cómo aplicarlos, Proyectos de cliente y Kit del consultor. Intenta responder primero; una buena respuesta tuya puede usar otras palabras siempre que contenga la idea clave, que aparece en negrita.

## Capítulos 1 a 4

### Capítulo 1 · Panorama 2026

1. **Por qué cubrir solo lo que construye TI deja fuera la mayor parte del riesgo.** Porque de los siete patrones de adopción, TI construye uno o dos (el “GPT interno” y algunos RAG). **Los copilots SaaS, los agentes low-code del negocio, los agentes de código en los endpoints y el shadow AI** quedan fuera, y ahí están el oversharing, las conexiones con credenciales del creador, los servidores MCP locales y la fuga a servicios no aprobados.
2. **Capas tuyas en M365 Copilot.** La capa de **uso** completa: identidad y acceso de usuarios, gobierno y clasificación de datos, permisos de SharePoint y formación. También la **configuración** de la capa de aplicación: qué agentes y conectores se permiten. El modelo, su seguridad y la infraestructura son de Microsoft.
3. **Qué dice la ola de adquisiciones.** Que la seguridad de IA se está volviendo **una función de las plataformas** (SASE, XDR, firewall, identidad). Antes de comprar una herramienta especializada, revisa si tu plataforma actual ya la trae o la traerá, y evalúa el riesgo de que una startup sea comprada y cambie su hoja de ruta.

### Capítulo 2 · Arquitectura de referencia

1. **Por qué el gateway es el único punto para todo el tráfico.** Porque es el único componente por el que **pasan todas las llamadas** a modelos y herramientas, sin importar qué equipo construyó la app. La política en cada aplicación depende de que cada equipo la implemente bien; en el gateway se aplica una sola vez. Condición: el modelo no debe ser alcanzable por otro camino.
2. **Qué elimina `disableLocalAuth: true`.** Elimina el riesgo de **API keys filtradas**: una clave robada ya no sirve. Antes de activarlo, todas las aplicaciones deben autenticarse con **Entra ID** (identidades administradas o federación) y tener el rol correcto sobre el recurso; si no, se rompen.
3. **Regional frente a global.** Regional o de zona de datos cuando hay **requisitos de residencia** o regulatorios sobre dónde se procesa la inferencia; global cuando el dato lo permite y priorizas capacidad, costo y disponibilidad, porque un despliegue global puede procesar en cualquier región del proveedor.

### Capítulo 3 · AI gateways

1. **Tres cosas que hace un AI gateway y un API gateway clásico no.** Cualquiera de estas: **cuenta tokens** en lugar de peticiones, procesa **streaming** SSE, inspecciona **significado** con clasificadores (inyección, datos personales), entiende **MCP y A2A**, hace **caché semántica** y traduce entre formatos de **distintos proveedores**.
2. **Por qué la caché semántica puede filtrar datos.** Porque devuelve una respuesta guardada a una pregunta **parecida**, sin mirar quién la hizo: si la respuesta original se generó con datos que solo veía otro usuario, el segundo usuario los recibe. Se evita **particionando la caché por consumidor** (`vary-by`) o no usándola en RAG con permisos.
3. **Gateway de aplicaciones frente a acceso de usuarios a IA pública.** El primero controla el tráfico que generan **tus apps y agentes** hacia modelos y herramientas (en Microsoft, **API Management**). El segundo controla lo que **tus empleados** usan en servicios públicos de IA (en Microsoft, **Entra Internet Access, Defender for Cloud Apps, Edge for Business y Purview Endpoint DLP**).

### Capítulo 4 · Amenazas

1. **Trifecta letal con EchoLeak.** Copilot tenía **datos privados** (correo, OneDrive, Teams), leía **contenido no confiable** (un correo del atacante con instrucciones ocultas) y tenía un **canal de salida** (una URL que se cargaba al mostrar la respuesta). Con las tres juntas, el atacante sacó datos sin que la víctima hiciera clic.
2. **LLM06 frente a ASI02.** LLM06 (agencia excesiva) es un problema de **diseño**: el agente tiene más herramientas, permisos o autonomía de los que necesita. ASI02 (mal uso de herramientas) es el agente usando mal **herramientas que sí debía tener**, por inyección o por instrucciones ambiguas. El primero se arregla quitando; el segundo, acotando parámetros, validando y pidiendo aprobación.
3. **Agente de tickets, base de clientes y correo.** Cumple **las tres** propiedades: entrada no confiable (tickets), datos sensibles (base de clientes) y acción hacia afuera (correo). Cambios posibles: que el correo solo vaya al cliente dueño del ticket y con plantilla, o con **aprobación humana**; o separar en dos agentes, uno que lee tickets sin acceso a la base y otro que consulta la base sin leer texto libre.

## Capítulos 5 a 8

### Capítulo 5 · Controles y diseño seguro

1. **Plan-Then-Execute: acciones sí, parámetros no.** El plan (qué herramientas y en qué orden) se fija **antes** de leer contenido no confiable, así que ese contenido no puede agregar acciones. Pero los **valores** que usan esas acciones (destinatario, monto, texto) pueden salir de los datos leídos, y ahí una inyección todavía puede influir. Por eso se combina con validación de parámetros y listas permitidas.
2. **Asistente de correo con Dual LLM.** El **modelo privilegiado** ve la petición del usuario y tiene las herramientas, pero nunca ve el texto de los correos; trabaja con referencias como `$CORREO_1`. El **modelo en cuarentena** lee los correos y devuelve resultados acotados (un resumen, una fecha) guardados como variables. El código, no el modelo privilegiado, sustituye las variables al mostrar o enviar.
3. **Canal de EchoLeak y ForcedLeak.** Ambos sacaron datos por **URLs** que el cliente cargaba: imágenes o enlaces con los datos en la URL, hacia un dominio que el sistema consideraba de confianza (en ForcedLeak, uno permitido que había expirado). Se cierra **bloqueando imágenes y enlaces a dominios no aprobados**, reescribiendo URLs con parámetros, con CSP estricta y revisando las listas de dominios permitidos.

### Capítulo 6 · Identidad

1. **Permisos de aplicación frente a delegados.** Los delegados están limitados por **lo que el usuario puede ver**; los de aplicación valen para **todo el tenant** (por ejemplo, todos los buzones con `Mail.Read`). Un agente engañado con permisos de aplicación puede alcanzar datos de cualquier persona.
2. **Sponsor frente a owner.** El **sponsor** es el responsable de negocio, obligatorio: decide el ciclo de vida, responde en revisiones e incidentes y no administra la parte técnica. El **owner** es el administrador técnico, opcional: configuración y credenciales.
3. **Qué resuelve Enterprise-Managed Authorization.** Resuelve **quién puede conectar qué servidor MCP**, decidido por el IdP corporativo con política, auditoría y revocación, sin que cada usuario dé consentimiento. **No resuelve qué hace el agente** con ese acceso: la inyección de prompts y el abuso de herramientas siguen siendo posibles.

### Capítulo 7 · Protección de datos

1. **Por qué la remediación de permisos rinde más.** Porque Copilot solo ve lo que el usuario ya puede ver: **el oversharing es la causa raíz** y corrigiéndolo se elimina el riesgo para Copilot, agentes, búsqueda y cualquier IA futura. DLP y etiquetas son capas encima; sin permisos correctos, bloquean demasiado o dejan pasar.
2. **RCD frente a RSS.** **Restricted Content Discovery** se aplica **por sitio** y oculta ese sitio a la búsqueda de Copilot y de toda la organización, sin cambiar permisos: es un control duradero para sitios sensibles. **Restricted SharePoint Search** limita la búsqueda a una **lista de hasta 100 sitios permitidos**: es una medida temporal mientras remedias.
3. **RAG sobre SharePoint con permisos.** Las ACL (IDs de grupos de Entra con acceso a cada documento) se guardan **en el índice**, en un campo filtrable de cada fragmento, y se actualizan cuando cambian los permisos. La consulta se hace con la **identidad del usuario**: sus grupos salen de su token o de Microsoft Graph, y el filtro lo aplica el código antes de pasar nada al modelo.

### Capítulo 8 · MCP y A2A

1. **Rug pull y su control.** Un servidor MCP aprobado **cambia sus definiciones o su código después** de la aprobación (en una versión nueva o en plena sesión). Lo detecta la **huella de las definiciones** aprobadas comparada en cada listado de herramientas, junto con versiones fijadas (Lab 4).
2. **Por qué un servidor `stdio` es peligroso.** Porque corre como un proceso **con todos los permisos del usuario**: puede leer archivos, claves y configuraciones, y salir a internet, sin pasar por ningún gateway. Por eso se ejecuta en contenedor y se distribuye por MDM (Lab 16).
3. **Por qué la respuesta de un socio por A2A es no confiable.** Porque el agente remoto **razona por su cuenta** y procesa contenido que tú no controlas: puede estar comprometido, haber sido inyectado o simplemente equivocarse. Su respuesta debe validarse por esquema y reglas de negocio, nunca ejecutarse como instrucción.

## Capítulos 9 a 13

### Capítulo 9 · Stack de Microsoft

1. **Qué agentes existen y quién responde.** El **registro de Agent 365** como inventario único (incluye agentes de Copilot Studio, Foundry, terceros y los no registrados); **Entra Agent ID** para ver la identidad de cada agente con su **sponsor** y owner; y el centro de administración de **Power Platform** para el detalle de los agentes low-code. El AI-SPM de Defender for Cloud complementa con los agentes y modelos desplegados en Azure.
2. **Conexiones con credenciales del creador.** Porque **cualquiera que use el agente actúa con los permisos de quien lo creó**: si el creador ve finanzas, todos los usuarios del agente ven finanzas a través de él. Se corrige exigiendo autenticación del usuario final en las conexiones de agentes compartidos.
3. **AI-SPM frente a protección contra amenazas de IA.** **AI-SPM** (Defender CSPM) es **postura**: descubre cargas de IA, inventario, configuraciones débiles y rutas de ataque, antes de que pase algo. La **protección contra amenazas** es **tiempo de ejecución**: alertas cuando alguien intenta un jailbreak, filtra datos o abusa del modelo.

### Capítulo 10 · Gobierno

1. **Agente que preselecciona CV en España.** La empresa es **provider** (desarrolló el sistema y lo puso en servicio con su nombre) y también **deployer** (lo usa). La selección de personal es **alto riesgo del Anexo III**, y tras el Digital Omnibus esas obligaciones aplican desde el **2 de diciembre de 2027**. Hoy ya aplican las prohibiciones y la alfabetización en IA; además, el RGPD y la normativa laboral rigen desde ya.
2. **Marcos para certificarse y para el directorio.** Para certificarte, **ISO/IEC 42001** (sistema de gestión certificable). Para hablar de riesgo con el directorio, el lenguaje del **NIST AI RMF** (Govern, Map, Measure, Manage), apoyado en OWASP y MITRE ATLAS para el detalle técnico.
3. **Campos mínimos del inventario de agentes.** Dueño y sponsor, propósito, **modelos y versiones**, fuentes de datos, **herramientas y permisos**, identidad del agente, **nivel de riesgo**, evaluaciones y sus resultados, aprobaciones, número de usuarios y terceros involucrados.

### Capítulo 11 · Operaciones de seguridad

1. **Por qué registrar la versión del prompt de sistema.** Porque el comportamiento del agente depende de sus instrucciones: sin la versión **no puedes reproducir** el incidente ni saber si el agente actuó “según diseño” o por una inyección, ni si un cambio de prompt introdujo el problema.
2. **Detección de herramienta nunca usada.** Construir la **línea base** de pares agente y herramienta de los últimos 30 días (excluyendo el último), y alertar con los pares del último día que **no aparecen** en esa base (`join kind=leftanti`), agregando el número de llamadas y la primera aparición. Es la consulta 2 de MCP a fondo.
3. **Primero ante LLMjacking.** **Contener el acceso**: rotar o revocar las claves, deshabilitar la autenticación local y bloquear las IPs, porque cada minuto que pasa el atacante consume tu presupuesto y puede usar tus modelos para otros fines. Después, buscar despliegues o recursos que haya creado.

### Capítulo 12 · Casos de uso

1. **Aplicar las seis preguntas a un escenario.** No hay una respuesta única. Una buena respuesta nombra el **contenido no confiable** concreto, los **datos sensibles** concretos, las **acciones y canales de salida**, en nombre de quién actúa, qué es irreversible y quién es el **dueño**, y termina con al menos un cambio de diseño.
2. **Por qué el ID del cliente no debe salir del modelo.** Porque el modelo puede ser manipulado para pedir **otro ID** y la API entregaría datos de otro cliente: es una **vulnerabilidad de autorización a nivel de objeto (BOLA)** a través del LLM. El ID debe salir del **token de sesión** autenticado.
3. **Tres primeros controles para agentes de código.** Una respuesta sólida: **configuración gestionada** centralmente (permisos de comandos y lista permitida de servidores MCP), porque cubre a todos los desarrolladores de una vez; **sin secretos de producción** en las estaciones, porque es lo que un agente engañado o un malware buscaría; y **revisión humana obligatoria** de los pull requests de agentes, porque es la última barrera antes de producción.

### Capítulo 13 · Roadmap y madurez

1. **Por qué visibilidad antes que controles.** Porque **no puedes proteger lo que no sabes que existe**: sin inventario de apps, agentes y shadow AI, los controles cubren solo lo conocido y el riesgo real sigue fuera. Además, la visibilidad indica dónde poner primero el esfuerzo.
2. **Dimensión más débil.** Respuesta personal. En la mayoría de las empresas que empiezan, las más débiles son **identidad** (API keys compartidas) e **inventario** (no se sabe qué agentes existen).
3. **Tres métricas para el directorio.** Por ejemplo: **porcentaje de agentes con dueño e identidad propia** (gobierno), **porcentaje del tráfico a modelos que pasa por el gateway** (cobertura de controles) y **tiempo de detección y respuesta a incidentes de IA** (capacidad operativa). Son pocas, comparables en el tiempo y conectan con riesgo de negocio.

## MCP a fondo y A2A a fondo

### MCP a fondo

1. **Por qué el modelo sin estado facilita la política en el gateway.** Porque **cada petición es autosuficiente**: lleva su versión, capacidades y token, así que el gateway puede autorizar, enrutar y registrar petición por petición sin seguir sesiones, y no hay identificador de sesión que secuestrar. También escala mejor detrás de un balanceador.
2. **Valida la firma pero no la audiencia.** Permite que **cualquier token válido de tu tenant**, emitido para otra API (por ejemplo, Microsoft Graph), abra el servidor: reutilización de tokens y token passthrough. Un atacante que roba un token de otra app, o un servidor malicioso que recibe tokens, puede usarlos contra este (Lab 15, paso 5).
3. **Por qué no basta la coincidencia por nombre.** Porque un usuario puede **editar su archivo de configuración** y registrar otro servidor con el mismo nombre o apuntar el nombre aprobado a otra URL; GitHub lo documenta como limitación. La aplicación estricta usa **URLs** en la configuración gestionada y el **gateway** como control en red.
4. **Azure MCP Server con cuenta de administrador.** Riesgo **crítico**: el agente puede hacer en Azure todo lo que tu cuenta de administrador puede, y una inyección lo convierte en un operador hostil. Se baja usando una **identidad de mínimo privilegio** (lectura donde baste), modo de solo lectura si está disponible, un entorno separado y aprobación humana para acciones de escritura: con eso queda en medio o alto.
5. **Campos para demostrar un rug pull.** El **servidor y su versión**, la **huella de las definiciones** en cada `tools/list` y la **marca de tiempo**: muestran que la huella cambió respecto de la aprobada y cuándo. Las llamadas posteriores a herramientas nuevas completan la evidencia.

### A2A a fondo

1. **Por qué una Agent Card firmada no basta.** Porque la firma prueba **integridad** (no cambió desde que la firmó quien tiene la clave), no **confianza**: un socio comprometido puede firmar una tarjeta con instrucciones, y el `kid` no dice quién eres. Hacen falta clave fijada por un canal fuera de banda y **contenido aprobado** (Lab 18, caso 4).
2. **Session smuggling frente a inyección indirecta.** La inyección indirecta llega en **un contenido** (un documento, una web) que el agente lee una vez. En session smuggling, un **agente malicioso aprovecha una conversación de varios turnos** con tu agente para ir colando instrucciones de forma encubierta y adaptativa, aprovechando el contexto acumulado. Se mitiga limitando turnos y aislando el contexto por tarea.
3. **Contrato de “cotizar envío”.** Sale lo mínimo: origen y destino a nivel de código postal o ciudad, peso, dimensiones y fecha deseada; **sin nombres, correos ni historial**. Vuelve un esquema cerrado, por ejemplo `{precio: número > 0, moneda: código ISO, plazo_dias: entero, valido_hasta: fecha}`, sin texto libre que se pase al modelo como instrucción; cualquier campo extra o valor fuera de rango se rechaza.
4. **Dónde va el kill switch.** En **API Management**, como política o producto por socio: deshabilitar la suscripción o el backend del socio corta todo el tráfico A2A con él en ambos sentidos, sin tocar a los agentes. Se complementa revocando sus credenciales en Entra.
5. **Por qué el agente externo no debe pagar.** Porque es el agente **más expuesto** a contenido y agentes no confiables: si tiene acceso directo a pagos, una inyección o un socio comprometido puede mover dinero. Separar el pago en un **agente interno** con reglas propias y aprobación humana aplica la regla de dos y la segregación de funciones.

### Ataques con IA

1. **Por qué buscar faltas de ortografía ya no protege.** Porque un LLM escribe **sin errores, en el idioma local y personalizado** para cada víctima; Microsoft midió 54 % de clics frente a 12 %. El control que toma su lugar es **MFA resistente a phishing**: aunque el usuario entregue la contraseña, sin su llave o passkey no sirve. Se complementa con detección por comportamiento e infraestructura, no por el texto.
2. **La videollamada del CFO.** La frena un **proceso que no depende de reconocer caras ni voces**: devolver la llamada a un número del directorio, doble aprobación sobre un umbral y prohibición de cambiar cuentas bancarias por chat, correo o video. La urgencia y la confidencialidad son, en sí mismas, señales para activar ese proceso.
3. **LLMjacking.** Tres medidas: **sin claves** (Entra ID, identidades administradas y `disableLocalAuth`), **todo por el gateway** con límites de tokens por consumidor, y **escaneo de secretos** más presupuestos con alertas. Señales: operaciones `ListKeys` inesperadas, un pico de tokens, despliegues nuevos de modelos hechos por una identidad que no es tu pipeline, o un ajuste de diagnóstico borrado.

### Residencia y LatAm

1. **Despliegue para datos de clientes desde México.** Un despliegue **Regional** (hoy, con modelos de Azure OpenAI, solo en Brazil South dentro de la región) o **Data Zone US** si aceptas Estados Unidos como destino; nunca Global para datos personales sin que la DPIA lo acepte. No basta con la región del recurso porque **la región fija dónde se guardan los datos, pero el tipo de despliegue fija dónde se procesa la inferencia**: un despliegue Global en un recurso de Mexico Central puede procesar en cualquier país.
2. **Advanced Data Residency.** Resuelve el **almacenamiento en el país** de las interacciones y otros datos cubiertos cuando la geografía predeterminada del tenant es Brasil, Chile o México. **No resuelve el procesamiento**, que ocurre fuera de la región porque ningún país latinoamericano está entre los 15 con procesamiento local de Copilot; tampoco cubre la búsqueda web en Bing, los conectores o agentes de terceros, ni el oversharing.
3. **Filas propias de IA.** La **4, flujo y residencia**, porque el procesamiento puede ocurrir en otro país según el tipo de despliegue. La **7, retención**, porque aparecen copias nuevas: trazas, memoria de agentes, índices y el monitoreo de abuso. La **8, entrenamiento**, porque un ajuste fino deja el dato dentro del modelo. La **9, decisiones automatizadas**, porque una salida que decide sobre una persona activa derechos de revisión y explicación.

### Memoria y extensibilidad

1. **Confirmación contra el botón “Resumir con IA”.** El prompt precargado llega como turno del usuario, así que **la procedencia sola no lo detecta**. La confirmación obliga a que el agente muestre “¿quieres que recuerde que Relecloud es una fuente confiable?” y espere un sí explícito: el usuario, que solo pidió un resumen, ve la intención oculta y la rechaza (Lab 20, escenario 2).
2. **Conector que expone tickets de recursos humanos.** Fallaron las **ACL**: el conector sincronizado indexó el contenido sin mapear los permisos del sistema de origen, o los mapeó a “todos”. Se prueba antes de activarlo **buscando con un usuario que no tiene acceso en el origen**: si Copilot le muestra algo, el conector no se activa.
3. **Declarativo frente a motor propio.** En el declarativo, **Microsoft pone el orquestador, los modelos y sus protecciones** (filtros de inyección, separación de contenido) y tú respondes por instrucciones, conocimiento y acciones. En el de motor propio **todo eso queda de tu lado**: guardrails, defensa contra inyección, registro e identidad, como en cualquier app de IA de los capítulos 3 a 6.

### Agentes con Entra

1. Cuando conversa con alguien, el agente actúa **en nombre del usuario** (OBO): la app cliente obtiene un token del usuario cuya audiencia es el blueprint, el agente lo canjea por un token para la API de pedidos y pide un permiso **delegado** como `Pedidos.Read`; la API solo devuelve los pedidos de ese usuario. La conciliación nocturna es **autónoma**: token de aplicación con un rol de aplicación como `Pedidos.Read.All` asignado a la identidad del agente, sin usuario. Si el agente necesitara buzón, licencia o pertenecer a grupos, usaría un agent user.
2. La identidad de agente es un service principal especial al que Entra no le deja agregar secretos ni certificados: así no hay miles de credenciales sueltas, una por agente. La credencial vive en el **blueprint**, idealmente como credencial federada con una identidad administrada (o un certificado en Key Vault). El blueprint obtiene un primer token y la identidad del agente lo usa como `client_assertion`. Rotas o revocas en un solo lugar y todos los agentes del blueprint quedan cubiertos.
3. Un agente no puede hacer MFA: no hay flujo interactivo ni página de inicio de sesión. Lo que sí puedes hacer: políticas de Conditional Access para agentes que **bloquean** (agentes de riesgo alto, agentes fuera de la lista aprobada), permisos mínimos en cada API, un sponsor responsable y revisiones de acceso, y monitoreo de los inicios de sesión del agente en Sentinel (por ejemplo, la regla AI-009 del paquete de detecciones). Cuando el agente actúa por un usuario, el MFA lo hizo ese usuario al iniciar sesión en la app cliente.
4. Primero la **audiencia** del token del usuario: decodifícalo y mira `aud`. Debe ser el ID o el URI del blueprint; si es Graph o la API final, la app cliente pidió el scope equivocado. Luego revisa que el token sea del mismo tenant (las identidades de agente son single-tenant), que no haya expirado y que el canje use `requested_token_use=on_behalf_of`.

### Defender para IA

1. MDE muestra el agente en Assets > AI agents > Local agents con **auto-aprobación activa** y el MCP local con su comando de inicio; con MDE P2 ves inventario y hunting, y con E7 o Agent 365 más P2 también el nivel de riesgo y las recomendaciones. Tres acciones: quitar la auto-aprobación y sacar las credenciales de producción del equipo (acceso de solo lectura, con identidad propia y a través de un gateway); activar la protección en tiempo de ejecución en Audit y luego Block, porque Claude Code está en la matriz de inspección nativa; y vigilarlo con la consulta de agentes que auto-aprueban.
2. Cualquiera de estas: el bloqueo todavía no llegó (puede tardar **hasta 3 horas**); network protection está en audit y no en block, o el equipo no tiene el perfil con alcance; Chrome usa **QUIC o Encrypted Client Hello** y network protection no ve el nombre del sitio; la app usa dominios que no están en el catálogo.
3. La aplicación debe enviar **`user_security_context`** en cada llamada a Azure OpenAI con el object ID de Entra del usuario, su IP y el nombre de la app. El cambio es en el código de la aplicación (o en el gateway que llama al modelo), no en Defender. Después, verifica con una alerta de prueba que el usuario aparece, porque un campo mal escrito no da error.
4. Le falta **Agent 365** (o Microsoft 365 E7). Desde el 1 de julio de 2026 el descubrimiento, la postura, la detección de amenazas y la protección en tiempo real de agentes de Copilot Studio y Foundry dejaron de estar en las licencias de MDA y del plan Defender for AI Services y pasaron a Agent 365. Además, en Foundry solo se protegen los agentes publicados.
5. MDE sabe qué proceso se conectó, a qué sitio, desde qué equipo y con qué cuenta, y puede bloquear el sitio. **No sabe qué se escribió** porque el tráfico va cifrado. Completan la visibilidad MDA (qué apps, cuánto uso, riesgo), Purview con DLP de endpoint, la extensión del navegador y la protección de Edge (contenido sensible en prompts y subidas), y Global Secure Access (prompt completo con inspección TLS, en preview).

### Purview para IA

1. Falló el **oversharing**: Copilot usó un archivo al que el usuario ya tenía acceso, probablemente por un enlace amplio o un sitio mal permisado. Copilot respetó los permisos; los permisos estaban mal. Esta semana: RCD en el sitio de recursos humanos y revisar sus enlaces con los informes de SAM. En el mes: evaluación de oversharing de DSPM, limpieza de permisos, etiqueta por defecto en la biblioteca y DLP de Copilot que excluya esa etiqueta.
2. Equipo corporativo: incorporarlo a Purview, la **extensión de Purview para Chrome** y una regla de DLP de equipo con un grupo de dominios de IA para auditar y luego bloquear el pegado y la subida, con E5. Si el equipo es personal, ni la extensión ni Edge for Business aplican: la única vía es la **red** (Global Secure Access con inspección TLS) o bloquear la app y ofrecer la empresarial.
3. El agente debe consultar a Purview con el **contexto del usuario**: usar el middleware de Purview de Agent Framework (preview) o llamar a `processContent` con el usuario como sujeto antes de enviar el prompt y antes de mostrar la respuesta. Si solo llama con su identidad administrada, Purview solo audita. Requiere E5, pago por uso y la app registrada con Content.Process.User.
4. La **exclusión por DLP** impide que Copilot use el contenido del archivo aunque el usuario tenga acceso, en cualquier sitio donde esté. **RCD** saca el sitio entero de la búsqueda y de Copilot, pero no cambia permisos y no viaja con el archivo si alguien lo copia a otro lado.
5. Las políticas antiguas de retención de chats de Teams que también cubrían Copilot **pasan a ser solo de Teams** (RM-571306). El cliente tiene que crear políticas nuevas en la ubicación “Microsoft Copilot experiences”, y en las de apps de IA empresariales y otras apps si las usa.

### Visibilidad de agentes

1. Porque todo se une por la identidad: sin Agent ID sus inicios de sesión no tienen tipo de agente, ID Protection no le calcula riesgo de agente, Defender y Purview no lo ven como agente y el registro no lo tiene. Cambias tres cosas: le das **identidad de Agent ID** (migrando la app registration), haces pasar sus llamadas por el **gateway** con el ID del agente y del usuario en cada log, y lo **instrumentas** con el Agent 365 SDK o, como mínimo, llamas a la API de Purview.
2. El campo **`autoApprove = true`** del agente local (y el MCP local con acceso a secretos). Con eso podías quitar la auto-aprobación y activar la protección en tiempo de ejecución antes de que llegara el issue.
3. Al **usuario**. En el flujo en nombre del usuario, el problema es la sesión robada, no el agente; atribuirlo al usuario permite remediar esa sesión sin cortar el agente para todos los demás.
4. Falta la **política de Conditional Access** que bloquea agentes de riesgo alto: confirmar el compromiso sube el riesgo, pero sin política nadie lo aplica. Mientras tanto, deshabilita la identidad del agente desde el mismo informe.
5. El **ID del agente** (su identidad de Agent ID) y el **ID del usuario** por quien actúa, si hay uno. Con ese par unes los inicios de sesión de Entra, `AgentsInfo` y las alertas de Defender, la auditoría de Purview y tus propios logs.

### Landing zone de IA

1. Que no lo cree. El Cloud Adoption Framework dice que **la IA no necesita otra landing zone ni otro modelo de gobierno**: la IA interna va bajo Corp y la expuesta bajo Online, con las políticas base de la plataforma más una iniciativa de IA asignada en esos management groups. Un management group “IA” duplica políticas y rompe la herencia de los controles de red y de identidad que ya existen.
2. No. **Deny solo frena lo nuevo o lo que se modifica**; los despliegues que ya existían siguen ahí y aparecen como no conformes. Se remedian a mano: se elimina el despliegue o se agrega el modelo a la lista si fue aprobado.
3. Validar que cada conversación pertenece al usuario (en el código de la app), restringir el portal de Foundry y crear proyectos solo por pipeline (en RBAC y en el proceso de despliegue), y separar proyectos por patrón de acceso porque los agentes de prompt comparten la identidad del proyecto (en el diseño). También las reglas de salida del firewall y las políticas del gateway.
4. Porque los private endpoints controlan **cómo se entra** a los servicios, y los agentes generan tráfico **de salida** hacia herramientas e Internet que hay que filtrar con un firewall y una lista de dominios. La excepción es la herramienta de **búsqueda web**, que no pasa por la subred de salida de los agentes.
5. El informe de cumplimiento de la política de acceso por clave deshabilitado (`71ef260a` para AI Services y `6300012e` para AI Search) en el management group, con cero recursos no conformes, y la política en Deny para que no aparezcan nuevos.

### Marcos y cómo aplicarlos

1. Con cuatro decisiones: **qué regulación aplica** (lo obligatorio), **qué sistema de gestión** adopta (ISO/IEC 42001 o NIST AI RMF), **qué catálogo de controles técnicos** usa (MCSB v2 en Azure y Zero Trust para IA en el tenant) y **qué modelo de amenazas** guía el diseño y las pruebas (OWASP y MITRE ATLAS). Todo lo demás se mapea a esas cuatro piezas.
2. Dice cuántos recursos cumplen las políticas asignadas. Para IA solo mide **AI-1** (cinco políticas en preview); las recomendaciones de filtrado, meta-prompts, privilegio de agentes, aprobación humana, monitoreo y red teaming no tienen políticas y requieren evidencia de diseño y proceso.
3. La **Zero Trust Assessment** (`Invoke-ZtAssessment`), que desde 2026 incluye el pilar de IA. Después entregas el plan priorizado con las tareas del pilar de IA del **Zero Trust Workshop**, agrupadas por identidad, datos, plataforma, pruebas y SOC.
4. OWASP: **LLM01** (inyección indirecta) y **LLM06** o **ASI02** (agencia excesiva, mal uso de herramientas). MCSB v2: **AI-2** (filtrado en capas), **AI-4** (mínimo privilegio) y **AI-5** (aprobación humana). Con Microsoft: Prompt Shields con spotlighting en el guardrail del agente y aprobación humana para la herramienta de borrado, más permisos de solo lectura por defecto.
5. En el **nivel 2**: los agentes están identificados en Entra, pero usan secretos y no son identidades de agente. Para subir al nivel 3 necesita migrarlos a **Agent ID** con credenciales federadas en el blueprint, sin secretos, y con dueño y sponsor registrados.

### Proyectos de cliente

1. Una **línea base medida**: Zero Trust Assessment con el pilar de IA, informe de shadow AI de Defender for Cloud Apps, evaluación de oversharing de DSPM y cumplimiento de las políticas de IA en Azure. Sin ella no puedes demostrar avance ni priorizar con datos.
2. Que los agentes creados antes del 18 de marzo de 2026 usan **service principals que Entra trata como apps comunes**, así que Conditional Access para agentes no les aplica. **No hay migración automática**: el plan es recrear cada agente con la integración de Agent ID activada, validarlo en paralelo y retirar el viejo, empezando por los de mayor riesgo.
3. Por ejemplo: un usuario sin acceso a un documento en el origen no obtiene su contenido en la respuesta (probado con dos usuarios reales); y un documento con instrucciones ocultas no cambia el comportamiento del agente (probado con un conjunto de documentos de inyección).
4. Porque **sin una alternativa aprobada** el uso no desaparece: se muda a teléfonos y equipos personales, donde no hay visibilidad. El proyecto tiene que ofrecer Copilot Chat u otra opción empresarial, comunicarla y proteger el contenido con Purview.
5. Disparar cada regla de IA con su evento de prueba, ver el incidente con el agente como entidad unido al usuario, y **deshabilitar la identidad de un agente comprometido** dentro del tiempo acordado (por ejemplo, 15 minutos), con la evidencia retenida.

### Kit del consultor

1. **Un punto.** Existe de manera informal, pero la evidencia no sirve: una planilla vieja no refleja los agentes de hoy. Para llegar a 3 necesita un inventario actual con dueño, por ejemplo una exportación del registro de Agent 365 o de DSPM.
2. Identidad: parte entera de 1,5 más uno, **nivel 2 (Visible)**. Plataforma: parte entera de 3,25 más uno, **nivel 4 (Gestionado)**. A la dirección: “la plataforma está bien construida, pero no sabemos qué hace cada agente ni podemos frenarlo por identidad; ahí está el riesgo”.
3. Corregir la **retención de Copilot** (las políticas de Teams dejaron de cubrirlo), poner **RCD en los sitios críticos** mientras se mide el oversharing y activar la **DLP de Copilot en simulación**. Las tres reducen riesgo o dan visibilidad sin depender de decisiones del negocio.
4. Microsoft protege el servicio, pero el cliente decide la **salida a Internet** de los agentes (la búsqueda web ni siquiera pasa por la subred de salida) y **quién ve cada conversación** (Agent Service no autoriza por usuario, la app tiene que validarlo). También la identidad de cada agente y las pruebas adversarias.
5. **Agent 365** para los usuarios que crean o patrocinan esos agentes, pero Agent 365 no se puede asignar a usuarios con E3 y Copilot solamente: necesita **E5**, o E3 más **Defender Suite y Purview Suite**. La alternativa que lo incluye todo es **Microsoft 365 E7**.
