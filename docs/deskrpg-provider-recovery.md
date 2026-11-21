# DeskRPG: empleado visible pero responde Failed

## Incidente y causa verificados — 21-11-2026

La oficina volvió a mostrar los empleados tras recuperar el relay, pero un mensaje al coordinador terminaba en `coordinador: Failed`. Su registro contenía `ProviderNotConfiguredError: No LLM provider configured`.

El perfil tenía `model.provider: openrouter`, un modelo seleccionado y `https://openrouter.ai/api/v1` como URL. Faltaba `OPENROUTER_API_KEY` en su entorno. De los 12 perfiles existentes, Juan y Alma ya tenían la clave; faltaba en los otros diez. La configuración del modelo no concede por sí sola credenciales a un perfil.

## Reparación aplicada

- Se guardó una copia local privada de cada entorno modificado: `.env.pre-openrouter-fix-20261121`.
- Se configuró solamente la clave OpenRouter que ya utiliza Hermes principal en los perfiles que carecían de ella.
- Los archivos quedaron con propietario UID/GID 10000:10000 y modo 600.
- No se copiaron las demás credenciales del entorno principal.
- No se cambiaron los modelos asignados.
- Hermes detectó el cambio de entorno del coordinador; no hizo falta reiniciar el contenedor.

No guardar aquí las claves, los archivos de entorno ni sus respaldos.

## Evidencia de ejecución

- Los 12 perfiles tenían una clave OpenRouter igual a la del entorno principal; comparación realizada en memoria sin mostrar valores.
- OpenRouter autenticó la clave en su endpoint `GET /api/v1/key`, HTTP 200.
- El coordinador respondió `COORDINADOR_OK` en una llamada CLI real.
- Prueba adicional sobre `POST http://127.0.0.1:8642/p/coordinador/v1/chat/completions`, autenticada con su clave de gateway: HTTP 200 y respuesta `COORDINADOR_GATEWAY_OK`.
- La igualdad de claves verifica el uso de la cuenta configurada en Hermes principal. No se verificó por separado el correo del titular en el panel de OpenRouter.
- La delegación al documentalista y la investigación completa en NotebookLM siguen requiriendo su prueba real.

## Prevención al crear o migrar perfiles

Verificar por perfil tanto el proveedor/modelo como la presencia de su credencial. Si la oficina utiliza la misma cuenta OpenRouter, suministrar esa clave mediante el entorno privado de cada perfil. Si usa claves separadas, comprobarlas de forma independiente; no reemplazarlas por defecto.

Distinguir la clave del proveedor (`OPENROUTER_API_KEY`) de la clave con la que DeskRPG autentica el acceso al gateway (`API_SERVER_KEY`). Una conexión válida al gateway no prueba que el proveedor LLM esté configurado.

Como aceptación mínima, ejecutar una respuesta breve mediante la ruta de gateway del perfil; comprobar que aparece una respuesta y no limitarse a listar perfiles o probar TCP.

## Reversión

Restaurar únicamente el archivo de entorno del perfil afectado desde su respaldo privado, conservando propietario y modo 600. Esto retira la credencial añadida y puede reproducir el fallo. No restaurar los entornos de otros perfiles ni modificar el relay por este error.
