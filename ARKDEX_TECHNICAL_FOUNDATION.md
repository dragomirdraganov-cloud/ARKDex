# Fundamentos técnicos de ARKDex

Última revisión: 2026-07-24.

## Base

ARKDex usa SwiftUI, Swift 6 y Strict Concurrency completa sobre iOS 17+. La organización es pragmática y orientada por features: se añaden capas cuando expresan una responsabilidad real, no por convención.

## Decisiones consolidadas

- `AppDependencies` actúa como composition root sin singletons globales.
- Los ViewModels de UI usan `@MainActor` y `@Observable`.
- Servicios, modelos y errores que cruzan aislamiento son `Sendable`.
- Networking y persistencia no quedan aislados accidentalmente al MainActor.
- Los tests y previews usan dependencias deterministas.
- Los textos visibles viven en el String Catalog ES/EN.
- La UI consume colores y tipografías mediante tokens semánticos.
- Development y Production comparten target y cambian mediante configuración.

## Evolución hacia datos de criaturas

La infraestructura de ejemplo de Home deberá evolucionar hacia límites de producto:

```text
Features/Creatures/
├── CreatureModels.swift
├── CreatureRepository.swift
├── CreatureRepositoryLive.swift
├── CreatureSearchView.swift
├── CreatureSearchViewModel.swift
└── CreatureDetailView.swift
```

El nombre exacto puede variar, pero deben mantenerse estas responsabilidades:

- El modelo de dominio no depende del formato de la fuente.
- El cliente o repositorio live transforma DTOs en modelos validados.
- El buscador trabaja con identidad estable.
- Los datos desconocidos se representan explícitamente.
- La fuente y versión pueden conservarse junto al dato cuando sea relevante.

## Datos

Antes de integrar una fuente real hay que decidir:

1. Licencia y permiso de uso.
2. Cobertura de ARK: Survival Ascended.
3. Frecuencia de actualización.
4. Identificadores estables.
5. Estrategia offline y caché.
6. Cómo se representa la versión del juego o del dataset.

No se debe conectar una API de demostración como si fuese una fuente de producto.

## Calidad

- Build sin firma en CI.
- Tests unitarios sin red.
- Auditoría de secretos.
- Previews deterministas.
- Dynamic Type y localización.
- Logs redactados sin tokens ni payloads sensibles.

## Próxima decisión técnica

Definir `Creature`, un fixture pequeño y el contrato de `CreatureRepository` antes de implementar red, almacenamiento o una lista completa.
