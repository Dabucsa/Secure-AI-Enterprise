# Defensa frente a ataques con IA

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 17, 2026 · Danilo Bustamante

Los atacantes usan IA sobre todo para hacer **más rápido, más barato y en paralelo lo que ya funcionaba**: phishing, suplantación, robo de credenciales y explotación de fallas conocidas. El informe de Anthropic de septiembre de 2026 lo dice sin rodeos: ninguna de las operaciones que interrumpió dependía de una técnica nueva. Lo que cambió es la economía, con brechas completas en dos a tres horas y un solo operador atendiendo decenas de víctimas a la vez.

Por eso la defensa no es un producto “anti-IA”. Son los controles de siempre, aplicados sin excepciones y más rápido: MFA resistente a phishing, parches en días y no en semanas, procesos de verificación que no dependen de reconocer una voz o una cara, y respuesta automática. Hay un riesgo nuevo de verdad: **tus claves y tu capacidad de IA son ahora un botín**. El Microsoft Digital Defense Report 2026 lo resume en una cifra: en promedio, una carga de trabajo expuesta en la nube recibe su primer ataque a las **5,3 horas**.

Esta pestaña es la otra cara de los capítulos 4 y 5: allí la IA es el objetivo; aquí es el arma.

## 1. Panorama: seis ataques que la IA potencia

Cada fila tiene un caso documentado por una fuente primaria o por la prensa que la cubrió. La última columna es el control que más riesgo quita por peso invertido; las secciones siguientes lo detallan.

| Ataque | Qué aporta la IA | Caso documentado | Control que más rinde |
| --- | --- | --- | --- |
| Deepfakes de voz y video | Suplantar en tiempo real a un ejecutivo o a varios colegas | Arup, Hong Kong, 2024: unos 25,6 millones de dólares transferidos tras una videollamada con colegas falsos | Verificación fuera de banda y doble aprobación de pagos |
| Candidatos falsos | Fotos y documentos alterados, voz modificada y respuestas generadas durante el trabajo | Jasper Sleet, trabajadores TI de Corea del Norte (Microsoft, junio de 2025 y marzo de 2026) | Verificación de identidad al contratar y monitoreo como riesgo interno |
| Phishing escrito con LLM | Mensajes personalizados, sin errores y en el idioma local, a escala | 54 % de clics frente a 12 % en phishing tradicional (Microsoft Digital Defense Report 2025) | MFA resistente a phishing y detección por comportamiento |
| Malware que usa un LLM | Código que se reescribe o genera comandos mientras se ejecuta | PROMPTFLUX y PROMPTSTEAL (Google, noviembre de 2025); s1ngularity usó las CLI de IA de la víctima (agosto de 2025) | EDR en modo bloqueo y caza de procesos que llaman a APIs de LLM |
| Agentes atacantes | Reconocimiento, explotación y exfiltración en paralelo, con poca intervención humana | GTG-1002 (Anthropic, noviembre de 2025); de un token de desarrollador a administrador de la nube en unas tres horas (Anthropic, septiembre de 2026) | Parches rápidos, sin privilegios permanentes y contención automática |
| LLMjacking | Robar claves o capacidad de IA para revenderla o para atacar con ella | Storm-2139 contra Azure OpenAI (Microsoft, febrero de 2025); una clave robada usada tres semanas para atacar a terceros (Anthropic, septiembre de 2026) | Sin claves: Entra ID, `disableLocalAuth` y alertas de consumo |

## 2. Deepfakes y suplantación

Reconocer un deepfake a ojo ya no es un control confiable. Lo confiable es **un proceso que no dependa de reconocer una voz o una cara**. En el caso Arup, el empleado de finanzas sospechó del correo inicial, pero dejó de dudar cuando vio en la videollamada a varias personas que parecían y sonaban como sus colegas. Hizo 15 transferencias a cinco cuentas antes de confirmar con la casa matriz. El Microsoft Digital Defense Report 2026 suma otro dato: en el 93 % de los ataques de phishing por voz, la víctima siguió en la línea el tiempo suficiente para que empezara la manipulación.

