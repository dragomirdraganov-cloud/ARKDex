# Arquitectura SwiftUI + MVVM

## Objetivo

Convertir el proyecto default de Xcode en una base iOS simple, clara y preparada para crecer usando SwiftUI, MVVM e inyeccion explicita de dependencias.

## Capas

```text
App
├── Presentation
├── Domain
├── Data
├── Core
└── Resources
```

## App

Responsabilidad:

- Mantener el punto de entrada de la aplicacion.
- Crear el contenedor raiz de dependencias.
- Definir la vista inicial.
- Configurar entorno global si hace falta.

Archivos esperados:

- `App/SwiftUIMVVMTemplateApp.swift`
- `App/AppEnvironment.swift`

## Presentation

Responsabilidad:

- Vistas SwiftUI.
- ViewModels.
- Componentes reutilizables.
- Navegacion.
- Estados de pantalla.

Reglas:

- Las vistas no deben llamar directamente a red, base de datos ni servicios externos.
- Las vistas observan estado publicado por ViewModels.
- Los ViewModels reciben dependencias por inicializador.
- Los ViewModels que publiquen estado para UI deben marcarse como `@MainActor`.
- En este proyecto se usa `@Observable` para ViewModels nuevos porque el deployment target permite Observation moderna.

## Domain

Responsabilidad:

- Modelos de dominio.
- Casos de uso.
- Protocolos de repositorios.
- Reglas de negocio.

Reglas:

- No importar SwiftUI.
- No depender de detalles de red, almacenamiento o UI.
- Debe poder testearse de forma aislada.

## Data

Responsabilidad:

- Repositorios concretos.
- Data sources remotos o locales.
- DTOs.
- Mappers entre DTOs y modelos de dominio.

Reglas:

- Puede depender de `Domain`.
- No debe depender de `Presentation`.
- Los DTOs no deben filtrarse hacia las vistas.

## Core

Responsabilidad:

- Networking.
- Storage.
- Dependency injection.
- Configuracion.
- Extensiones.
- Logging.
- Design system.

Reglas:

- Evitar que `Core` se convierta en una carpeta generica sin criterio.
- Cada subcarpeta debe tener una responsabilidad clara.

## Estructura objetivo

```text
SwiftUIMVVMTemplate/
├── App/
│   ├── SwiftUIMVVMTemplateApp.swift
│   └── AppEnvironment.swift
├── Presentation/
│   ├── Views/Home/HomeView.swift
│   ├── ViewModels/Home/HomeViewModel.swift
│   ├── Components/LoadingView.swift
│   ├── Components/ErrorView.swift
│   ├── Components/EmptyStateView.swift
│   ├── Common/ViewState.swift
│   └── Navigation/
│       ├── AppRoute.swift
│       └── AppRouter.swift
├── Domain/
│   ├── Models/
│   ├── UseCases/
│   └── Protocols/
├── Data/
│   ├── Repositories/
│   ├── DataSources/
│   ├── DTOs/
│   └── Mappers/
├── Core/
│   ├── Networking/
│   ├── Storage/
│   ├── DependencyInjection/
│   ├── Configuration/
│   ├── Extensions/
│   ├── Utilities/
│   └── DesignSystem/
└── Resources/
```

Nota: los assets generados por Xcode se mantienen actualmente como `SwiftUIMVVMTemplate/Assets.xcassets`.
