# Registro de decisiones (ADR)

| ADR | Tema | Estado |
|---|---|---|
| ADR-001 | Hermes + Telegram + OpenRouter en VPS como piloto operativo | Actual reportado |
| ADR-002 | n8n fuera de primera fase salvo necesidad demostrada | Adoptado |
| ADR-003 | Perfiles por función, conservar temporalmente Juan/Alma | Diseño aprobado, ejecución pendiente |
| ADR-004 | Python reutilizable con Git y tests | A implementar |
| ADR-005 | DeskRPG como capa visual/kanban, primero en VPS | Piloto planificado |
| ADR-006 | Backup cifrado externo, restauración antes de migrar | Prioridad P0 |
| ADR-007 | Mini PC con OpenRouter, sin requerir LLM local | Objetivo futuro |
| ADR-008 | Codex separado para desarrollo/administración | Objetivo futuro |
| ADR-009 | Estudio de presentaciones con roles reutilizados | A probar |
| ADR-010 | Control humano final y permisos mínimos efectivos | Política general |

## Historial y compatibilidad
Los repositorios anteriores de Ariel Agent OS contienen arquitecturas que propusieron n8n/FastAPI/PostgreSQL y otras interfaces. Se conservarán como historial externo, **no como componentes desplegados actualmente**. No copiar archivos de código del VPS ni configuraciones antiguas sin inventario, comprobación de licencias y auditoría de secretos.

## Condición para cambios de estado
Todo ADR sobre implementación cambiará de «propuesto» a «probado/desplegado» solo con fecha, versión, evidencia y verificación de funcionamiento.
