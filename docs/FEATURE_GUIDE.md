# Cómo añadir una feature en ARKDex

Ejemplo para el catálogo de criaturas:

```text
Features/Creatures/
├── CreatureModels.swift
├── CreatureRepository.swift
├── CreatureRepositoryLive.swift
├── CreatureSearchView.swift
├── CreatureSearchViewModel.swift
└── CreatureDetailView.swift
```

## Pasos

1. Definir el comportamiento y los estados visibles.
2. Crear la View.
3. Añadir ViewModel solo si existe lógica o estado de pantalla.
4. Definir un contrato si depende de red, archivos o persistencia.
5. Crear fixture y mock deterministas.
6. Registrar la implementación live en `AppDependencies`.
7. Añadir una ruta tipada si necesita navegación.
8. Añadir textos ES/EN al String Catalog.
9. Añadir previews y tests.
10. Actualizar estado y roadmap.

## Reglas de datos

- Identificadores estables.
- Campos desconocidos opcionales o modelados explícitamente.
- DTOs separados cuando el contrato externo no coincide con el dominio.
- Errores de mapeo visibles y testeables.
- No completar datos reales con suposiciones.

## Reglas de arquitectura

- Mantener modelos y servicios específicos dentro de la feature.
- Mover algo a Core solo cuando sea compartido y no dependa de una feature.
- No crear repository, mapper o use case si no aportan separación.
- Dependencias por inicializador.
- ViewModels de UI: `@MainActor @Observable`.
- Valores que cruzan aislamiento: `Sendable`.
