# Catálogo funcional — versión propuesta 1.0

**Nombres funcionales**, sustituyendo progresivamente nombres históricos, sin borrar originales antes de validar.

| Código | Agente | Rol | Capacidad / restricción principal |
|---|---|---|---|
| AG-01 | Coordinador | Recibe, prioriza, delega, consolida | Tablero y delegación; no administrar servidor |
| AG-02 | Analista de Protecciones | COMTRADE, SOE, ajustes, fallas | Python técnico, no inventar ni aplicar ajustes |
| AG-03 | Analista de Mediciones | PAT, Fluke 1748, calidad de energía | Cálculos reproducibles, conserva originales |
| AG-04 | Supervisor de Obras | Inspección, avance constructivo/electromecánico, pruebas, punch list | No certificar ni cerrar hallazgos sin evidencia |
| AG-05 | Documentalista | DOCX/PDF/XLSX, gráficos y fotografías | No alterar conclusiones técnicas |
| AG-06 | Revisor Técnico | Revisar cálculo, unidades, fuentes y conclusiones | Solo lectura del material revisado |
| AG-07 | Auditor de Calidad | Requisitos, visualización y trazabilidad | Solo lectura, no aprobación humana sustitutiva |
| AG-08 | Ingeniero de Automatización | Crear, probar y mantener herramientas Python | Trabaja en sandbox Git, no cambia producción directamente |
| AG-09 | Productor de Presentaciones | Contenido editorial, investigación, storyboard y coordinación PPTX | Respeta núcleo del documento y verificabilidad |
| AG-10 | Diseñador Visual | Generar/recuperar imágenes, esquemas exactos y recursos | No inventar evidencia real ni dibujar circuitos exactos por imaginación |

## Especialización y orquestación

**Directo:** consulta simple a un perfil, sin convocar equipo.  
**Cadena:** analizar → documentar → revisar → auditar.  
**Paralelo:** fuentes, materiales visuales y datos independientes.  
**Director:** AG-01 elige especialistas, consolida y hace seguimiento cuando el caso exige varios pasos.

El «Investigador» es por ahora una *capacidad transversal* que pueden usar AG-01/02/03/09, no un perfil 11 sin justificación.

## Regla de modelos
OpenRouter permite evaluar modelos según herramientas, razonamiento, contexto, calidad y precio; asignación definitiva por perfil después de pruebas reales. No confundir descripción del perfil con cambio efectivo de modelo ni mecanismo de aislamiento.

## Capacidades técnicas base
- **Protecciones:** procesar COMTRADE y SOE mediante utilidades validadas; identificar fase, evento y limitaciones.
- **Mediciones:** PAT y Fluke 1748; criterios por fuente, unidades y resultados reales.
- **Supervisión:** observaciones de obra, avance por sistema/diámetro, protocolos de pruebas y punch list con IDs, estados y fotografías.
- **Automatización:** primero buscar código existente; versionar y probar antes de crear/reutilizar.
- **PPTX:** depurar fuentes, storyboard, ilustraciones complejas, diagramas vectoriales precisos, PPTX editable y revisión visual.

## Seguridad y gobierno
Permisos de lectura/escritura/ejecución deben imponerse en herramientas, SO/volúmenes/containers, no solamente en Markdown. AG-06/07 no modifican entregables. Toda acción contractual, eléctrica crítica o publicación externa necesita aprobación del responsable humano.
