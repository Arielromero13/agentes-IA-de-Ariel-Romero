# Ariel Agent OS

Oficina de agentes de ingeniería de Ariel Romero. **Estado al 21-11-2026:** Hermes en VPS, Telegram como canal de trabajo y dashboard oficial de Hermes como interfaz web. DeskRPG fue descartado y retirado por decisión de Ariel.

## Usarlo ahora desde Android

Abrir el dashboard existente y seguir la [guía de Hermes en Android](docs/hermes-android.md). El panel corre en el VPS; Chrome es el cliente. El chat oficial de la versión observada es una terminal integrada en la web. Telegram se conserva para encargos y entregables.

## Estado comprobado

- Hermes v0.23.1 operativo en el VPS actual.
- Perfil principal y 12 perfiles especializados conservados.
- Proveedor OpenRouter: los 12 perfiles utilizaban la misma clave que el principal; credenciales comparadas sin mostrar valores.
- Dashboard por HTTPS: selector de perfiles, chat, sesiones, modelos, MCP y cron observados.
- Chat web real del coordinador tras la retirada: respuesta `PANEL_HERMES_OK`.
- Telegram volvió a conectarse en modo polling después del reinicio.
- NotebookLM con cuenta dedicada: integración MCP de 55 herramientas conservada. Ariel informó haber recibido un entregable por Telegram; no se asume aceptación de todos los formatos ni ahorros de tokens.
- DeskRPG retirado: aplicación, relay, complemento, recursos exclusivos y supervisor. Datos archivados de forma privada antes de la retirada.

Las funciones específicas, el aislamiento entre perfiles y la calidad de los entregables se aceptan mediante pruebas reales, no por aparecer listadas.

## Instalación y migración

El instalador anterior desplegaba DeskRPG y fue retirado. `scripts/install-vps.sh` ahora termina con un aviso y no instala ni modifica servicios. El Compose anterior no declara servicios activos.

**Pendiente:** preparar y aceptar un nuevo instalador completo de Hermes nativo y una restauración ensayada en un VPS limpio. No presentar el antiguo comando de una línea como una instalación vigente.

Consultar [instalación y migración](docs/instalacion-nuevo-vps.md) y [respaldo del VPS](docs/backup-vps.md). No retirar el VPS anterior hasta validar el reemplazo.

## Documentación

- [Hermes en Android](docs/hermes-android.md)
- [NotebookLM](docs/notebooklm.md)
- [Catálogo de agentes](docs/agentes.md)
- [Flujos y pruebas](docs/flujos-y-pruebas.md)
- [Seguridad](docs/seguridad.md)
- [ADR y decisiones](docs/decisiones.md)
- [DeskRPG: decisión de retirada e historial](docs/deskrpg.md)
- [Reglas para agentes de código](AGENTS.md)

Los documentos históricos que mencionan DeskRPG, su relay o su instalador no autorizan reinstalarlo. Esta decisión vigente y la guía Android sustituyen esos pasos.

## Reglas del proyecto

1. Distinguir verificado, reportado, propuesto y descartado.
2. Conservar originales técnicos y evidencia de las pruebas.
3. No inventar mediciones, citas, costos ni normas.
4. Mantener la revisión técnica y aprobación humana del entregable final.
5. Mantener n8n fuera de esta fase hasta documentar una necesidad concreta.
6. Mantener ChatGPT/Codex independientes de Hermes; no conectarlos por OAuth.

Este repositorio es público. No guardar secretos, archivos de entorno, cookies, backups, expedientes ni conversaciones privadas.
