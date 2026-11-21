# Recuperación del puente privado de DeskRPG

## Incidente verificado el 21-11-2026

Después del reinicio de Hermes para activar NotebookLM, DeskRPG no podía contactar `http://hermes-private:18642`. La base de datos conservaba los 12 empleados activos y los 12 perfiles asociados; Hermes cargaba 13 perfiles incluyendo el principal.

El contenedor `ariel-hermes-private-relay` comparte el espacio de red del contenedor Hermes mediante `network_mode: container:...`. Tras reiniciar Hermes, el relay quedó en el espacio de red anterior. Desde DeskRPG, el puerto respondía `ECONNREFUSED`.

Se reinició únicamente el relay. Después:
- Conexión TCP DeskRPG → Hermes correcta.
- Gateway registrado como `valid`.
- Complemento registrado como `plugin_ready`.
- Prueba controlada: detener el relay, ejecutar el supervisor, comprobar recuperación y conexión TCP correcta.
- No se verificó visualmente la oficina desde el navegador del asistente: su autenticación HTTP no permitió abrirla. La confirmación anterior procede del servidor y la base de datos.

## Supervisor instalado

El script [ariel-office-relay-guard.py](../scripts/ariel-office-relay-guard.py) compara los espacios de red de los procesos de Hermes y del relay. Reinicia el relay si está parado o quedó en otra red. No cambia tokens, permisos ni puertos públicos. Si el contenedor Hermes se **recrea** con otro ID, requiere recrear el relay y revisar su referencia; este supervisor cubre reinicios del contenedor existente.

Instalación desde un checkout del repositorio como administrador del VPS:

~~~sh
install -m 750 scripts/ariel-office-relay-guard.py /usr/local/sbin/ariel-office-relay-guard
~~~

Crear `/etc/systemd/system/ariel-office-relay-guard.service`:

~~~ini
[Unit]
Description=Recover DeskRPG private relay after Hermes restart
After=docker.service
[Service]
Type=oneshot
ExecStart=/usr/local/sbin/ariel-office-relay-guard
TimeoutStartSec=50
~~~

Crear `/etc/systemd/system/ariel-office-relay-guard.timer`:

~~~ini
[Unit]
Description=Check DeskRPG relay network namespace
[Timer]
OnBootSec=45s
OnUnitActiveSec=30s
[Install]
WantedBy=timers.target
~~~

Activación:

~~~sh
systemctl daemon-reload
systemctl enable --now ariel-office-relay-guard.timer
systemctl start ariel-office-relay-guard.service
systemctl show ariel-office-relay-guard.service -p Result
journalctl -u ariel-office-relay-guard.service -n 10 --no-pager
~~~

Estado desplegado en el VPS actual: timer activo, servicio con `Result=success`. Los nombres de contenedores del script son propios de este VPS; adaptarlos al migrar. La instalación del supervisor queda documentada aquí y todavía no está integrada en el instalador general.
