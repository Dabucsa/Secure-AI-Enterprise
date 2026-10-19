# Residencia de datos, Latinoamérica y DPIA

> Parte de la guía *IA Empresarial Segura 2026*. [Índice de la guía](README.md)

Oct 17, 2026 · Danilo Bustamante

Para una empresa latinoamericana, la pregunta clave no es solo **dónde se guardan** los datos de IA sino **dónde se procesan**. En Azure OpenAI y Foundry, los datos en reposo quedan en la geografía de tu recurso, pero un despliegue Global puede procesar el prompt en cualquier región. Además, no existe una zona de datos latinoamericana: hoy las zonas son Estados Unidos, la Unión Europea y Asia-Pacífico.

En Microsoft 365 Copilot pasa algo parecido. Brasil, Chile y México pueden guardar los datos en el país con Advanced Data Residency, pero ninguno de los 15 países con procesamiento local de Copilot anunciados por Microsoft es latinoamericano. Resultado: casi todo uso de IA desde la región implica un **flujo internacional de datos** que tu ley regula, y la herramienta para decidirlo y dejarlo documentado es una **evaluación de impacto (DPIA)**.

Esta pestaña es una guía de estudio, no asesoría legal. Los textos oficiales de las leyes no se pudieron abrir desde el entorno donde se escribió, y varias normas cambian en 2026.

## 1. Azure OpenAI y Foundry

El tipo de despliegue decide dónde corre la inferencia; la geografía del recurso decide dónde quedan los datos guardados. Microsoft documenta que los prompts y las respuestas no se usan para entrenar modelos, y que el monitoreo de abuso puede retenerlos hasta 30 días con revisión humana solo de lo marcado. Si no puedes aceptar esa retención, pide el monitoreo de abuso modificado, que requiere aprobación de Microsoft.

| Tipo de despliegue | Dónde se procesa la inferencia | Cuándo usarlo desde Latinoamérica |
| --- | --- | --- |
| Global (Standard, Provisioned, Batch) | En cualquier región de Foundry | Datos no personales o seudonimizados, o cuando tu DPIA aceptó la transferencia. Es el más barato y recibe primero los modelos nuevos |
| Data Zone (Standard, Provisioned) | Solo dentro de la zona: Estados Unidos, Unión Europea o Asia-Pacífico | Cuando tu regulador o tus contratos aceptan ese destino. Elegir “Data Zone US” deja un solo país de destino, lo que simplifica la DPIA |
| Regional (Standard, Provisioned) | Solo en la región del despliegue | Cuando necesitas procesar dentro de un país. En Latinoamérica, la tabla oficial solo muestra modelos de Azure OpenAI en Brazil South |

| Región de Azure | Ubicación | Estado | Modelos de Azure OpenAI con despliegue regional |
| --- | --- | --- | --- |
| Brazil South | São Paulo | Disponible, 3 zonas de disponibilidad | Sí: familias gpt-4.1, gpt-4o, gpt-5.1 y embeddings, según la tabla oficial |
| Mexico Central | Querétaro | Disponible desde 2024, 3 zonas | No aparece en la tabla oficial; confirma en el portal |
| Chile Central | Santiago | Disponible desde 2025, 3 zonas | No aparece en la tabla oficial; confirma en el portal |

**Patrón recomendado.** Clasifica cada carga por el dato que toca y enruta desde el AI gateway (capítulo 3): lo que lleva datos personales va a un despliegue Regional o Data Zone; el resto puede ir a Global. Después bloquea con Azure Policy los despliegues Global en las suscripciones con datos personales. Esta regla es un punto de partida; confirma el alias con `az provider show --namespace Microsoft.CognitiveServices --expand "resourceTypes/aliases"` antes de asignarla.

```json
{
  "if": {
    "allOf": [
      { "field": "type", "equals": "Microsoft.CognitiveServices/accounts/deployments" },
      { "field": "Microsoft.CognitiveServices/accounts/deployments/sku.name",
        "in": [ "GlobalStandard", "GlobalProvisionedManaged", "GlobalBatch" ] }
    ]
  },
  "then": { "effect": "deny" }
}
```

## 2. Microsoft 365 Copilot

En Copilot hay que separar tres cosas: dónde se guardan las interacciones, dónde se procesan y qué sale del límite de servicio de Microsoft 365.