| Escenario | Proceso que lo frena | Cómo lo apoyas en Microsoft |
| --- | --- | --- |
| Un “ejecutivo” pide un pago urgente o confidencial | Devolver la llamada a un número del directorio, nunca al que llamó; doble aprobación sobre un umbral; ningún cambio de cuenta bancaria pedido por chat, correo o video | Aprobaciones en el ERP; acceso externo de Teams restringido a dominios conocidos; Defender for Office 365 contra fraude de correo empresarial |
| La mesa de ayuda recibe un pedido de reset de MFA o contraseña | Nunca resetear solo por voz; verificación con documento y selfie en vivo, o aprobación del gerente directo; credencial temporal de un solo uso | Entra Verified ID con Face Check; Temporary Access Pass; Conditional Access que exige MFA resistente a phishing para registrar métodos nuevos |
| Contratación remota | Varias entrevistas con cámara encendida; documento sostenido frente a la cámara; referencias por teléfono o video; revisar que perfiles y portafolios sean únicos | Después del alta: Insider Risk Management, alertas de viaje imposible en ID Protection y bloqueo de herramientas de acceso remoto no aprobadas |

**Contratación: el caso de Corea del Norte.** Microsoft observó que los trabajadores TI de Jasper Sleet usan la herramienta Faceswap para poner sus caras en documentos robados, mejoran sus fotos con IA y prueban software para cambiar la voz. Una vez contratados, usan IA para responder preguntas técnicas y escribir código. Microsoft recomienda tratar el caso como riesgo interno y desconfiar de un candidato que nunca puede prender la cámara.

**Señales de deepfake, como apoyo y no como control.** Según Microsoft, los deepfakes de video fallan con movimientos rápidos, cuando algo tapa la cara, con cambios de luz y en la sincronía de labios y voz. Pedir al interlocutor que gire la cabeza o pase la mano frente a la cara ayuda, pero un proceso de verificación bien diseñado no debería necesitarlo.

**Para practicar:** agrega al simulacro del Lab 17 esta inyección. El “CFO” llama por Teams desde una cuenta externa y pide una transferencia urgente para cerrar una adquisición confidencial. ¿Quién la frena y en qué paso?

## 3. Phishing escrito con LLM

El phishing escrito con IA es más efectivo y no tiene los errores que enseñamos a buscar. Según el Microsoft Digital Defense Report 2025, los correos automatizados con IA lograron **54 % de clics frente a 12 %** del phishing tradicional, unas 4,5 veces más. El informe 2026 agrega que las personas siguen siendo la principal vía de entrada: detectó más de 46 millones de ataques de suplantación de contactos de negocio en 12 meses.

**Qué deja de funcionar:** filtrar por faltas de ortografía o redacción rara, y capacitar a la gente solo para detectarlas.

**Qué sigue funcionando:**

1. **MFA resistente a phishing** (passkeys, llaves FIDO2, Windows Hello for Business). Si la contraseña robada no sirve sin el dispositivo, el mejor correo del mundo pierde su premio.
2. **Bloquear el flujo de código de dispositivo** con Conditional Access, salvo excepciones registradas. El actor ruso que Anthropic llama GTG-20006 lo usó para robar tokens de Microsoft 365 en al menos ocho organizaciones.
3. **Detección por comportamiento, no por texto.** En agosto de 2025 Microsoft bloqueó una campaña que escondía su código en un archivo SVG disfrazado de PDF, probablemente generado con un LLM. No la delató el texto sino el contexto: correo enviado a sí mismo con destinatarios en copia oculta, un SVG con nombre de PDF y una redirección a un dominio de phishing conocido. El código generado por IA hasta dejó pistas propias, como nombres larguísimos y estructuras innecesarias.
4. **Configuración recomendada de Defender for Office 365:** Safe Links también para destinatarios internos, purga automática de correos ya entregados (ZAP) y simulaciones de ataque que incluyan Teams.
5. **Triage automático de los reportes de usuarios.** El Phishing Triage Agent de Security Copilot está disponible de forma general, trabaja sobre los correos que reportan los usuarios y requiere Defender for Office 365 Plan 2.

La regla práctica: cuenta con que el usuario va a hacer clic y diseña para que ese clic no alcance.

## 4. Malware y explotación asistidos por IA

La IA acorta el tiempo entre una falla conocida y su explotación, y quita valor a las firmas estáticas. Hay tres patrones documentados:

- **Malware que consulta un LLM mientras corre.** Google describió en noviembre de 2025 a PROMPTFLUX, un dropper en VBScript que le pide a la API de Gemini que reescriba su propio código, y a PROMPTSTEAL, atribuido a APT28, que consulta Qwen2.5-Coder por Hugging Face para generar comandos de Windows que roban documentos.
- **Malware que usa la IA que ya tienes instalada.** En agosto de 2025, versiones maliciosas del paquete Nx de npm (campaña s1ngularity) buscaron las CLI de Claude, Gemini y Amazon Q en las máquinas de desarrolladores. Las ejecutaron con banderas que saltan los permisos para que encontraran secretos; se filtraron miles de credenciales.
- **Malware que se rehace hasta pasar las defensas.** El actor GTG-20006, que Anthropic vincula con Midnight Blizzard, tenía agentes que vigilaban si un antivirus detectaba sus implantes. Si los detectaba, los modificaban y volvían a desplegar hasta que dejaban de ser detectados.

