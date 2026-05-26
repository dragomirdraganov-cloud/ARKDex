# Como anadir una nueva feature

Ejemplo para una feature llamada `Profile`.

## Estructura

```text
Presentation/
├── Views/Profile/ProfileView.swift
└── ViewModels/Profile/ProfileViewModel.swift

Domain/
├── Models/Profile.swift
├── UseCases/FetchProfileUseCase.swift
└── Protocols/ProfileRepositoryProtocol.swift

Data/
├── Repositories/ProfileRepository.swift
├── DataSources/RemoteProfileDataSource.swift
├── DTOs/ProfileDTO.swift
└── Mappers/ProfileMapper.swift
```

## Pasos

1. Crear modelo de dominio.
2. Crear protocolo del repositorio.
3. Crear caso de uso.
4. Crear DTO si hay datos externos.
5. Crear mapper de DTO a dominio.
6. Crear repositorio concreto.
7. Crear ViewModel.
8. Crear View.
9. Registrar dependencias en `AppContainer`.
10. Anadir ruta en `AppRoute` si la feature requiere navegacion.
11. Anadir tests basicos cuando exista target de tests.
12. Marcar el progreso en `docs/IMPLEMENTATION_CHECKLIST.md` si afecta al esqueleto base.

## Convenciones de nombres

- Vistas: `FeatureNameView.swift`.
- ViewModels: `FeatureNameViewModel.swift`.
- Casos de uso: `ActionEntityUseCase.swift`.
- Protocolos de repositorio: `EntityRepositoryProtocol.swift`.
- Repositorios concretos: `EntityRepository.swift`.
- DTOs: `EntityDTO.swift`.
- Mappers: `EntityMapper.swift`.

