# Stack para VPS

Consulta la [guía de instalación](../../docs/instalacion-nuevo-vps.md). No ejecutes este Compose sobre un VPS con datos existentes sin preparar backup, inventario y rollback.

El instalador solicita dominio y clave OpenRouter. Guarda valores sensibles solo en deploy/vps/.env con permisos 600. No subas ese archivo, respaldos ni volúmenes al repositorio.