| Pregunta | Respuesta para un tenant latinoamericano | Qué hacer |
| --- | --- | --- |
| ¿Dónde se guardan prompts y respuestas? | Con el complemento Advanced Data Residency, si la geografía predeterminada del tenant es Brasil, Chile o México, Microsoft se compromete a guardar en el país los datos cubiertos, incluido Microsoft 365 Copilot y Copilot Chat. Chile se sumó como geografía local en 2025 | Revisa la geografía predeterminada del tenant y si te conviene el complemento |
| ¿Dónde se procesan? | Microsoft anunció procesamiento de Copilot dentro del país para Australia, India, Japón y Reino Unido a fines de 2025, y para otros 11 países en 2026 (Canadá, Estados Unidos, Alemania, España, Italia, Polonia, Suecia, Suiza, Malasia, Sudáfrica y Emiratos Árabes Unidos). Ninguno es latinoamericano | Documenta el procesamiento fuera del país como flujo internacional en tu DPIA |
| ¿Qué sale del límite de Microsoft 365? | Las búsquedas web de Copilot van a Bing; los agentes y conectores de terceros, y los servidores MCP, procesan donde los aloja su proveedor; los modelos de terceros que habilites dentro de Copilot tienen sus propios términos | Desactiva la búsqueda web donde no la necesites y trata cada agente o conector externo como un encargado nuevo |

Lo que no cambia con la residencia: Copilot solo ve lo que el usuario ya puede ver. El riesgo más grande sigue siendo el oversharing (capítulo 7), y ninguna región lo arregla.

## 3. Leyes de datos personales en la región

Las leyes específicas de IA están en el capítulo 10. Esta tabla cubre las leyes de **datos personales**, que ya aplican hoy a cualquier uso de IA con datos de personas. Las tres preguntas que importan para IA son si puedes mandar los datos fuera del país, si debes hacer una evaluación de impacto y qué derechos tiene la persona frente a una decisión automatizada.

| País | Ley y autoridad | Flujos internacionales | Evaluación de impacto | Decisiones automatizadas |
| --- | --- | --- | --- | --- |
| Brasil | LGPD (Ley 13.709/2018); ANPD | Si usas cláusulas estándar, deben ser las de la ANPD (Resolución 19/2024) incorporadas sin cambios; el plazo de adecuación venció el 23 de agosto de 2025 | Informe de impacto (RIPD, artículo 38), exigible por la ANPD y esperado en tratamientos de alto riesgo | Derecho a pedir revisión (artículo 20); la ANPD lo está reglamentando en su agenda 2025-2026 |
| México | Nueva LFPDPPP (Diario Oficial del 20 de marzo de 2025); la Secretaría Anticorrupción y Buen Gobierno absorbió las funciones del INAI | Revisa en la ley nueva las reglas de transferencias y de envíos a encargados como Microsoft; tu aviso de privacidad debe reflejarlos | No es obligación general para empresas privadas | Derecho de oposición frente a tratamientos automatizados que afecten de forma significativa sin intervención humana |
| Chile | Ley 21.719, que entra en vigor el 1 de diciembre de 2026; un proyecto del Gobierno (boletín 18.623-07) busca postergarla un año; Agencia de Protección de Datos Personales | Con garantías adecuadas; la Agencia fijará los criterios y modelos | Contemplada para tratamientos de alto riesgo, como perfilamiento a gran escala | Derecho a no ser objeto de decisiones basadas únicamente en tratamiento automatizado, con derecho a explicación (artículo 8 bis). Multas de hasta 20.000 UTM |
| Colombia | Ley 1581 de 2012; Superintendencia de Industria y Comercio | A países con nivel adecuado según la SIC, o con contrato de transmisión cuando el destinatario es encargado | La Circular Externa 002 de 2024 pide un estudio de impacto de privacidad antes de diseñar o desarrollar IA con datos personales, sobre todo si son de alto riesgo | La misma circular exige idoneidad, necesidad, razonabilidad y proporcionalidad, y abstenerse ante la duda |
| Perú | Ley 29733 y nuevo reglamento (Decreto Supremo 016-2024-JUS, vigente desde el 30 de marzo de 2025); Autoridad Nacional de Protección de Datos Personales | Evaluación previa del marco jurídico del país de destino; también alcanza a empresas extranjeras que ofrecen servicios en Perú | Mecanismo preventivo recomendado, no obligación general; el Oficial de Datos Personales es obligatorio de forma escalonada | El reglamento regula decisiones automatizadas y perfilamiento (artículo 87), por ejemplo un scoring crediticio con efectos jurídicos |
| Argentina | Ley 25.326; Agencia de Acceso a la Información Pública; Convenio 108+ aprobado por la Ley 27.699 | Prohibidos a países sin protección adecuada, salvo excepciones o cláusulas modelo de la autoridad | No obligatoria hoy; el proyecto de reforma en el Congreso desde 2023 la incorpora | El Convenio 108+ reconoce el derecho a no quedar sujeto solo a decisiones automatizadas |

