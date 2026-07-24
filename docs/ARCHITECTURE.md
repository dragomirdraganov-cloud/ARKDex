# Arquitectura de ARKDex

## Principios

- MVVM pragmático orientado por features.
- Estado local para interacción puramente visual.
- ViewModel cuando existe lógica o estado de pantalla.
- Dependencias externas detrás de contratos sustituibles.
- Modelos de dominio independientes del formato remoto.
- Swift 6 y límites de aislamiento explícitos.

## App

`ARKDexApp` construye `AppDependencies` y presenta `AppRootView`.

`AppRootView` posee el estado global mínimo:

- Tab seleccionada.
- Rutas de navegación.
- ViewModels raíz que realmente lo requieran.

Los datos de criaturas no deben almacenarse en `AppState`.

## Features

La estructura actual incluye Home, Settings y un detalle de ejemplo. La evolución de producto debe introducir una feature de criaturas sin convertir `Core` en un contenedor genérico.

Estructura prevista:

```text
ARKDex/Features/
├── Home/
├── Creatures/
│   ├── CreatureModels.swift
│   ├── CreatureRepository.swift
│   ├── CreatureSearchView.swift
│   ├── CreatureSearchViewModel.swift
│   └── CreatureDetailView.swift
└── Settings/
```

## Datos de criaturas

El límite de datos debe:

- Proporcionar identidad estable.
- Validar campos obligatorios.
- Representar ausencias explícitamente.
- Conservar fuente o versión cuando sea necesario.
- Permitir implementación mock, local y remota.

No se deben inventar estadísticas de ARK ni ocultar errores de mapeo con valores aleatorios.

## Core

- `Components`: estados visuales compartidos.
- `DesignSystem`: colores, Montserrat, spacing y estilos.
- `Logging`: categorías y redacción.
- `Networking`: requests, transporte y errores HTTP.
- `Persistence`: almacenamiento intercambiable.

Core no conoce features.

## Concurrencia

- UI y ViewModels: `@MainActor`.
- Modelos y contratos cruzados: `Sendable`.
- Networking y persistencia: fuera del actor de UI.
- Cancelación propagada como cancelación.
- Sin `Task.detached`, `@unchecked Sendable` o aislamiento inseguro salvo justificación documentada.

## Configuración

- `ARKDex-Development` usa Debug y datos deterministas.
- `ARKDex-Production` usa Release y configuración externa.
- El endpoint actual es un placeholder hasta seleccionar una fuente aprobada.

## Testing

`ARKDexTests` usa Swift Testing. Las pruebas no dependen de red ni de esperas reales.

La futura capa de criaturas deberá cubrir búsqueda, identidad, mapeo, datos ausentes y errores de fuente.
