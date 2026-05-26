# Flujo antes de subir cambios a GitHub

Antes de hacer push, abrir PR o publicar cambios:

- [ ] Revisar `git status` y confirmar que solo se suben cambios intencionados.
- [ ] Ejecutar build si hubo cambios de codigo.
- [ ] Ejecutar tests si existen o si se han anadido.
- [ ] Actualizar `README.md` si cambio la estructura, instalacion, validacion, estado o forma de trabajar.
- [ ] Actualizar los documentos necesarios dentro de `docs/` si cambiaron arquitectura, reglas, checklist o convenciones.
- [ ] Marcar tareas completadas en `docs/IMPLEMENTATION_CHECKLIST.md`.
- [ ] Comprobar que no se suben secretos, archivos locales ni datos privados.

Esta regla es obligatoria: cada subida a GitHub debe dejar `README.md` y `docs/` sincronizados con el codigo real del proyecto.

