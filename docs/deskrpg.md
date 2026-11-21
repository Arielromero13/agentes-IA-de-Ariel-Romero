# DeskRPG — Evaluación e instalación piloto sobre VPS

**Estado:** piloto instalado; integración con Hermes pendiente de resolver y validar.  
**Objetivo:** interfaz web visual para la oficina de agentes, especialmente desde el navegador de la laptop corporativa, sin instalar allí herramientas ni burlar restricciones TI.

## Hipótesis que validaremos

1. DeskRPG puede ofrecer una representación visual y gestión del equipo que trabaja con Hermes.
2. Puede conectar a las instancias/perfiles de Hermes sin duplicar estado o romper Telegram.
3. Permite recibir tareas, consultar estado, trabajar con tablero Kanban y ver resultados.
4. Resulta usable mediante navegador desde ubicaciones remotas autorizadas.
5. Su impacto en RAM/CPU del VPS es asumible, con inferencia remota en OpenRouter.

**No asumir que un personaje 3D equivale a un proceso LLM independiente ni que los permisos declarados en la UI aíslan el sistema.**

## Antes de instalar

- [ ] Backup del VPS e inventario de contenedores, puertos, uso RAM/CPU/disco.
- [ ] Confirmar URL, autor y repositorio oficial de DeskRPG; revisar licencia, releases, dependencias, estado de mantenimiento y riesgos.
- [ ] Revisar documentación de compatibilidad con la **versión real de Hermes**.
- [ ] Determinar si DeskRPG necesita gateway Hermes, API, DB adicional, websocket o variables especiales.
- [ ] Definir despliegue de pruebas sin tocar config o directorios productivos.
- [ ] Medir recursos base y latencias actuales antes del cambio.

## Despliegue inicial propuesto

- Docker/Compose aislado en red privada, versiones fijadas y volúmenes propios.
- **No exponer directamente al exterior gateway Hermes, puertos administrativos, base de datos o sockets Docker.**
- Probar primero acceso local por loopback/túnel SSH privado.
- Si funciona, publicar interfaz *solo* detrás de HTTPS, autenticación fuerte, control de acceso y registro de auditoría.
- No guardar claves de OpenRouter en frontend ni cliente web.
- Validar permisos de cuentas, lectura/escritura y limitación de ejecución.
- La laptop corporativa será cliente web solo si sus políticas lo permiten; no pedir instalar software no autorizado.

## Experimentos de aceptación

| ID | Ensayo | Evidencia / aprobación |
|---|---|---|
| D-01 | Arrancar DeskRPG sin interrumpir Hermes | logs y salud VPS pre/post |
| D-02 | Crear representación de Coordinador y dos especialistas | captura de UI, perfiles efectivos |
| D-03 | Abrir tarea y cambiar estados Kanban | comparativo de estado real Hermes/DeskRPG |
| D-04 | Enviar tarea a un perfil y obtener resultado | identificadores de trabajo, logs redigidos |
| D-05 | Dos agentes activos y un tercero inactivo | RAM, CPU, latencia, colas |
| D-06 | Reconexión tras reinicio aislado | persistencia de tareas |
| D-07 | Probar desde navegador remoto autorizado | login, HTTPS, permisos |
| D-08 | Apagar solo DeskRPG | Hermes y Telegram permanecen operativos |

## Relación con el catálogo funcional

Los perfiles AG-01…AG-10 son **roles definidos**; empezar con Coordinador, Analista de Mediciones y Documentalista/Revisor. Los diez perfiles se crearon como estructura; no se han validado como agentes operativos. Mantener históricos Juan y Alma durante la transición. Modelos de OpenRouter por perfil cuando integración confirme soporte; comparar costos reales.

## Pizarra y memoria

Elegir una fuente canónica de tareas: no mantener dos Kanban independientes sin sincronización comprobada. Registrar ID de trabajo, responsable, estado, evidencia, costo y fecha. No confundir historial visual con memoria durable de Hermes.

## Rendimiento

Como OpenRouter realiza inferencia, DeskRPG añade principalmente carga de aplicación y comunicación; la escena 3D puede exigir al navegador cliente más que al servidor. La concurrencia *de herramientas* (Python, LibreOffice, procesamiento XML/COMTRADE, archivos) sí puede saturar el VPS. Medir. Limitar inicialmente a uno o dos trabajos pesados simultáneos.

