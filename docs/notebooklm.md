# NotebookLM — operación con cuenta dedicada

**Estado al 21-11-2026:** integración comunitaria operativa con una cuenta exclusiva de la oficina, por autorización expresa de Ariel. La cuenta principal de Google permanece excluida.

## Estado vigente verificado

- Paquete fijado: `notebooklm-mcp-cli==0.16.1`.
- MCP stdio `gemini-notebook-mcp`: 55 herramientas detectadas.
- Cuenta dedicada: identidad comprobada antes de habilitar los perfiles. No publicar aquí su correo ni credenciales.
- Pro confirmado tanto en la interfaz de NotebookLM como en la respuesta autenticada de `usage_get` (`NOTEBOOKLM_TIER_PRO_CONSUMER_USER`).
- `notebook_list` y `usage_get` ejecutados por MCP sin error tras autenticar la cuenta dedicada.
- Configuración añadida al perfil principal y a coordinador, documentalista y presentaciones.
- Skill `nlm-skill` instalada; instrucciones de trabajo actualizadas para investigar con fuentes y conservar citas.
- Hermes reiniciado para cargar la configuración.
- Ese reinicio dejó el relay privado de DeskRPG en una red anterior. Se recuperó el enlace y se instaló/probó un supervisor; ver [incidente y recuperación](deskrpg-relay-recovery.md). Los 12 empleados permanecieron guardados y activos.
- Acceso web temporal cerrado: ruta pública retirada, interfaz web/VNC deshabilitada y ningún puerto del navegador publicado en el host.
- El navegador persiste únicamente en la red privada del VPS para mantener la sesión de la cuenta dedicada.

La investigación completa desde DeskRPG, la delegación entre empleados y los entregables PPTX/audio siguen pendientes de una prueba real. Una llamada MCP exitosa no demuestra por sí sola que todo ese flujo funcione. Tampoco se han medido ahorros de tokens ni costos.

## Configuración desplegada y recuperación

Dentro del contenedor de Hermes:

~~~yaml
mcp_servers:
  gemini-notebook-mcp:
    command: /opt/data/notebooklm-cli/bin/notebooklm-mcp
    connect_timeout: 60
    env:
      HOME: /opt/data/notebooklm
      NOTEBOOKLM_HL: es
    enabled: true
~~~

El entorno Python está en `/opt/data/notebooklm-cli`; la sesión está bajo `/opt/data/notebooklm`. La carpeta pertenece al UID/GID de servicio de Hermes (10000:10000 en este VPS), con modo 700 y archivos de sesión 600. Crear esa carpeta como root sin cambiar su propietario provoca `PermissionError` y el síntoma MCP `Connection closed`.

El navegador usa `jlesage/chromium:v26.09.2`, con perfil persistente independiente en el host. Su CDP es accesible solamente desde la red Docker privada; nunca debe publicarse en Internet. En el despliegue actual el proveedor externo apunta a `http://172.16.0.3:9222`. Esa dirección es propia de esta red: verificar/rediseñar la asignación al migrar.

Para reautenticar, abrir temporalmente una interfaz protegida por HTTPS y contraseña, iniciar sesión **solo con la cuenta dedicada**, ejecutar `nlm login --provider openclaw --cdp-url <CDP_PRIVADO> --storage file` con el mismo HOME persistente y el usuario de servicio, comprobar identidad/Pro y volver a cerrar inmediatamente la interfaz web. La primera autenticación requiere intervención humana.

En otro VPS hay que reconstruir el entorno Python en su ruta final e instalar la versión fijada; no asumir que copiar un venv entre sistemas sea portable. Restaurar las configuraciones de los perfiles y la skill, y completar la autenticación dedicada. Esta documentación no convierte por sí sola ese paso OAuth/cookies en una instalación automática sin intervención.

Las cookies y el perfil del navegador siguen siendo credenciales sensibles, aunque la cuenta esté dedicada. Verificar que la cuenta no tenga tarjetas ni acceso a un método de pago familiar; eso no se comprobó mediante las llamadas técnicas de NotebookLM. Pro compartido no equivale a aislamiento financiero automático.

