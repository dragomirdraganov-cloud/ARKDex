# Instrucciones para Codex

## Antes de programar

- Revisar `README.md`, `docs/ARCHITECTURE.md` y `docs/IMPLEMENTATION_CHECKLIST.md`.
- Revisar `git status` y conservar cambios del usuario.
- Mantener iOS 17, Swift 6 y Strict Concurrency completa.

## Código

- Organizar por features.
- No introducir singletons globales para dependencias.
- Usar `@Observable` y `@MainActor` para ViewModels.
- No usar `@MainActor` como solución genérica para infraestructura.
- Diseñar modelos y contratos cruzados como `Sendable`.
- No usar `@unchecked Sendable`, `nonisolated(unsafe)` ni `Task.detached` sin una justificación documentada.
- Preferir APIs modernas de SwiftUI compatibles con iOS 17.
- No añadir dependencias externas sin permiso explícito.
- No introducir capabilities, secretos ni servicios de producto por defecto.

## Calidad

- Añadir o actualizar tests para cada comportamiento.
- Tests y previews no deben usar red ni delays reales.
- Mantener textos visibles en ES y EN.
- Usar tokens semánticos del Design System.
- Redactar logs y no exponer cabeceras, tokens ni payloads sensibles.

## Antes de terminar

- Ejecutar `bash Scripts/check-secrets.sh`.
- Ejecutar build sin firma.
- Ejecutar tests.
- Actualizar README y documentación afectada.
- Marcar el avance en `docs/IMPLEMENTATION_CHECKLIST.md`.
