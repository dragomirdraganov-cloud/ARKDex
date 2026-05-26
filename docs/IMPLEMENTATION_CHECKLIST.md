# Checklist de implementacion

Este archivo es el punto de control principal. Cada tarea completada debe marcarse aqui durante el desarrollo.

## Fase 1: Analizar proyecto existente

- [x] Detectar el nombre real del proyecto: `SwiftUIMVVMTemplate`.
- [x] Identificar el archivo `App.swift` principal: `SwiftUIMVVMTemplate/App/SwiftUIMVVMTemplateApp.swift`.
- [x] Confirmar si el proyecto usa SwiftUI.
- [x] Revisar estructura actual generada por Xcode.
- [x] No eliminar archivos necesarios del proyecto durante la preparacion documental.

## Fase 2: Crear estructura de carpetas

- [x] Crear carpeta `App`.
- [x] Crear carpeta `Presentation`.
- [x] Crear subcarpetas `Views`, `ViewModels`, `Components`, `Navigation` y `Common`.
- [x] Crear carpeta `Domain`.
- [x] Crear subcarpetas `Models`, `UseCases`, `Protocols`.
- [x] Crear carpeta `Data`.
- [x] Crear subcarpetas `Repositories`, `DataSources`, `DTOs`, `Mappers`.
- [x] Crear carpeta `Core`.
- [x] Crear subcarpetas `Networking`, `Storage`, `DependencyInjection`, `Configuration`, `Extensions`, `Utilities`, `DesignSystem`.
- [x] Mantener assets existentes.

## Fase 3: Crear base de Presentation

- [x] Crear `HomeView.swift`.
- [x] Crear `HomeViewModel.swift`.
- [x] Crear `LoadingView.swift`.
- [x] Crear `ErrorView.swift`.
- [x] Crear `EmptyStateView.swift`.
- [x] Crear `ViewState.swift`.

## Fase 4: Crear navegacion base

- [x] Crear `AppRoute.swift`.
- [x] Crear `AppRouter.swift`.
- [x] Preparar `NavigationStack` si encaja con la estructura final.

## Fase 5: Crear Core base

- [x] Crear `AppContainer.swift`.
- [x] Crear `AppConfig.swift`.
- [x] Crear `Environment.swift`.
- [x] Crear `APIClient.swift`.
- [x] Crear `APIEndpoint.swift`.
- [x] Crear `NetworkError.swift`.
- [x] Crear `LocalStorage.swift` como placeholder simple.
- [x] Crear `Logger.swift` simple.
- [x] Crear `AppColors.swift`.
- [x] Crear `AppSpacing.swift`.
- [x] Crear `AppTypography.swift`.
- [x] Crear `AppTheme.swift`.

## Fase 6: Crear Domain y Data de ejemplo

- [x] Crear `ExampleModel.swift`.
- [x] Crear `ExampleRepositoryProtocol.swift`.
- [x] Crear `ExampleUseCase.swift`.
- [x] Crear `ExampleDTO.swift`.
- [x] Crear `ExampleMapper.swift`.
- [x] Crear `ExampleRepository.swift`.
- [x] Mantener el ejemplo minimo para no contaminar el proyecto.

## Fase 7: Integrar app

- [x] Actualizar el archivo principal de la app para usar `AppContainer`.
- [x] Mostrar `HomeView` como pantalla inicial.
- [x] Verificar que la app compila.
- [x] Corregir imports necesarios.
- [x] Eliminar o adaptar `ContentView.swift` si existe.

## Fase 8: Testing inicial

- [x] No se creo test basico porque no existe target de tests.
- [x] No se crearon mocks porque no existe target de tests.
- [x] No forzar testing si el proyecto no tiene target de tests, salvo que se pida explicitamente.

## Fase 9: Documentacion dentro del repositorio

- [x] Crear `README.md`.
- [x] Documentar estructura de carpetas.
- [x] Documentar reglas de arquitectura.
- [x] Documentar como anadir una nueva feature.
- [x] Documentar convenciones de nombres.
- [x] Anadir instruccion para actualizar README y docs antes de subir cambios a GitHub.

## Criterios de aceptacion finales

- [x] La app compila.
- [x] La pantalla inicial se muestra correctamente.
- [x] Existe separacion clara entre `Presentation`, `Domain`, `Data` y `Core`.
- [x] Las vistas no contienen logica de negocio.
- [x] Los ViewModels pueden testearse.
- [x] No hay dependencias externas anadidas.
- [x] El README explica como trabajar con la arquitectura.
- [x] La estructura permite anadir nuevas features siguiendo un patron repetible.
