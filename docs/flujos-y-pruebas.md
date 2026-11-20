# Flujos de trabajo y pruebas de aceptación

## 1. Informe técnico PAT/calidad de energía
**Entrada:** notas, matriz de mediciones, XML/CSV, fotos y criterios permitidos.  
**Cadena:** AG-03 cálculo → AG-05 documento → AG-06 revisión → AG-07 auditoría → usuario aprueba.  
**Aceptación:** coherencia de cifras, criterios sustentados, PDF renderizado, DOCX editable y evidencia.

## 2. Protecciones
**Entrada:** COMTRADE/SOE y configuración autorizada.  
**Cadena:** AG-02 análisis reproducible → AG-06 verifica → AG-05 documenta → AG-07 inspecciona.  
**Aceptación:** no inventar eventos, muestras, ajustes, fechas, hipótesis o fuentes.

## 3. Supervisión de obras
**Entrada:** notas, fotos, cronograma, planos, ensayos y reporte EPC.  
**Cadena:** AG-04 organiza hechos y datos declarados; AG-08 si se necesita procesador; AG-05 redacta; AG-06 valida porcentajes; AG-07 verifica.  
**Aceptación:** no confundir avance constructivo, avance de pruebas y transferencia a puesta en marcha. Informe informativo sin atribuir órdenes contractuales. Punch list con ID/TAG/ubicación/estado/evidencia/responsable.

## 4. Herramientas Python
**Entrada:** requerimiento con ejemplos de datos reales autorizados o sintéticos, resultados conocidos y casos límite.  
**Cadena:** AG-08 busca módulo existente → desarrolla en sandbox → tests → AG-06 valida ingeniería → AG-07 inspecciona → publicación aprobada.  
**Aceptación:** interfaces documentadas, tests reproducibles, sin sobrescribir versión estable.

## 5. PowerPoint
**Entrada:** Word/PDF base, audiencia, objetivo y número indicativo de diapositivas.  
**Cadena:** AG-09 depura y contrasta → storyboard; AG-10 busca/genera visuales; AG-05 construye PPTX; AG-06 verifica fuentes/datos; AG-07 revisa render de todas las diapositivas.  
**Aceptación:** contenido central intacto, notas de expositor donde convenga, enlaces a fuentes, PPTX editable + PDF de revisión. Diagramas eléctricos exactos hechos mediante SVG/código, no imágenes generadas sin verificación.

## Pruebas en Hostinger (ninguna ejecutada aún en esta etapa)

| Caso | Verificar |
|---|---|
| P-01 Perfiles | Roles y permisos efectivos; sistema anterior permanece |
| P-02 PAT | Error deliberado detectado por revisor; informe correcto |
| P-03 COMTRADE | Resultados reproducibles y trazables |
| P-04 Supervisión | Avance y punch list exactos |
| P-05 Python | Reutilización y tests; menor retrabajo medido |
| P-06 PPTX | Presentación verificada diapositiva por diapositiva |
| D-01–08 DeskRPG | Ver docs/deskrpg.md |
| B-01 Backup | Restauración real, no solo upload |

Cada prueba registra modelo efectivo, tokens, costo, duración, iteraciones, salida, defectos y evidencias en `templates/test-run.md`.