**Lo que se repite en todos:** los proveedores de nube actúan como encargados y necesitas un contrato que lo diga; el flujo fuera del país se justifica y se documenta; y si la IA decide algo importante sobre una persona, debe haber una revisión humana real y una explicación posible. Para Microsoft, el contrato base es el Data Protection Addendum (DPA) de los Product Terms.

## 4. Plantilla de DPIA para un caso de IA

Copia esta tabla por cada caso de uso y completa la última columna. Las filas 4, 7, 8 y 9 son las que una DPIA clásica suele olvidar cuando hay IA.

| # | Sección | Qué responder | Respuesta |
| --- | --- | --- | --- |
| 1 | Caso de uso y dueño | Qué hace el sistema, quién lo usa, quién responde por él y en qué países opera |  |
| 2 | Finalidad y base legal | Para qué se tratan los datos y con qué base en cada país: consentimiento, contrato, interés legítimo u obligación legal |  |
| 3 | Titulares y datos | Quiénes son las personas, qué datos se tratan y si hay datos sensibles, de menores o financieros |  |
| 4 | Flujo y residencia | Por dónde pasa el dato: app, gateway, modelo, índice y logs. Para cada tramo, servicio, tipo de despliegue, región de procesamiento y región de almacenamiento |  |
| 5 | Flujos internacionales | Países de destino y mecanismo que los habilita en cada ley: cláusulas, garantías o evaluación del país de destino |  |
| 6 | Encargados y subencargados | Microsoft y su DPA, proveedores de modelos de terceros, conectores, servidores MCP y agentes externos |  |
| 7 | Retención | Cuánto se guardan prompts, respuestas, trazas, memoria de agentes e índices; si aplica el monitoreo de abuso de hasta 30 días o el modificado |  |
| 8 | Entrenamiento | Si algún dato entrena o ajusta un modelo (fine-tuning) y cómo se borra después |  |
| 9 | Decisiones automatizadas | Si la salida decide algo sobre una persona, quién revisa, cómo se explica y cómo se impugna |  |
| 10 | Necesidad y proporcionalidad | Si se puede lograr con menos datos, datos seudonimizados o sin datos personales |  |
| 11 | Riesgos para las personas | Oversharing, fuga por inyección de prompts, errores o alucinaciones con efectos, sesgo, reidentificación |  |
| 12 | Controles | Etiquetas y DLP, gateway, RAG con permisos, guardrails, identidad del agente, registro y alertas (capítulos 3 a 7 y 11) |  |
| 13 | Derechos de los titulares | Cómo se atienden acceso, rectificación, cancelación y oposición cuando el dato está en un índice, una memoria o un log |  |
| 14 | Riesgo residual y decisión | Aprobar, aprobar con condiciones o rechazar; quién firma (DPO u Oficial de Datos Personales) y fecha de revisión |  |

## 5. Ejemplo resuelto: Copilot y un asistente RAG en un banco de Perú y Chile

Un banco con 3.000 empleados en Lima y Santiago quiere Microsoft 365 Copilot para todos y un asistente RAG en Foundry que responde a ejecutivos comerciales con fichas de clientes. El tenant tiene como geografía predeterminada Chile. Estas son las filas que deciden el caso; el resto se completa igual que en la plantilla.

| # | Respuesta del ejemplo |
| --- | --- |
| 1 | Dueños: gerencia de productividad para Copilot y gerencia comercial para el asistente RAG. Opera en Perú y Chile |
| 3 | Empleados y clientes; incluye datos financieros. No incluye datos de salud ni de menores |
| 4 | Copilot: interacciones guardadas en Chile con Advanced Data Residency, procesadas fuera de la región. RAG: índice de AI Search y recurso de Foundry en Brazil South con despliegue Regional, todo detrás del gateway |
| 5 | Perú: los datos de empleados y clientes peruanos se guardan en Chile y se procesan en Brasil y fuera de la región; requiere la evaluación previa del país de destino. Chile: procesamiento de Copilot fuera del país y RAG en Brasil; se documenta con las garantías contractuales del DPA de Microsoft |
| 7 | Retención de interacciones de Copilot por 1 año con Purview; trazas del RAG por 180 días; se acepta el monitoreo de abuso estándar de hasta 30 días |
| 9 | El RAG no decide créditos: sugiere información y el ejecutivo decide. Si en el futuro propone un score, se activa el artículo 87 del reglamento peruano y el 8 bis de la ley chilena, y hay que rehacer la DPIA |
| 11 | Riesgo alto de oversharing en SharePoint; riesgo medio de inyección por documentos de clientes; riesgo medio de error con efectos en el cliente |
| 12 | Restricted Content Discovery en sitios sensibles antes del despliegue; etiquetas y DLP para Copilot; búsqueda web desactivada; RAG con filtrado por permisos y Prompt Shields; Agent ID para el asistente; alertas del capítulo 11 |
| 14 | Aprobado con condiciones: las medidas de la fila 12 antes del lanzamiento, firma del Oficial de Datos Personales en Perú y del DPO en Chile, y revisión antes de la entrada en vigor de la Ley 21.719 o en 12 meses, lo que ocurra primero |