## Historial: retirada de la cuenta principal


Se instaló `notebooklm-mcp-cli==0.16.1`, se resolvió un error de propiedad de la carpeta persistente y se autenticó mediante un navegador temporal. Se verificó `notebook_list` por CLI y MCP; también se detectaron 55 herramientas. No se completó la prueba de investigación, diapositivas ni audio.

La integración se descartó por el alcance de las credenciales: utiliza cookies de autenticación de la cuenta de Google, sin una concesión OAuth limitada exclusivamente a NotebookLM. Una filtración de la sesión puede tener consecuencias fuera de NotebookLM. Esto documenta una exposición técnica, no evidencia de que se haya producido un ataque.

Acciones ejecutadas:
- Retirada de la entrada MCP de la configuración principal y de los perfiles coordinador, documentalista y presentaciones.
- Eliminación del entorno del conector, sus cookies y metadatos locales, y la skill instalada para esta integración.
- Eliminación del contenedor de navegador temporal y su directorio de perfil persistente.
- Retirada previa de la ruta pública y reinicio de Hermes.
- Registro de la decisión en las instrucciones de los agentes.

**Revocación de la sesión anterior:** Ariel confirmó haber retirado en Google el acceso del navegador Linux reciente. Las copias locales de aquella sesión y el perfil de navegador fueron eliminados antes de crear el nuevo perfil dedicado.

Tras la retirada inicial se propuso uso manual. Ariel aclaró que la autonomía era el objetivo y autorizó posteriormente la conexión completa con una cuenta dedicada; el estado vigente figura arriba. No guardar credenciales, cookies ni perfiles de navegador en este repositorio.

## Diseño de referencia inicial

Las secciones siguientes conservan la propuesta previa y los criterios de aceptación. La autorización y configuración actuales son las de la sección Estado vigente verificado.

## Rol dentro de Ariel Agent OS

Para investigaciones basadas en muchos documentos, NotebookLM debe hacer la lectura de fuentes, las preguntas de seguimiento y la síntesis anclada a citas. El agente de investigación de Hermes organiza el trabajo, decide qué preguntar, registra notebook y fuentes, interpreta la respuesta y verifica que las citas correspondan al material.

Flujo sugerido:

1. Recibir el encargo, el tema y los enlaces/archivos autorizados.
2. Buscar un notebook existente o crear uno para el proyecto.
3. Importar las fuentes permitidas y esperar a que estén procesadas.
4. Hacer preguntas concretas a NotebookLM; conservar respuestas y citas.
5. Pedir a NotebookLM un primer borrador de presentación o un Audio Overview cuando ayude al objetivo.
6. Descargar el PPTX/audio, revisar el contenido contra las fuentes y solicitar correcciones.
7. Pasar a Hermes solo el resumen, las citas y el archivo final cuando necesite revisión, edición técnica o integración con otros entregables.

Así evitamos enviar documentos enteros a OpenRouter en cada turno. La reducción de consumo puede ser importante en tareas con muchas fuentes, pero no está medida todavía. Hermes seguirá usando tokens para planificar, pedir aclaraciones y revisar resultados. NotebookLM también tiene sus propios límites y cuotas por plan; no es capacidad ilimitada ni significa que todo el flujo sea gratuito.

## Integración recomendada para consulta y Studio

