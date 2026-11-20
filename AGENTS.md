# Instrucciones de trabajo — Ariel Agent OS

Aplican a Codex, Hermes y colaboradores que trabajen en este repositorio.

## Regla principal
No afirmar que una función está desplegada sin evidencia reciente de ejecución en el VPS. Diferenciar **reportado**, **verificado**, **en prueba**, **propuesto** y **descartado**.

## Trabajo seguro
- No guardar secretos, OAuth, tokens, `.env`, auth.json, claves SSH, backups, datos personales o expedientes corporativos.
- Antes de tocar producción: inventario, respaldo verificado, análisis de impacto, autorización y reversión.
- El código es reutilizable, modular, tipado si aporta valor y acompañado de tests de referencia.
- Nunca ajustar cifras para producir conformidad ni atribuir exigencias a normas sin cita precisa.
- No sobreescribir originales técnicos; los resultados deben ser reproducibles.
- Las salidas de los modelos son borradores técnicos sujetos a validación.
- Separar permisos efectivos de las descripciones del rol. El «revisor solo lectura» no debe tener herramientas ni filesystem de edición.
- Cada PR debe mencionar cambios, pruebas reales, riesgos y cómo revertirlo.
- Preferir herramientas ya construidas; nuevos agentes solo cuando su aporte compense el costo.

## Ubicaciones
- `docs/`: arquitectura, agentes, seguridad, procedimientos, ADR.
- `templates/`: tareas, pruebas, backups, fichas de herramientas.
- `src/ariel_agent_os/`: Python reusable; sin importar código de VPS hasta auditarlo.
- `tests/`: pruebas automáticas que acompañan a cada módulo.
- `ROADMAP.md`: prioridades y evidencias faltantes.

## Relación entre sistemas
Hermes produce los entregables con OpenRouter. Codex, una vez conectado y autorizado, administra infraestructura/código **independientemente**. DeskRPG se evalúa como interfaz, no motor de IA. La última decisión de entrega es humana.
