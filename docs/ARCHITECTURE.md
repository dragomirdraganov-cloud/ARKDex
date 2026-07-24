# Arquitectura

## Principios

- MVVM pragmático orientado por features.
- Las vistas declaran UI y delegan lógica de pantalla.
- Los ViewModels usan `@Observable` y `@MainActor`.
- Networking y persistencia no pertenecen al MainActor.
- Las dependencias se inyectan por inicializador.
- Los protocolos se introducen cuando permiten sustituir una dependencia o expresar un límite real.
- No se crean capas o archivos vacíos por convención.

## App

`AppDependencies` es el composition root. Construye servicios live, mocks y almacenamiento, pero no es un singleton.

`AppRootView` posee:

- `AppState` para selección global de tab.
- `AppRouter` para paths tipados.
- El ViewModel raíz de Settings.

La búsqueda inicial de Home mantiene su texto como estado local de vista hasta que exista una fuente real de resultados.

`AppState` solo debe incorporar estado verdaderamente global.

## Features

Cada feature contiene sus vistas, ViewModels, servicios y modelos específicos.

```text
Features/Home/
├── HomeView.swift
├── HomeViewModel.swift
├── HomeModels.swift
├── HomeService.swift
└── HomeServiceLive.swift
```

Una pantalla sin estado o lógica no necesita ViewModel. DTOs y mappers pueden vivir dentro de la implementación del servicio mientras no sean compartidos.

## Core

`Core` contiene únicamente infraestructura transversal:

- `Components`: estados visuales reutilizables.
- `DesignSystem`: tokens y estilos semánticos.
- `Logging`: categorías OSLog y política de privacidad.
- `Networking`: endpoint, request builder, transport y cliente HTTP.
- `Persistence`: almacenamiento key-value intercambiable.

Core no debe importar ni conocer features.

## Concurrencia

- Swift 6 con Strict Concurrency completa.
- UI y ViewModels están aislados explícitamente al `MainActor`.
- Servicios, modelos, DTOs, errores y configuración usan límites `Sendable`.
- `APIClient` es un actor para proteger decoder y transporte.
- Stores mutables son actors.
- La cancelación se propaga y no se convierte en error visual genérico.
- No se usa `Task.detached` ni `@unchecked Sendable`.

## Configuración

El proyecto usa un target de app y dos schemes:

- Development → Debug → `Development.xcconfig`.
- Production → Release → `Production.xcconfig`.

Bundle ID, nombre visible, entorno y base URL cambian por configuración. Un segundo target solo se justifica si cambian capabilities, entitlements o fuentes compiladas.

## Testing

El target `SwiftUIMVVMTemplateTests` utiliza Swift Testing. Los tests no acceden a red ni esperan tiempo real.

Cobertura base:

- Router.
- HomeViewModel success/empty/error/retry.
- APIClient y URLRequestBuilder.
- Persistencia in-memory.
- SettingsViewModel.