La API/MCP oficial de Gemini Notebook está en Public Preview. Actualmente sirve para crear y administrar notebooks y fuentes; el MCP documentado no expone preguntas al notebook ni generación de Studio. Google indica que durante la vista previa solo admite cuentas Google personales; Google Workspace no está soportado. Ver la [documentación oficial del MCP/API](https://developers.google.com/notebook/docs/mcp).

Para Q&A de notebooks y generación de diapositivas/audio, el candidato con mejor ajuste es el proyecto comunitario [jacob-bd/gemini-notebook-mcp-cli](https://github.com/jacob-bd/gemini-notebook-mcp-cli), fijado inicialmente en la versión 0.16.1. Su documentación declara integración de Hermes y ofrece herramientas de consulta, fuentes, investigación web/Drive y creación/descarga de artefactos Studio.

El cliente comunitario no es un producto de Google: utiliza interfaces internas no documentadas y cookies de sesión del navegador. Puede romperse sin aviso y su mantenedor advierte que podría no estar alineado con los términos de Google. Antes de usarlo con trabajo real, hacer una prueba personal con documentos no sensibles. Reautenticación de la cuenta puede ser necesaria cada varias semanas.

La conexión Hermes es por MCP stdio. Esquema orientativo; verificar la ruta de almacenamiento y el comando con la versión de Hermes instalada:

~~~yaml
mcp_servers:
  gemini_notebook:
    command: uvx
    args:
      - --from
      - notebooklm-mcp-cli==0.16.1
      - notebooklm-mcp
    env:
      HOME: /opt/data/notebooklm
~~~

La carpeta HOME indicada debe residir en el volumen persistente de Hermes y quedar con permisos de propietario solamente. La primera autenticación de Google se realiza aparte; no es posible terminarla desde una instalación sin intervención del usuario. No publicar cookies, auth.json, perfiles de Chrome ni tokens en GitHub, logs o capturas. Si se usa una cuenta personal dedicada, limitarla a notebooks y fuentes aprobados.

## Presentaciones y audio

NotebookLM puede producir un Slide Deck descargable como PPTX y Audio Overviews desde las fuentes del notebook. La ayuda oficial describe la descarga a PowerPoint; consulta [generar presentaciones](https://support.google.com/gemininotebook/answer/16757456?hl=es) y [resúmenes de audio](https://support.google.com/gemininotebook/answer/16212820?hl=es).

Para las presentaciones técnicas de Ariel:

- Usar el deck de NotebookLM como primer borrador editorial y visual.
- Verificar cifras, unidades, conclusiones, referencias y notas contra documentos fuente.
- Rehacer manualmente en PowerPoint los diagramas eléctricos que requieran precisión geométrica, identificación o cumplimiento normativo. No delegar un unifilar exacto a generación visual.
- Mantener AG-09 (Productor de Presentaciones) para estructura y narrativa; AG-10 (Diseñador Visual) puede proponer imágenes/ilustraciones con image_gen y ayudar a revisar el estilo.
- Probar el PPTX descargado en LibreOffice/PowerPoint y corregir sustitución de fuentes, objetos editables, tablas e imágenes antes de entregar.

Los Audio Overviews son un producto distinto del modelo de voz de Hermes. Conviene generarlos solo cuando el usuario los pida o aporten valor de estudio; revisar pronunciación de nombres, acrónimos eléctricos y unidades.

## Costos y límites

- Las preguntas, presentaciones y audios de NotebookLM consumen las cuotas/capacidades asociadas a la cuenta y su plan.
- El agente seguirá consumiendo OpenRouter para coordinación y revisión, aunque puede dejar de mandar textos de fuentes completos al modelo de Hermes.
- Comparar ambos consumos con una prueba representativa y los datos disponibles en OpenRouter/NotebookLM; no anunciar ahorros cuantificados sin medición.
- Las respuestas de NotebookLM también pueden equivocarse o citar de forma incompleta. Las referencias reducen el trabajo de rastreo, pero no sustituyen la revisión técnica.

## Criterios históricos de aceptación — suspendidos

1. Instalar el MCP en un perfil de Hermes de prueba, con versión fijada y HOME persistente.
2. Completar autenticación sin guardar cookies en el repositorio.
3. Listar notebooks y consultar uno pequeño; comprobar respuestas con citas.
4. Importar una fuente de Google Drive permitida; confirmar actualización/permiso de la fuente.
5. Generar un PPTX y un audio de prueba, descargarlos y comprobar que abren.
6. Registrar cuotas consumidas, tokens OpenRouter evitados/empleados, versiones, fallos y pasos de reautenticación.
7. Solo después habilitarlo para el agente de investigación del equipo.

No mezclar esta integración con el fallo ya documentado de rutas del plugin DeskRPG. El MCP puede funcionar como herramienta de Hermes aunque Kanban y cron de DeskRPG sigan pendientes.
