# Instalación de Ariel Agent OS en un VPS nuevo

**Estado al 21-11-2026:** el instalador y Compose están incorporados al repositorio; todavía no se han ejecutado en un VPS limpio. La instalación reproducible no equivale a una prueba de aceptación.

## Instalación con una línea

En un VPS Debian o Ubuntu recién creado, entra por SSH como usuario con sudo y ejecuta:

~~~bash
curl -fsSL https://raw.githubusercontent.com/Arielromero13/agentes-IA-de-Ariel-Romero/main/scripts/install-vps.sh | sudo bash
~~~

El script solicita el dominio y la clave de OpenRouter de forma interactiva. La clave no se incluye en el comando ni se muestra mientras se escribe. Genera claves de aplicación, crea archivos en /opt/ariel-agent-os, instala Docker si hace falta y levanta los contenedores.

## Requisitos

- VPS Debian 12 o Ubuntu 22.04/24.04; se recomienda al menos 2 vCPU y 8 GB RAM para DeskRPG y Hermes.
- Dominio con registro A que apunte a la IP pública del VPS.
- Puertos TCP 80 y 443 habilitados en el firewall del VPS y del proveedor, libres para Caddy. Mantén SSH (22) según tu política.
- Clave API activa en OpenRouter y saldo/límite adecuado para chat e imágenes.
- Sesión SSH estable con sudo.

El instalador no reemplaza una carpeta existente en /opt/ariel-agent-os. No usarlo para actualizar ni restaurar el VPS actual.

## Componentes

- DeskRPG 2026.1019.1, SQLite y datos en volumen persistente.
- Hermes Agent v0.23.3; API solo en la red privada de Docker. Dashboard, si se activa, ligado a loopback.
- Plugin DeskRPG del commit que DeskRPG fija para esa versión; se instala y habilita antes de iniciar el gateway.
- Caddy como proxy HTTPS. Solo la oficina se publica en 80/443.
- Hermes image_gen configurado con proveedor OpenRouter y modelo inicial google/gemini-nano-banana-2.1. Su disponibilidad y precio pueden cambiar.
- Secretos en deploy/vps/.env, con permisos 600. El archivo y volúmenes de datos están excluidos de Git.

La primera cuenta de DeskRPG se convierte en administradora. En My Gateways registra Hermes en http://hermes:8642 usando HERMES_API_KEY del archivo local .env. Después agrega los perfiles Hermes y asocia el gateway al canal. Estos pasos requieren usar la interfaz; el despliegue del servidor se ejecuta con una línea.

## Modelos de texto e imágenes

La conversación y el razonamiento de cada empleado son independientes del modelo que produce imágenes:

- DeskRPG permite escoger modelo, proveedor y configuración por empleado. Asigna Claude Sonnet u otro modelo de texto al diseñador para ideación, dirección de arte, prompts y revisión.
- Hermes utiliza OpenRouter para image_gen y el modelo de imagen indicado arriba. El costo de imágenes se factura según el modelo/proveedor, además del costo de texto que genere o refine el prompt.
- Configurar un modelo visual no hace que cada agente genere imágenes por sí solo. El perfil debe tener acceso a image_gen; confirma en Hermes que la herramienta esté habilitada para ese perfil.
- El instalador no altera el modelo conversacional de perfiles existentes. Se asigna por empleado después de registrar perfiles.
- El catálogo de modelos visuales cambia; revisa disponibilidad y precios antes de producción.

## Aceptación posterior

No consideres la oficina aceptada solo porque cargue la URL. Verifica manualmente:

1. DeskRPG carga en HTTPS y permite crear la cuenta administradora.
2. My Gateways conecta con http://hermes:8642 y la clave propietaria del listener.
3. Aparecen los perfiles Hermes; asocia un perfil a un empleado y canal.
4. Un mensaje de prueba responde en DeskRPG; si Telegram se configura por separado, confirma también que sigue operativo.
5. Kanban y cron funcionan con el plugin activo. Prueba una tarea pequeña y una ejecución programada.
6. El perfil visual genera una imagen real mediante image_gen; revisa el cargo en OpenRouter.
7. Un reinicio conserva cuentas, perfiles y datos.

Registra fecha, versiones, evidencia con secretos ocultos, uso de RAM/CPU y resultados. No copies claves ni archivos del VPS al repositorio.

## Operación y actualización

~~~bash
cd /opt/ariel-agent-os
sudo docker compose --env-file deploy/vps/.env -f deploy/vps/docker-compose.yml ps
sudo docker compose --env-file deploy/vps/.env -f deploy/vps/docker-compose.yml logs -f hermes deskrpg caddy
sudo docker compose --env-file deploy/vps/.env -f deploy/vps/docker-compose.yml pull
sudo docker compose --env-file deploy/vps/.env -f deploy/vps/docker-compose.yml up -d
~~~

Antes de actualizar, respalda DeskRPG y Hermes; no uses docker compose down -v. Las etiquetas están fijadas para facilitar una instalación repetible. Para actualizar, cambia DESKRPG_IMAGE y HERMES_IMAGE en el .env local conforme a sus notas de versión y compatibilidad, recrea servicios y repite la aceptación. El pin del plugin se obtiene de la imagen DeskRPG seleccionada.

Para restaurar, detén servicios sin borrar volúmenes, restaura desde un respaldo ensayado y valida antes de reabrir tráfico. Consulta la guía de [respaldo del VPS](backup-vps.md).

## NotebookLM (integración opcional)\n\nNotebookLM no forma parte todavía de la instalación de una línea. La investigación de integración encontró que el MCP oficial está en Public Preview y no ofrece actualmente Q&A/Studio; el conector comunitario con esas capacidades requiere autenticación de Google y conserva cookies de sesión fuera del repositorio. No se ha desplegado ni aceptado. Sigue el procedimiento, límites y criterios de seguridad en [docs/notebooklm.md](notebooklm.md).\n\n## Límites

- No migra datos, perfiles, memoria, credenciales ni historial del VPS actual. Eso requiere respaldo cifrado y una restauración probada.
- No expone Hermes API, dashboard ni base de datos a Internet.
- No configura Telegram ni restaura empleados/modelos.
- No se ha ejecutado en un VPS limpio al publicar esta versión.
- Revisa las versiones actuales antes de producción: DeskRPG y Hermes evolucionan por separado.

## Referencias técnicas

- [DeskRPG: Docker y Hermes](https://github.com/dandacompany/deskrpg#quick-start)
- [DeskRPG: conexión y plugin Hermes](https://github.com/dandacompany/deskrpg#hermes-connection)
- [Hermes: despliegue Docker](https://hermes-agent.nousresearch.com/deployment/docker/)
- [Hermes: generación de imágenes](https://hermes-agent.nousresearch.com/features/image-generation/)
- [OpenRouter: catálogo de modelos de imagen](https://openrouter.ai/google/gemini-nano-banana-2.1)
