# Hoja de ruta — Ariel Agent OS

**Base:** sábado 21 de noviembre de 2026.  
**Fecha objetivo inicial para migración:** antes del 10-12-2026, condicionada a pruebas y compra de equipo.

## P0: preservar lo existente
- [ ] Inventariar Hermes/Hostinger (comandos y rutas efectivos).
- [ ] Respaldo cifrado externo a destino permitido y restauración de prueba.
- [ ] Comprobar versiones, perfiles históricos, herramientas y credenciales (sin publicarlas).
- [ ] Registrar línea base de calidad, API, tiempos y RAM.

## P1: perfiles funcionales en VPS
- [ ] Crear perfiles de prueba sin borrar «Juan» ni «Alma».
- [ ] Probar Coordinador + Analista de Mediciones + Documentalista + Revisor Técnico.
- [ ] Probar Supervisor de Obras (inspección, avances y punch list).
- [ ] Probar Analista de Protecciones con COMTRADE autorizado/sintético.
- [ ] Añadir Auditor de Calidad.
- [ ] Crear Ingeniero de Automatización: herramientas Python reproducibles.
- [ ] Medir costo y correcciones por informe.\n- [ ] Integrar NotebookLM MCP en perfil de prueba de investigación; aceptar solo después de Q&A con citas, importación Drive, descarga PPTX/audio y medición de cuotas/API.

## P2: DeskRPG (en el VPS)
- [x] Publicar instalador y Compose reproducibles para un VPS nuevo; estado de ejecución: pendiente de prueba en VPS limpio.
- [ ] Verificar compatibilidad del repositorio real con versión Hermes.
- [ ] Piloto aislado; seguridad web; Kanban; perfiles; acceso desde navegador autorizado.
- [ ] Comprobar que Hermes por Telegram sigue operativo.
- [ ] Elegir una fuente canónica del estado de las tareas.
- [ ] Concluir conservar/desactivar según desempeño real.

## P3: estudio de presentaciones
- [ ] Productor de Presentaciones + Diseñador Visual.
- [ ] Investigación, contraste de fuentes, recursos complejos y diagramas exactos.
- [ ] Motor PPTX editable, PDF de inspección, notas y referencias.
- [ ] Ensayo con material de curso de diseño de subestaciones.
- [x] Configurar proveedor OpenRouter y modelo visual inicial google/gemini-nano-banana-2.1 en el instalador (pendiente de prueba en VPS nuevo).
- [ ] Evaluar costo real, calidad y proveedor alternativo de generación de imágenes.

## P4: migración
- [ ] Escoger Mini PC (16 GB RAM ampliable a 32; SSD 1 TB preferido).
- [ ] Preparar Linux Server, SSH seguro, backups y monitoreo.
- [ ] Evaluar Codex CLI remoto, separado de Hermes.
- [ ] Restaurar backup del VPS, ejecutar tests, transferir uso, mantener reversión.
- [ ] Cancelar VPS únicamente tras aceptación.

## P5: servicios domésticos futuros
- [ ] Home Assistant y homelab.
- [ ] CCTV y automatizaciones locales.
- [ ] Explorar inferencia local solo si mejora costo/calidad.
- [ ] n8n fuera de la fase inicial salvo necesidad concreta documentada.
