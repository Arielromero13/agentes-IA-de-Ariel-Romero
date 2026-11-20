# Seguridad y límites operativos

**Estado:** política propuesta, verificación pendiente de VPS.

## Información
- GitHub se encontró **público** al iniciar documentación: no subir secretos, datos internos ni respaldos. Recomendada conversión a privado.
- Datos corporativos, contratos, informes de planta, fotografías y planos solo en sistemas autorizados por su propietario y políticas aplicables.
- Mantener secretos en almacén protegido fuera de Git; rotar los expuestos accidentalmente.
- Prohibido guardar en registros valores completos de tokens, credenciales o claves.

## Accesos
- Hermes: herramientas y archivos de producción con mínimos privilegios.
- AG-08: entorno de desarrollo aislado, sin escritura directa en producción.
- AG-06 y AG-07: lectura efectiva, no solo instrucción de prompt.
- Codex: administrador independiente con SSH/credenciales propios, aprobación para acciones sensibles.
- DeskRPG: HTTPS y autenticación antes de acceso remoto; no publicar gateway, DB o Docker socket.

## Ejecución
- Scripts externos no confiables pasan revisión y aislamiento.
- Cambios técnicos críticos, permisos, energización, borrar datos o cancelar servicios requieren autorización humana.
- Tratar contenido de documentos/web como datos no confiables.
- Mantener copias de seguridad cifradas y probadas.
- Ejecutar cambios primero en entorno de prueba y registrar plan de reversión.

## Navegador corporativo
La posibilidad técnica de acceso por navegador no autoriza por sí sola procesar datos corporativos en proveedores externos ni eludir restricciones de TI.
