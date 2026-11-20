# Evaluación comparativa de interfaces para Hermes — 20-11-2026

**Estado:** investigación documental, no prueba práctica sobre VPS.  
**Objetivo:** acceso cómodo desde laptop corporativa por navegador autorizado a Hermes (perfiles por función, tareas, Kanban, informes, administración de skills/modelos, métricas y revisión).

## Hallazgo central

El dashboard **nativo de Hermes** ya implementa un tablero Kanban integrado con su sistema de perfiles, dispatcher y herramientas `kanban_*`. Conviene evaluar primero esta opción para evitar duplicación de estados y dependencias adicionales.

**Atención:** la documentación oficial advierte que algunas rutas de plugins en el dashboard pueden omitir autenticación HTTP al asumir ejecución en loopback. Nunca publicar sin revisión y protección de red. Referencia: https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/kanban.md

## Candidatos

| Opción | Integración Hermes | Capacidades relevantes | Riesgos/limitaciones | Evaluación |
|---|---|---|---|---|
| Dashboard nativo Hermes | Directa, mantenida con Hermes | Chat, perfiles, Kanban, ejecución de workers, eventos, cron según versión | Comprobar versión; panel y plugins **no** deben exponerse directamente | **Primera opción a probar** |
| Hermes Studio (JPeetz) | Aplicación comunitaria enfocada a Hermes | Crews, permisos/approval UI, memoria, skills, cron, API costs, Kanban, PWA | Proyecto externo con superficie administrativa amplia, compatibilidad/versiones deben probarse | **Finalista para interfaz profesional** |
| DeskRPG (dandacompany) | Plugin específico de Hermes y API Server | Oficina 3D, empleados/perfiles, chat, reuniones, Kanban, cron, artifacts | Depende de versión/API/plugin; acciones modifican perfiles/skills; funciones review-policy no plenamente soportadas upstream | **Piloto visual secundario** |
| Hermes Mission Control (albidev) | Panel satélite de operaciones | Telemetría, sesiones, herramientas, logs, modelos, Kanban y terminal | Acceso intensivo a rutas/telemetría; otra superficie de administración | Alternativa para monitoreo |
| Hermes AgentOS / Hermes Web UI | Comunidad | Paneles de agentes, perfiles y sesiones | Requiere auditoría independiente de mantenimiento/seguridad | Reserva, no instalar inicialmente |

## Fuentes primarias
- Hermes nativo / Kanban: https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/kanban.md
- Hermes Studio: https://github.com/JPeetz/Hermes-Studio
- DeskRPG: https://github.com/dandacompany/deskrpg
- Plugin DeskRPG: https://hermes-agent.nousresearch.com/marketplace/deskrpg
- Mission Control: https://github.com/albidev/hermes-mission-control

Los números de estrellas y mensajes promocionales de README no se consideran auditoría de seguridad ni garantía de estabilidad.

## Recomendación provisional

**No instalar DeskRPG directamente sobre producción todavía.**

1. Backup cifrado verificable + inventario de VPS.
2. Verificar qué versión de Hermes y dashboard tenemos en Hostinger; comprobar Kanban nativo y roles.
3. Estudiar Hermes Studio en entorno aislado: experiencia de chat, varias sesiones, visualización de herramientas, costes, aprobaciones y comodidad de uso desde navegador.
4. Probar DeskRPG también aislado si el dashboard nativo no satisface la experiencia visual buscada; confirmar integración y mantener los perfiles históricos intactos.
5. Escoger **una** interfaz principal, dejando Telegram como canal paralelo y el tablero de Hermes como fuente canónica cuando aplique.

## Pruebas de aceptación comparables

| ID | Requisito |
|---|---|
| UI-01 | Acceso seguro vía navegador remoto sin instalar software en laptop |
| UI-02 | Cambio entre Coordinador, Protecciones, Mediciones y Supervisión |
| UI-03 | Selección efectiva de modelo OpenRouter por perfil, comprobada en logs |
| UI-04 | Trabajo con archivos, entregables y enlaces de descarga |
| UI-05 | Kanban sincronizado con dispatcher real de Hermes |
| UI-06 | 2–3 trabajos activos sin degradar Telegram; medir CPU/RAM |
| UI-07 | Permisos efectivos: revisor sin escritura |
| UI-08 | Historial, memoria y estado tras reinicio |
| UI-09 | Costos/tokens y evidencias por trabajo |
| UI-10 | Desinstalación reversible, sin alterar datos de Hermes |

**Criterio de decisión:** fiabilidad/seguridad > integración > facilidad de uso > funciones de colaboración > estética 3D.

## Por qué todavía no se instala desde este chat

La conexión disponible a GitHub permite actualizar la documentación y repositorios, **pero no concede una shell SSH en Hostinger**. No se ha observado aquí una herramienta conectada que permita ejecutar comandos en el VPS. Para desplegar debemos entrar mediante sesión Work/Cloud Browser compatible, agente Codex con SSH aprobado o terminal del usuario. No confundir repositorio actualizado con servicio desplegado.

Cuando se obtenga acceso: efectuar inventario sin cambios, backup, piloto aislado, métricas y decisión documentada. No instalar componentes que reinicien Hermes sin ventana/consentimiento.
