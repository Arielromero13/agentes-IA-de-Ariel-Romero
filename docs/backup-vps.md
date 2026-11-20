# Runbook — Backup y restauración del VPS Hostinger

**Estado:** PROCEDIMIENTO PLANIFICADO, NO EJECUTADO.  
**Destino propuesto:** Google Drive personal, solo para información cuyo almacenamiento esté autorizado.  
**Principio:** el respaldo no se considera terminado hasta demostrar una restauración funcional.

## Objetivo

Preservar y poder restaurar Hermes Agent, sus perfiles, skills, memorias/historias accesibles, scripts, plantillas, datos persistentes, configuración operativa y manifiestos del VPS. Preparar portabilidad a Mini PC sin perder la operación actual.

## Regla de seguridad

**No subir backup al repositorio GitHub.** Nunca almacenar tokens OpenRouter, bot Telegram, OAuth, claves SSH, auth.json, .env o bases de datos sin cifrar en Google Drive ni GitHub. Usar cifrado *antes* de transferir archivos. Guardar contraseña/clave de restauración por un medio separado y comprobar que se puede recuperar. No copiar documentos corporativos a una cuenta personal sin autorización.

## Fase 0. Condiciones previas

- [ ] Acceso SSH legítimo al VPS y privilegios mínimos.
- [ ] Identificar responsable y ventana segura de mantenimiento.
- [ ] Verificar cuota, tamaño y permisos del Drive de destino.
- [ ] Definir directorio temporal fuera de carpetas de producción.
- [ ] Registrar cómo recuperar el cifrado y dónde guardar copia alternativa.
- [ ] Definir criterio de éxito y plan de reversión antes de tocar servicios.

## Fase 1. Inventario no destructivo

Registrar resultados *sin imprimir secretos*:
- Fecha UTC, SO, kernel, arquitectura y espacio disponible.
- Servicios systemd, contenedores en uso, imágenes y versiones.
- Rutas efectivas de Hermes, datos de perfiles, skills, memoria, historiales, documentos y Python.
- Configuraciones Docker/Compose (copias sanitizadas), montajes, volúmenes, bases de datos.
- Crontabs, tareas programadas y servicios auxiliares.
- Versiones de Python, LibreOffice, Node, Hermes y dependencias relevantes.
- Puertos de escucha (sin publicar IP privada u otros detalles sensibles).

**No asumir rutas:** la instalación Hostinger puede diferir de una instalación manual. Descubrir en el VPS antes de construir comandos de copia.

## Fase 2. Clasificación

| Tipo | Política |
|---|---|
| Código y scripts propios | Versionar en repositorio tras revisión |
| Configuración sin secretos | Versionar sanitizada |
| Estado de ejecución, perfiles y memorias | Backup cifrado |
| Volúmenes y bases de datos | Backup consistente + restauración de prueba |
| Tokens/llaves | Backup cifrado separado; preferir rotación al migrar |
| Documentos de terceros/corporativos | Solo con permiso y almacenamiento autorizado |
| Logs | Seleccionar lo necesario; redactar secretos y datos personales |

## Fase 3. Captura consistente

1. Guardar inventario de volúmenes/servicios y dependencias.
2. Respaldar código, configuración y archivos en archivo portable preservando permisos cuando aplique.
3. Para bases de datos: utilizar exportación nativa coherente, snapshot consistente o pausa corta de procesos escritores. **No confiar en copiar SQLite/DB vivas de manera arbitraria.**
4. De ser necesaria pausa, registrar comienzo/fin y reactivar servicios al finalizar.
5. Crear manifiesto con nombre, tamaño, fecha y SHA-256 de cada archivo de backup.
6. Comprobar que los archivos se pueden leer y descomprimir en entorno de prueba.

## Fase 4. Cifrado y transferencia

Preferido: rclone con remoto Drive y `crypt`, o archivo cifrado con herramienta robusta y luego rclone para transferencia. No registrar secretos ni contraseñas en scripts de shell o logs. Probar primero con fichero inocuo.

Estructura conceptual en Drive:
```text
Ariel Agent OS/
  backups/
    vps-hostinger/
      YYYY-MM-DD/
        inventario-sanitizado/
        respaldo-cifrado/
        checksums/
        verificacion/
```
Los nombres visibles del backup deben minimizar exposición de información sensible. Valorar además cifrar nombres de archivo.

## Fase 5. Validación

- [ ] Subida finalizada y tamaño/cantidad coherentes.
- [ ] Verificación de integridad de hashes tras descarga.
- [ ] Clave de cifrado disponible y descifrado comprobado.
- [ ] Restauración de prueba en instancia aislada, **sin conectar bots productivos con credenciales activas**.
- [ ] Hermes inicia; perfiles/skills, memoria y herramientas presentes.
- [ ] Python/LibreOffice generan un documento de prueba.
- [ ] Telegram/OpenRouter se reconectan solo cuando sea seguro.
- [ ] Registro de errores, cambios y tiempo de restauración.

## Política de continuidad

Mientras estemos en el VPS: un backup completo inicial verificado; después incrementales/periodicidad a decidir según velocidad de cambio. Mantener al menos una copia independiente del VPS y, si es viable, una segunda independiente de Drive. Documentar retención, versiones y costes.

**No cancelar Hostinger hasta que la Mini PC restaure y supere pruebas de aceptación.**

## Registro de ejecución

Usar `templates/backup-run.md`; rellenar rutas reales, hashes, versiones y resultados *solo cuando se ejecute*. No publicar el inventario no sanitizado ni credenciales en GitHub.
