# SwiftUIMVVMTemplate

Proyecto iOS base creado con Xcode y SwiftUI. La intencion del repositorio es evolucionar hacia un esqueleto limpio con arquitectura MVVM, separacion por capas y una estructura facil de mantener.

## Estado actual

- Nombre del proyecto: `SwiftUIMVVMTemplate`.
- Target principal: `SwiftUIMVVMTemplate`.
- Scheme principal: `SwiftUIMVVMTemplate`.
- Punto de entrada actual: `SwiftUIMVVMTemplate/App/SwiftUIMVVMTemplateApp.swift`.
- UI actual: SwiftUI con `HomeView`.
- Arquitectura base MVVM implementada con capas `App`, `Presentation`, `Domain`, `Data` y `Core`.
- No existe target de tests todavia.

## Documentacion

La guia original se conserva en `DOCUMENTACION_ESQUELETO_IOS.md`. Para trabajar de forma mas comoda, la informacion operativa esta separada en:

- `docs/PROJECT_STATUS.md`: estado actual y decisiones ya detectadas.
- `docs/ARCHITECTURE.md`: arquitectura objetivo SwiftUI + MVVM.
- `docs/IMPLEMENTATION_CHECKLIST.md`: fases y tareas marcables.
- `docs/CODEX_INSTRUCTIONS.md`: reglas que Codex debe seguir al programar.
- `docs/FEATURE_GUIDE.md`: patron para anadir nuevas features.
- `docs/GITHUB_WORKFLOW.md`: checklist antes de subir cambios a GitHub.

## Arquitectura objetivo

La estructura base separa responsabilidades en estas capas:

```text
App
Presentation
Domain
Data
Core
Resources
Tests
```

Resumen rapido:

- `App`: punto de entrada, entorno global y composicion inicial.
- `Presentation`: vistas SwiftUI, ViewModels, componentes y navegacion.
- `Domain`: modelos, casos de uso y protocolos de repositorios.
- `Data`: repositorios concretos, DTOs, data sources y mappers.
- `Core`: networking, storage, inyeccion de dependencias, configuracion, utilidades y design system.
- `Resources`: assets, localizacion y recursos visuales.

## Estructura principal

```text
SwiftUIMVVMTemplate/
├── App/
├── Core/
│   ├── Configuration/
│   ├── DependencyInjection/
│   ├── DesignSystem/
│   ├── Extensions/
│   ├── Networking/
│   ├── Storage/
│   └── Utilities/
├── Data/
│   ├── DTOs/
│   ├── DataSources/
│   ├── Mappers/
│   └── Repositories/
├── Domain/
│   ├── Models/
│   ├── Protocols/
│   └── UseCases/
├── Presentation/
│   ├── Common/
│   ├── Components/
│   ├── Navigation/
│   ├── ViewModels/
│   └── Views/
└── Assets.xcassets
```

## Como anadir una feature

1. Crear el modelo en `Domain/Models`.
2. Crear el protocolo de repositorio en `Domain/Protocols`.
3. Crear el caso de uso en `Domain/UseCases`.
4. Crear DTO, data source, mapper y repositorio concreto en `Data`.
5. Crear ViewModel y View en `Presentation`.
6. Registrar la composicion de dependencias en `Core/DependencyInjection/AppContainer.swift`.
7. Anadir una ruta en `Presentation/Navigation/AppRoute.swift` si hay navegacion.
8. Actualizar tests cuando exista target de tests.

## Flujo recomendado

1. Revisar `docs/PROJECT_STATUS.md`.
2. Seguir las fases de `docs/IMPLEMENTATION_CHECKLIST.md`.
3. Marcar cada tarea completada en el checklist.
4. Mantener las reglas de `docs/CODEX_INSTRUCTIONS.md`.
5. Antes de subir cambios a GitHub, actualizar este `README.md` y cualquier documento de `docs/` que haya quedado desfasado.

## Validacion

Cuando se hagan cambios de codigo, comprobar que el proyecto compila:

```bash
xcodebuild -scheme SwiftUIMVVMTemplate -project SwiftUIMVVMTemplate.xcodeproj -destination generic/platform=iOS build
```

Si se anaden tests en el futuro, ejecutar tambien el esquema de tests correspondiente.
