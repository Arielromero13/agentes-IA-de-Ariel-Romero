# Hermes en Android — guía de uso

Estado verificado el 21 de noviembre de 2026. DeskRPG fue descartado por decisión de Ariel. La interfaz vigente es el dashboard oficial de Hermes, instalado en el VPS; Android actúa como cliente web. Telegram se conserva como canal de trabajo.

## Acceso desde Android

1. Abrir Chrome y entrar al [panel de Hermes](https://hermes-agent-7yvk.srv2148746.hstgr.cloud/?profile=default).
2. Si aparece el inicio de sesión, utilizar las credenciales actuales del panel Hermes. La clave de OpenRouter no se introduce en este formulario.
3. Abrir el selector de idioma de la barra lateral y elegir Español. La selección comprobada en el navegador del operador puede no trasladarse al navegador de Android.
4. En Chrome, abrir el menú de tres puntos → **Instalar y crear acceso directo → Crear acceso directo**. Nombrarlo «Ariel Agent OS» y tocar Añadir. El nombre del menú puede variar según la versión de Chrome; algunas versiones muestran Añadir a pantalla principal.
5. El acceso directo abre la web; los procesos y archivos siguen en el VPS. La primera autenticación desde otro navegador puede ser necesaria.

Referencia para el acceso directo: [Ayuda oficial de Chrome](https://support.google.com/chrome/answer/15085120?co=GENIE.Platform%3DAndroid&hl=es).

## Elegir con quién trabajar

La barra lateral tiene un selector con **default** y los 12 perfiles: alma, auditorcalidad, automatizacion, coordinador, disenovisual, documentalista, juan, mediciones, obras, presentaciones, protecciones y revisortecnico.

- **default** es el perfil principal que conserva las conversaciones de Telegram observadas.
- **coordinador** abre el contexto del coordinador.
- Los especialistas mantienen sus modelos, instrucciones y herramientas.
- Al seleccionar otro perfil, configuración, modelos, MCP y chats nuevos se aplican a ese perfil. El banner superior identifica el destino.
- Un chat nuevo de la web es una sesión distinta: no asumir que contiene la conversación actual de Telegram. Para consultar conversaciones previas, usar Sesiones o la lista de sesiones del chat.

Los 13 perfiles, incluido el principal, permanecieron después de retirar DeskRPG. No se modificó su asignación de modelos durante esta retirada.

## Para qué sirve cada sección

| Sección | Uso |
|---|---|
| Chat | Conversar con el perfil seleccionado mediante la terminal de Hermes integrada en la web. |
| Sesiones | Consultar el historial y revisar qué perfil/canal produjo una conversación. |
| Perfiles : multi agentes | Ver los empleados, su modelo y el estado del gateway. |
| Cron | Consultar y administrar tareas programadas de Hermes; incluye filtro por perfil. En la comprobación había cero tareas. |
| Registros | Investigar errores y actividad del agente. |
| Modelos | Revisar la asignación y el proveedor del perfil. |
| Habilidades | Consultar las capacidades instaladas del perfil. |
| MCP | Revisar servidores de herramientas, incluida la conexión a NotebookLM en los perfiles habilitados. |

Ver una habilidad, MCP o perfil listado no demuestra por sí solo que una tarea completa se haya ejecutado.

## Trabajar desde el chat web

1. Seleccionar el perfil.
2. Entrar en Chat.
3. Esperar a que la terminal indique que está lista.
4. Tocar la entrada inferior, escribir el encargo y enviar con Enter.
5. Leer las llamadas a herramientas, la actividad y el resultado en esa terminal. Tiene indicadores de actividad y tiempo; no es un cronómetro de tiempo restante de NotebookLM.
6. Contraer la barra lateral y el panel derecho para ganar espacio. En pantallas pequeñas, probar la orientación horizontal.

Se verificó una conversación real con coordinador desde la interfaz web tras retirar DeskRPG: respondió `PANEL_HERMES_OK`. La comodidad táctil y el teclado en el Android de Ariel no se probaron desde el navegador del operador.

El chat oficial de esta versión es una **terminal dentro de la web**. Para notas de voz, encargos habituales y recepción de archivos desde el teléfono, Telegram sigue siendo el canal operativo que Ariel probó; la web permite supervisar y administrar.

## Encargos largos y NotebookLM

El tiempo de procesamiento de fuentes, investigación y generación de artefactos depende también de NotebookLM. Retirar DeskRPG elimina una capa de integración; no elimina esa espera externa.

Instrucción útil al dar un encargo:

> Confirma que recibiste el trabajo. Indica la fase actual y avisa cuando cambie: búsqueda de fuentes, investigación en NotebookLM, generación y revisión. Si debes esperar a un servicio externo, dilo. No inventes porcentajes ni horas de entrega. Al finalizar, envía el archivo y las fuentes.

Se añadió a las instrucciones de los 13 perfiles informar inicio y avance verificable de los trabajos largos. Esto es una instrucción de comportamiento, no una garantía técnica de avisos periódicos ni de notificaciones con el navegador cerrado. No configurar un cron únicamente para aparentar progreso.

Si tarda, consultar el estado de la sesión y los registros antes de reenviar el encargo; repetirlo puede crear cuadernos o tareas duplicadas. El trabajo de un proceso y la conexión del navegador son estados distintos.

## Retirada de DeskRPG

Se retiraron contenedor de la aplicación, relay, volúmenes exclusivos, red privada dedicada, imagen de la aplicación, directorio de instalación, complemento en Hermes, enlaces de los perfiles y supervisor de recuperación. Los datos se archivaron primero en una carpeta privada de administrador; no se publicaron.

Consumo observado antes del retiro: aplicación 200 MiB y relay 7,31 MiB de RAM. Esa cifra corresponde a una lectura puntual; no representa el ahorro total de la máquina ni una reducción garantizada de latencia.

Se conservan Hermes, el proxy HTTPS, los perfiles, Telegram, OpenRouter y NotebookLM. El panel ya existía: no se instaló otro frontend, una APK ni una oficina sustituta.

## Instalación futura

El antiguo instalador del repositorio desplegaba DeskRPG. Fue retirado para impedir que reaparezca en un nuevo VPS. El procedimiento completo de migración y despliegue de Hermes nativo todavía debe prepararse y validarse; esta guía cubre el panel operativo actual.

Referencia del producto: [documentación oficial del dashboard de Hermes](https://github.com/NousResearch/hermes-agent/blob/main/website/docs/user-guide/features/web-dashboard.md).
