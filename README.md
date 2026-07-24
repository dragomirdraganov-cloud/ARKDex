# SwiftUIMVVMTemplate

Starter iOS reutilizable con SwiftUI y MVVM pragmático, organizado por features y preparado para comenzar una aplicación sin credenciales externas.

## Requisitos

- Xcode con soporte para Swift 6.
- iOS 17 o posterior.

## Incluye

- Swift 6 y Strict Concurrency completa.
- `@Observable` y ViewModels aislados al `MainActor`.
- Composition root sin singletons globales.
- Navegación tipada y tab bar Home/Settings.
- Networking con `URLSession`, errores tipados, timeout y logs redactados.
- Persistencia key-value live e in-memory.
- String Catalog ES/EN.
- Design System semántico con la paleta del producto.
- Tipografía Montserrat variable con soporte para Dynamic Type.
- Home inicial con buscador centrado y sugerencias adaptables al contenido.
- Previews deterministas.
- Tests con Swift Testing.
- Configuraciones Development/Production mediante `.xcconfig`.
- CI, auditoría básica de secretos y checklist de renombrado.

## Estructura

```text
SwiftUIMVVMTemplate/
├── App/
│   └── Navigation/
├── Core/
│   ├── Components/
│   ├── DesignSystem/
│   ├── Logging/
│   ├── Networking/
│   └── Persistence/
├── Features/
│   ├── Home/
│   ├── Settings/
│   └── ExampleDetail/
├── PreviewSupport/
└── Resources/

SwiftUIMVVMTemplateTests/
├── App/
├── Core/
└── Features/

Config/
Scripts/
```

## Schemes

- `SwiftUIMVVMTemplate-Development`: configuración Debug, bundle `.dev` y servicio Home mock para funcionar sin red.
- `SwiftUIMVVMTemplate-Production`: configuración Release y ejemplo remoto basado en `API_BASE_URL`.

Los valores se encuentran en `Config/Development.xcconfig` y `Config/Production.xcconfig`.

## Validación

Validación completa usando un simulador disponible:

```bash
bash Scripts/validate-template.sh 'platform=iOS Simulator,name=iPhone 16,OS=latest'
```

Build sin firma:

```bash
xcodebuild \
  -scheme SwiftUIMVVMTemplate-Development \
  -project SwiftUIMVVMTemplate.xcodeproj \
  -destination generic/platform=iOS \
  CODE_SIGNING_ALLOWED=NO \
  build
```

Tests:

```bash
xcodebuild \
  -scheme SwiftUIMVVMTemplate-Development \
  -project SwiftUIMVVMTemplate.xcodeproj \
  -destination 'platform=iOS Simulator,name=iPhone 16,OS=latest' \
  test
```

## Configuración sensible

El starter no contiene secretos. Si una aplicación necesita configuración local:

1. Copiar `Config/Secrets.xcconfig.example` como `Config/Secrets.xcconfig`.
2. Añadir allí únicamente valores locales.
3. No subir `Secrets.xcconfig` a Git.

Antes de publicar cambios:

```bash
bash Scripts/check-secrets.sh
```

## Crear una feature

Mantener View, ViewModel, servicios y modelos específicos dentro de `Features/FeatureName`. Añadir capas solo cuando exista una responsabilidad real. Consultar `docs/FEATURE_GUIDE.md`.

## Documentación

- `MVVM_STARTER_PROJECT_PROPOSAL.md`: propuesta de evolución recibida.
- `MVVM_STARTER_PROJECT_RECOMMENDATIONS.md`: análisis técnico y plan aplicado.
- `docs/ARCHITECTURE.md`: límites y decisiones de arquitectura.
- `docs/IMPLEMENTATION_CHECKLIST.md`: estado de las cinco fases.
- `docs/FEATURE_GUIDE.md`: patrón para nuevas features.
- `docs/RENAME_CHECKLIST.md`: pasos para adoptar el starter.
- `docs/GITHUB_WORKFLOW.md`: validaciones antes de subir cambios.
- `docs/CODEX_INSTRUCTIONS.md`: reglas operativas para futuros cambios.

Antes de subir cambios a GitHub, actualizar este README y los documentos afectados para que describan el código real.