**Velocidad.** Anthropic documentó brechas completas en dos a tres horas y el paso de un token de desarrollador robado a control administrativo de la nube en unas tres horas. Un ciclo de parches de 30 días para sistemas expuestos ya no alcanza: apunta a días para las fallas críticas que se están explotando.

**Controles:**

1. EDR en modo bloqueo, con protección en la nube, reglas de reducción de superficie de ataque y protección de red en Defender for Endpoint. El comportamiento delata lo que la firma ya no ve.
2. Inventario de lo expuesto a internet (Defender Exposure Management o tu herramienta de superficie externa) y plazos de parche por criticidad.
3. Salida a internet controlada: solo las apps aprobadas, a través del gateway, deberían hablar con APIs de LLM. Cualquier otro proceso que lo haga es sospechoso.
4. Estaciones de desarrollo sin secretos de larga duración (Lab 9), CLI de IA sin modos que saltan permisos y `npm install --ignore-scripts` donde sea posible.

**Caza 1: procesos que hablan con APIs de LLM.** Para Defender XDR (en Sentinel usa `TimeGenerated` en lugar de `Timestamp`). Ajusta las listas a tu empresa.

```kql
let dominiosLLM = dynamic(["api.openai.com", "generativelanguage.googleapis.com",
    "api.anthropic.com", "api-inference.huggingface.co", "router.huggingface.co",
    "api.mistral.ai", "api.deepseek.com", "openrouter.ai"]);
let aprobados = dynamic(["msedge.exe", "chrome.exe", "firefox.exe", "code.exe", "ms-teams.exe"]);
let interpretes = dynamic(["wscript.exe", "cscript.exe", "mshta.exe", "rundll32.exe",
    "powershell.exe", "pwsh.exe", "python.exe", "node.exe"]);
DeviceNetworkEvents
| where Timestamp > ago(7d)
| where RemoteUrl has_any (dominiosLLM)
| where InitiatingProcessFileName !in~ (aprobados)
| extend Prioridad = iff(InitiatingProcessFileName in~ (interpretes), "Alta", "Revisar")
| summarize Conexiones = count(), Dominios = make_set(RemoteUrl, 10), Primera = min(Timestamp)
    by DeviceName, InitiatingProcessFileName, InitiatingProcessFolderPath, Prioridad
| order by Prioridad asc, Conexiones desc
```

**Caza 2: CLI de IA lanzadas sin permisos**, el patrón de s1ngularity.

```kql
DeviceProcessEvents
| where Timestamp > ago(30d)
| where ProcessCommandLine has_any ("--dangerously-skip-permissions", "--yolo", "--trust-all-tools")
| project Timestamp, DeviceName, AccountName, FileName, ProcessCommandLine,
    InitiatingProcessFileName, InitiatingProcessCommandLine
```

Un resultado de la caza 2 cuyo proceso padre es `node.exe` durante un `npm install` es casi seguro malicioso. Si sale un desarrollador lanzándola a mano, es una conversación sobre política de uso, no un incidente.

## 5. Agentes atacantes

Los agentes ofensivos ya se usan fuera de los laboratorios, aunque los humanos siguen eligiendo los objetivos. En noviembre de 2025 Anthropic describió GTG-1002, una campaña que atribuyó a un grupo patrocinado por el Estado chino. Atacó a unas 30 organizaciones con Claude Code y herramientas MCP, y la IA hizo cerca del 80 a 90 % del trabajo táctico. Para pasar las salvaguardas, los atacantes dividieron la operación en tareas pequeñas que parecían inocentes y la presentaron como una prueba defensiva.

En septiembre de 2026, Anthropic reportó que ese modelo de operación se extendió a todo tipo de actores, desde servicios estatales hasta individuos, ayudado por frameworks ofensivos públicos como PentAGI. Algunos casos del informe:

- Afiliados de ShinyHunters robaron más de 2.100 conjuntos de tokens de Azure AD de más de 40 tenants en unas 34 horas, con agentes haciendo casi todo el trabajo.
- GTG-20006 automatizó la renovación de tokens robados y registró dispositivos propios dentro de los tenants de sus víctimas para no perder el acceso.
- Un operador mantuvo una campaña de un mes usando solo claves de IA robadas.

Microsoft, en su artículo de marzo de 2026 sobre la IA como herramienta de los atacantes, ve el mismo giro pero con más cautela: hay experimentación con agentes, todavía no a gran escala.