## Riesgos y reversión

- Incompatibilidad entre versiones de gateway y UI.
- Superficie de ataque de panel remoto.
- Exposición involuntaria de tokens/datos.
- Desincronización de estados.
- Uso de recursos que afecte Telegram/Hermes.

**Reversión:** detener contenedores/red de DeskRPG y retirar proxy/rutas sin tocar volúmenes de Hermes; comprobar nuevamente Telegram, perfiles y tareas previas.

## Decisión pendiente

Aceptar DeskRPG solamente si facilita significativamente el trabajo desde navegador y no degrada la operación actual. Su adopción no condiciona ni el backup ni la futura migración a Mini PC.


## Estado observado — 21 de noviembre de 2026

- Piloto DeskRPG 2026.1019.1 desplegado en contenedor con persistencia SQLite; acceso por HTTPS y autenticación. Integración funcional completa **pendiente**.
- Hermes informa versión 0.23.1; complemento deskrpg 0.32.0, commit 45caa875f2059152188eca515778e8af2a9c08ae, instalado y habilitado en el perfil principal. El diagnóstico del CLI pasa con una advertencia de hook; esto no demuestra que las rutas HTTP funcionen.
- La API de Hermes responde en loopback; se preparó un relay privado entre contenedores. El test autenticado GET /deskrpg/info devuelve 404. Se confirmó mediante instrumentación temporal que el proceso del gateway ejecuta el registro inicial del plugin, pero no ejecutó la función que conecta las rutas. Causa exacta pendiente; la instrumentación fue retirada del archivo. No atribuir el fallo a claves, versión o enrutamiento sin prueba adicional.
- Se detectó inicialmente ausencia de PyYAML en el entorno del gateway. Hay un enlace de compatibilidad en el entorno del contenedor hacia la copia persistida de PyYAML; esto funciona al reiniciar, pero **no está garantizado al recrear la imagen**. Diseñar una imagen reproducible con dependencia fijada y probada; no modificar el contenedor productivo sin respaldo.
- La conexión adicional a la red Docker y el relay comparten el espacio de red del contenedor Hermes y dependen de su dirección privada. No son una configuración de Compose reproducible: reconstruirla y probarla antes de migrar o recrear servicios. Mantener el API sin puerto publicado externamente y proteger las credenciales.
- Se crearon diez directorios de perfiles y sus instrucciones iniciales; no se han validado configuración de proveedor, modelos, herramientas, aislamiento ni ejecución. Juan y Alma se conservan solo durante la transición hasta verificar migración.
- Tras reinicios el registro informó conexión de Telegram; también aparecieron intentos de envío rechazados por Telegram porque un destinatario bloqueó el bot. No identifica por sí solo al destinatario ni prueba que toda la integración Telegram falle. Validar con el usuario sin enviar mensajes automáticos.
- Pendientes: resolver la carga del manejador API por el gestor de plugins y/o alcance de perfil; verificar /deskrpg/info autenticado, conectividad privada, asociación en My Gateways y canal; probar un perfil y Telegram de extremo a extremo; formalizar Compose y rollback; medir recursos con trabajo real; instalar Codex CLI después de completar DeskRPG.

Referencias: https://github.com/dandacompany/deskrpg#hermes-connection y https://github.com/dandacompany/deskrpg-hermes-plugin#requirements-and-installation . Nunca registrar claves, contraseñas ni datos de conversaciones en el repositorio.

### Prueba adicional del 21 de noviembre

El usuario registró el gateway y DeskRPG mostró conexión validada. Aun así, importar perfiles informa plugin_not_loaded y /deskrpg/info devuelve 404. En un proceso aislado con el perfil principal, el gestor detectó el manejador del plugin y el complemento pudo agregar 116 rutas a una aplicación de prueba, incluida /deskrpg/info; esto no prueba el servicio real. Se vinculó también el directorio de metadatos de PyYAML 6.0.3 al entorno Python del contenedor para que la dependencia se detecte; tras reiniciar, el endpoint real continuó devolviendo 404. El ajuste dentro del contenedor no es reproducible al recrearlo. Telegram informó reconexión, sin prueba posterior de respuesta del bot. Siguiente diagnóstico: determinar por qué el manejador del gestor del perfil principal no se invoca durante el arranque del adaptador API, sin alterar el sistema productivo hasta contar con reproducción y reversión.