Fíjate en la fila 5: elegir Brazil South no elimina el flujo internacional, solo lo acota a un destino conocido. Para procesar en Perú o en Chile tendrías que esperar modelos con despliegue regional en Chile Central o usar un modelo alojado por ti.

## 6. Para repasar

1. Tu empresa está en México y quiere usar Azure OpenAI con datos de clientes. ¿Qué tipo de despliegue eliges y por qué no basta con elegir la región del recurso?
2. ¿Qué resuelve Advanced Data Residency para Copilot en Brasil, Chile o México, y qué no resuelve?
3. Nombra tres filas de la plantilla de DPIA que son propias de un caso de IA y explica qué riesgo cubre cada una.

## Fuentes

Las páginas oficiales de las leyes no se pudieron abrir desde este entorno; las filas legales se apoyan en estudios jurídicos y prensa especializada.

**Microsoft**

- [Tipos de despliegue en Foundry](https://learn.microsoft.com/azure/ai-foundry/openai/how-to/deployment-types) y [disponibilidad de modelos por región](https://learn.microsoft.com/azure/foundry/foundry-models/concepts/models-sold-directly-by-azure-region-availability)
- [Datos, privacidad y seguridad en Azure OpenAI](https://learn.microsoft.com/legal/cognitive-services/openai/data-privacy)
- [Lista de regiones de Azure](https://learn.microsoft.com/azure/reliability/regions-list)
- [Advanced Data Residency](https://learn.microsoft.com/microsoft-365/enterprise/advanced-data-residency) y [residencia de datos para Microsoft 365 Copilot](https://learn.microsoft.com/microsoft-365/enterprise/m365-dr-service-copilot)
- [Procesamiento de Copilot dentro del país para 15 países](https://www.technologyrecord.com/article/microsoft-expands-data-sovereignty-controls-for-microsoft-365-copilot-to-15-countries)

**Leyes**

- Brasil: [cláusulas estándar de la ANPD, Mattos Filho](https://www.mattosfilho.com.br/unico/clausulas-padrao-anpd/); [revisión de decisiones automatizadas](https://convergenciadigital.com.br/governo/anpd-avanca-na-regulacao-de-decisoes-automatizadas-por-ia/)
- México: [nueva LFPDPPP, EY](https://www.ey.com/es_mx/technical/tax/boletines-fiscales/nueva-ley-federal-proteccion-datos-personal-posesion-particulares) y [texto en la Cámara de Diputados](https://www.diputados.gob.mx/LeyesBiblio/pdf/LFPDPPP.pdf)
- Chile: [claves de la Ley 21.719](https://www.globalsuitesolutions.com/es/claves-proyecto-ley-organica-proteccion-de-datos-personales-chile/); [decisiones automatizadas y artículo 8 bis](https://www.diarioconstitucional.cl/2025/07/22/legalidad-y-revision-humana-estandar-constitucional-ante-decisiones-automatizadas-por-rodrigo-alvarez-seguel/)
- Colombia: [Circular Externa 002 de 2024 de la SIC](https://sedeelectronica.sic.gov.co/sites/default/files/normativa/Circular%20Externa%20No.%20002%20del%2021%20de%20agosto%20de%202024.pdf); [análisis de Cuatrecasas](https://www.cuatrecasas.com/es/latam/tecnologia-medios-digitales/art/guia-uso-responsable-ia-datos-personales-colombia)
- Perú: [nuevo reglamento, MINJUS](https://www.gob.pe/institucion/minjus/noticias/1067368-ejecutivo-aprueba-nuevo-reglamento-de-la-ley-de-proteccion-de-datos-personales); [análisis de Pérez-Llorca](https://www.perezllorca.com/es-pe/actualidad/articulos/se-aprueba-nuevo-reglamento-de-la-ley-de-proteccion-de-datos-personales/)
- Argentina: [guía de protección de datos, Linklaters](https://www.linklaters.com/Insights/Data-Protected/Data-Protected---Argentina)
