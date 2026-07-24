# Instrucciones para Codex

## Antes de programar

- Revisar `README.md`, `docs/ARCHITECTURE.md`, `docs/PROJECT_STATUS.md` y `docs/IMPLEMENTATION_CHECKLIST.md`.
- Revisar `git status` y conservar cambios del usuario.
- Mantener iOS 17, Swift 6 y Strict Concurrency completa.

## Producto

- ARKDex consulta información de criaturas de ARK: Survival Ascended.
- No inventar estadísticas, criaturas, ubicaciones ni datos de domesticación.
- Marcar claramente fixtures, placeholders y datos dummy.
- No presentar una API de ejemplo como fuente real.
- Conservar fuente y versión cuando el dataset lo permita.
- No declarar afiliación oficial con ARK, Studio Wildcard o Dododex.

## Código

- Organizar por features.
- No introducir singletons globales.
- Usar `@Observable` y `@MainActor` para ViewModels.
- No aislar infraestructura al MainActor como solución genérica.
- Diseñar modelos y contratos cruzados como `Sendable`.
- No usar `@unchecked Sendable`, `nonisolated(unsafe)` ni `Task.detached` sin justificación documentada.
- Preferir APIs SwiftUI modernas compatibles con iOS 17.
- No añadir dependencias, capabilities o servicios externos sin permiso.

## Diseño

- Usar exclusivamente los tokens de `AppColors`; pedir nuevos colores antes de añadirlos.
- Usar Montserrat mediante `AppTypography`.
- Mantener Dynamic Type.
- Mantener textos visibles en español e inglés.

## Calidad

- Añadir o actualizar tests para cada comportamiento.
- Tests y previews sin red ni delays reales.
- Redactar logs y no exponer cabeceras, tokens o payloads sensibles.
- Actualizar la documentación cuando cambie arquitectura, producto o flujo.

## Antes de terminar

- Ejecutar `bash Scripts/check-secrets.sh`.
- Ejecutar build sin firma.
- Ejecutar tests.
- Comprobar que no quedan referencias al branding anterior.
- Actualizar `docs/IMPLEMENTATION_CHECKLIST.md`.
