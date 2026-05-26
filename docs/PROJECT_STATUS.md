# Estado del proyecto

Fecha de preparacion documental: 2026-05-26.

## Datos detectados

- Proyecto: `SwiftUIMVVMTemplate`.
- Target: `SwiftUIMVVMTemplate`.
- Scheme: `SwiftUIMVVMTemplate`.
- Framework de UI: SwiftUI.
- Archivo principal: `SwiftUIMVVMTemplate/App/SwiftUIMVVMTemplateApp.swift`.
- Vista inicial actual: `SwiftUIMVVMTemplate/Presentation/Views/Home/HomeView.swift`.
- Documento de origen: `DOCUMENTACION_ESQUELETO_IOS.md`.
- Repositorio Git: no inicializado en el momento de esta preparacion.
- Proyecto Xcode con `PBXFileSystemSynchronizedRootGroup`; los archivos bajo `SwiftUIMVVMTemplate/` se sincronizan sin editar manualmente `project.pbxproj`.

## Estructura actual

```text
SwiftUIMVVMTemplate/
├── App/
├── Core/
├── Data/
├── Domain/
├── Presentation/
└── Assets.xcassets

SwiftUIMVVMTemplate.xcodeproj/
└── project.pbxproj
```

## Estado funcional

- El proyecto ya tiene una base SwiftUI + MVVM por capas.
- No existe target de tests detectado.
- No se han anadido dependencias externas.
- Build verificado con `xcodebuild -scheme SwiftUIMVVMTemplate -project SwiftUIMVVMTemplate.xcodeproj -destination generic/platform=iOS build`.

## Proxima accion recomendada

Crear un target de tests cuando se quiera empezar a validar ViewModels, UseCases y Repositories de forma automatizada.