| Lo que hace el agente atacante | Lo que haces tú | En Microsoft |
| --- | --- | --- |
| Opera en horas, no en semanas | Contención automática sin esperar a un analista: deshabilitar la cuenta, revocar sesiones, aislar el equipo | Disrupción automática de ataques en Defender XDR; playbooks de Sentinel |
| Prueba todo lo expuesto y no le importa lo raro de tu configuración | Inventario de superficie externa; la seguridad por oscuridad deja de servir | Defender Exposure Management |
| Busca tokens y claves en repositorios, apps móviles y contenedores | Escaneo de secretos con bloqueo al hacer push; nada de secretos de larga duración | GitHub secret scanning; identidades administradas (Lab 9) |
| Vive de tokens robados y registra dispositivos propios | Tokens atados al dispositivo, evaluación continua de acceso y alertas al registrar dispositivos | Token protection y CAE en Conditional Access; ID Protection |
| Rehace su malware hasta evadir firmas | Detecciones por comportamiento e identidad, no solo por indicadores | Defender for Endpoint; reglas analíticas por comportamiento en Sentinel |
| Genera más alertas de las que tu equipo puede revisar | IA también en tu SOC para el triage, con humanos en las decisiones | Agentes de Security Copilot (capítulo 9.7) |

**Un truco barato:** deja claves de API señuelo en lugares donde un agente las buscaría, como un repositorio interno o una variable de entorno de prueba, y alerta cuando alguien las use. Un humano casi nunca las tocaría; un agente que barre todo sí.

## 6. LLMjacking: tu IA como botín

LLMjacking es robar acceso a modelos de IA, casi siempre una clave de API o un token de sesión, para revenderlo o para atacar a otros con la cuenta de la víctima. Sysdig le puso nombre en mayo de 2024 y estimó que una cuenta abusada podía generar más de 46.000 dólares diarios de consumo; en septiembre de 2024 subió la estimación a más de 100.000 dólares diarios con los modelos más caros.

- **Storm-2139.** La Digital Crimes Unit de Microsoft demandó en diciembre de 2024, y nombró en febrero de 2025, a una red que tomaba credenciales de clientes publicadas en internet, entraba a Azure OpenAI y revendía el acceso para generar contenido prohibido.
- **Una cadena de suministro criminal.** Anthropic describe en septiembre de 2026 grupos cuyo único objetivo son las claves de IA: revendedores “con descuento” que en realidad roban credenciales, instaladores falsos que se hacen pasar por Claude Code e inyección de prompts contra despliegues de LiteLLM para sacar las claves de producción. Los atacantes que consiguen tus claves cambian sus propios ataques a tu cuenta, así que la factura y el rastro son tuyos.
- **Microsoft lo reconoce como amenaza:** el Digital Defense Report 2026 menciona explícitamente el robo de capacidad de cómputo de IA.

**Controles, del más al menos importante:**

1. **Sin claves.** Autenticación con Entra ID e identidades administradas, y `disableLocalAuth: true` en Azure OpenAI y Foundry (el Bicep del capítulo 2 lo hace).
2. **Todo el tráfico por el gateway**, con límites de tokens por consumidor (capítulo 3). Una clave robada del gateway tiene un techo; una del modelo, no.
3. **Presupuestos con alertas** por suscripción y por recurso de IA, y alertas de anomalía de costos.
4. **Escaneo de secretos** en repositorios, imágenes de contenedor y apps móviles; nunca claves en el frontend.
5. **Compra IA solo por canales autorizados.** Bloquea en el proxy los “intermediarios” y revendedores desconocidos.
6. **Detección:** la consulta de `ListKeys` y la de pico de tokens del capítulo 11, las alertas de Defender for AI Services y la caza de abajo.

**Caza 3: cambios que suelen preceder o esconder un LLMjacking.** Los atacantes habilitan modelos o despliegues nuevos y a veces apagan el registro, como describió Sysdig en 2024.

```kql
AzureActivity
| where TimeGenerated > ago(7d)
| where OperationNameValue has_any (
    "MICROSOFT.COGNITIVESERVICES/ACCOUNTS/DEPLOYMENTS/WRITE",
    "MICROSOFT.COGNITIVESERVICES/ACCOUNTS/WRITE",
    "MICROSOFT.INSIGHTS/DIAGNOSTICSETTINGS/DELETE")
| where ActivityStatusValue =~ "Success"
| summarize Operaciones = make_set(OperationNameValue), Recursos = make_set(_ResourceId, 20),
    Primera = min(TimeGenerated) by Caller, CallerIpAddress
| order by Primera desc
```

