# Instalación y migración a un VPS nuevo

**Estado vigente — 21-11-2026:** DeskRPG fue descartado y retirado del VPS. La arquitectura elegida es Hermes + Telegram + OpenRouter + NotebookLM con cuenta dedicada y dashboard oficial como visor web.

## VPS actual

El dashboard oficial ya está operativo por HTTPS. Consultar la [guía de Android](hermes-android.md). No es necesario desplegar otra interfaz para usarlo desde el teléfono.

## Instalador anterior retirado

El antiguo `scripts/install-vps.sh` desplegaba DeskRPG y su plugin. Se sustituyó por un aviso con salida 2 que no instala ni modifica servicios. El antiguo Compose ahora declara cero servicios. Las definiciones anteriores permanecen en el historial de Git, únicamente como referencia histórica.

**Todavía no hay un instalador completo de una línea aceptado para la arquitectura nueva.** No presentar el comando anterior como una instalación funcional de Hermes nativo ni reutilizar el stack retirado.

## Trabajo necesario antes de migrar

1. Inventariar y respaldar de forma privada los datos persistentes de Hermes: perfiles, modelos, habilidades, memoria, historiales, cron y configuraciones de herramientas.
2. Registrar el entorno real de la imagen y sus dependencias, incluido LibreOffice; reconstruirlo de forma reproducible y probarlo.
3. Preparar el nuevo despliegue de Hermes, la autenticación del dashboard, HTTPS y persistencia. La API interna no necesita publicarse para navegar por el dashboard.
4. Restaurar secretos desde un canal privado; comprobar el proveedor y credenciales por perfil sin imprimirlas.
5. Reconstruir el entorno Python de NotebookLM en su ruta final y autenticar la cuenta dedicada. La primera autenticación sigue requiriendo intervención humana.
6. Probar Telegram y respuesta del dashboard, un entregable real con NotebookLM, los perfiles requeridos y un reinicio con persistencia.
7. Validar restauración y reversión antes de retirar el VPS anterior.

La integración NotebookLM está descrita en [su guía](notebooklm.md). Ariel informó haber recibido un entregable por Telegram; eso se registra como prueba reportada por el usuario, sin asumir aceptación de todos los flujos o formatos.

Consultar [respaldo del VPS](backup-vps.md). No publicar archivos de entorno, cookies, tokens, backups ni expedientes en el repositorio.