Compara `Caller` con tu lista de identidades de despliegue (pipelines, Bicep). Un usuario humano o una IP desconocida creando despliegues fuera de horario merece una llamada.

## 7. Plan de defensa priorizado

Si tienes que elegir, haz esto en este orden. Los cinco primeros quitan la mayor parte del riesgo y casi todos ya están en tus licencias.

- [ ] MFA resistente a phishing para todos, empezando por administradores y finanzas; bloquear el flujo de código de dispositivo y la autenticación heredada
- [ ] Verificación fuera de banda y doble aprobación para pagos, cambios de cuenta bancaria y resets en la mesa de ayuda
- [ ] Parches de sistemas expuestos en días, con inventario de la superficie externa
- [ ] Cero claves de IA: Entra ID, `disableLocalAuth`, escaneo de secretos y presupuestos con alertas
- [ ] EDR en modo bloqueo con protección en la nube, y salida hacia APIs de LLM solo por el gateway
- [ ] Contención automática: disrupción de ataques y playbooks que revocan sesiones sin esperar a un analista
- [ ] Contratación remota con verificación de identidad y monitoreo de riesgo interno
- [ ] Simulacros de phishing que incluyan Teams y la inyección de deepfake en el Lab 17
- [ ] Cazas 1 a 3 de esta pestaña programadas como reglas o búsquedas semanales

### Para repasar

1. ¿Por qué enseñar a detectar faltas de ortografía ya no protege contra el phishing, y qué control toma su lugar?
2. Un analista de finanzas recibe una videollamada del CFO pidiendo una transferencia urgente y confidencial. ¿Qué proceso debe frenarla aunque el video sea perfecto?
3. Nombra tres medidas que reducen el riesgo de LLMjacking en Azure OpenAI y una señal que te avisaría si igual ocurre.

## Fuentes

Las cinco primeras las leí completas; el resto son coberturas de prensa o del proveedor que documentó cada caso.

- [Anthropic: Detecting and countering misuse of AI, septiembre de 2026](https://www.anthropic.com/threat-intelligence-report-september-2026)
- [Microsoft Digital Defense Report 2026](https://www.microsoft.com/en-us/corporate-responsibility/topics/cybersecurity/reports/microsoft-digital-defense-report/)
- [Microsoft: AI as tradecraft, marzo de 2026](https://www.microsoft.com/en-us/security/blog/2026/03/06/ai-as-tradecraft-how-threat-actors-operationalize-ai/)
- [Microsoft: Jasper Sleet, junio de 2025](https://www.microsoft.com/en-us/security/blog/2025/06/30/jasper-sleet-north-korean-remote-it-workers-evolving-tactics-to-infiltrate-organizations/)
- [Microsoft: AI vs. AI, detecting an AI-obfuscated phishing campaign, septiembre de 2025](https://www.microsoft.com/en-us/security/blog/2025/09/24/ai-vs-ai-detecting-an-ai-obfuscated-phishing-campaign/)
- [The Register: cifra de 54 % del Digital Defense Report 2025](https://www.theregister.com/2025/10/16/ai_makes_phishing_45x_more_effective)
- [CNN vía ABC17: caso Arup](https://abc17news.com/money/cnn-business-consumer/2024/05/16/british-engineering-giant-arup-revealed-as-25-million-deepfake-scam-victim/)
- [Infosecurity Magazine: malware con IA según Google GTIG](https://www.infosecurity-magazine.com/news/aienabled-malware-actively/)
- [JFrog: ataque s1ngularity a Nx](https://research.jfrog.com/post/nx-supply-chain-attack-targets-ai-tool-users/)
- [MITRE ATT&CK: campaña C0062 (GTG-1002)](https://attack.mitre.org/campaigns/C0062/)
- [Sysdig: LLMjacking](https://www.sysdig.com/blog/llmjacking-stolen-cloud-credentials-used-in-new-ai-attack) y [actualización de costos](https://cyberinsider.com/llmjacking-attacks-escalate-driving-costs-to-over-100000-day/)
- [The Hacker News: Storm-2139](https://thehackernews.com/2025/02/microsoft-exposes-llmjacking.html)
- [Microsoft Identity: Face Check con Verified ID](https://devblogs.microsoft.com/identity/verified-id-face-check/)
- [Petri: Phishing Triage Agent](https://petri.com/microsoft-security-copilot-phishing-triage-agent/)
- [Microsoft Learn: alertas de Defender for Cloud para cargas de IA](https://learn.microsoft.com/azure/defender-for-cloud/alerts-ai-workloads)
