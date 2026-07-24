# Recomendaciones para evolucionar SwiftUIMVVMTemplate

Última revisión: 2026-07-03

Documento de referencia analizado: `MVVM_STARTER_PROJECT_PROPOSAL.md`.

Estado de aplicación: implementado en el proyecto el 2026-07-03, salvo la validación manual mediante una segunda app independiente.

## Conclusión

La propuesta mejora claramente el esqueleto actual: lo convierte de una demostración técnica por capas en un starter reutilizable, verificable y preparado para iniciar productos reales.

La dirección recomendada es adoptarla con tres ajustes importantes:

1. Usar una arquitectura híbrida orientada por features, sin obligar a cada pantalla a tener todas las capas.
2. Separar con claridad el aislamiento de UI de los servicios y modelos al migrar a Swift 6.
3. Preferir un solo app target con configuraciones y schemes Development/Production, salvo que exista una necesidad real de targets distintos.

## Estado actual verificado

El proyecto actual ya aporta una buena base:

- SwiftUI con `@Observable` y ViewModels aislados al `MainActor`.
- Navegación tipada mediante `AppRoute` y `AppRouter`.
- Inyección por inicializador y composition root básico en `AppContainer`.
- Separación entre modelo, DTO, mapper, repositorio y caso de uso.
- Componentes para estados loading, empty y error.
- Cliente HTTP basado en `URLSession` y `async/await`.
- Tokens iniciales de color, tipografía, spacing y radios.
- Build del código correcto con firma desactivada.

En el momento del análisis se confirmaron estas carencias, resueltas posteriormente por las fases de este documento:

- Deployment target actual: iOS 26.5, demasiado restrictivo para un starter iOS 17+.
- Lenguaje actual: Swift 5, no Swift 6.
- No está configurado `SWIFT_STRICT_CONCURRENCY`.
- El módulo usa aislamiento por defecto `MainActor`, incluyendo potencialmente infraestructura que no pertenece a UI.
- Solo existe un target de aplicación; no hay target de tests.
- No existen `.xcconfig`, String Catalog, mocks ni fixtures.
- El bundle ID sigue siendo específico: `com.ankylosauruslabs.SwiftUIMVVMTemplate`.
- El build firmado falla si no existe un provisioning profile; con `CODE_SIGNING_ALLOWED=NO` compila correctamente.
- La estructura está organizada primero por capas técnicas y no por features.

## Decisiones que conviene conservar

- `@Observable` para estado observable nuevo.
- `@MainActor` para ViewModels y estado que alimenta directamente la UI.
- `NavigationStack` con rutas tipadas y una colección `[AppRoute]` fácil de probar.
- Inyección por inicializador.
- Dependencias descritas mediante protocolos cuando se necesiten mocks o implementaciones alternativas.
- DTOs separados de modelos de dominio cuando el contrato externo lo justifique.
- Componentes reutilizables pequeños y APIs modernas de SwiftUI.
- Ausencia de dependencias externas en el starter base.
- Grupo de archivos sincronizado de Xcode, que evita mantener manualmente el `project.pbxproj` al añadir Swift bajo la carpeta raíz.

## Arquitectura recomendada

Se recomienda pasar de una estructura completamente horizontal a una organización híbrida por features:

```text
SwiftUIMVVMTemplate/
├── App/
│   ├── SwiftUIMVVMTemplateApp.swift
│   ├── AppRootView.swift
│   ├── AppDependencies.swift
│   ├── AppState.swift
│   └── Navigation/
│       ├── AppRoute.swift
│       └── AppRouter.swift
├── Core/
│   ├── Components/
│   ├── DesignSystem/
│   ├── Localization/
│   ├── Logging/
│   ├── Networking/
│   └── Persistence/
├── Features/
│   ├── Home/
│   │   ├── HomeView.swift
│   │   ├── HomeViewModel.swift
│   │   ├── HomeService.swift
│   │   ├── HomeServiceLive.swift
│   │   └── HomeModels.swift
│   ├── Settings/
│   └── ExampleDetail/
├── PreviewSupport/
│   ├── Mocks/
│   └── Fixtures/
└── Resources/
    ├── Assets.xcassets
    └── Localizable.xcstrings

SwiftUIMVVMTemplateTests/
├── App/
├── Core/
└── Features/

Config/
├── Base.xcconfig
├── Development.xcconfig
├── Production.xcconfig
└── Secrets.xcconfig.example
```

### Regla de crecimiento

Una feature sencilla puede contener solo `View` y estado local. Se añade un ViewModel cuando existe lógica o estado de pantalla, un servicio cuando hay una dependencia externa y DTO/mapper/repositorio solo cuando el contrato o la lógica lo requieren.

No conviene generar automáticamente cinco capas para cada pantalla. El starter debe enseñar límites claros, no imponer archivos vacíos.

### Evitar carpetas genéricas

- No usar un `Models/` global para todos los modelos de la aplicación.
- No usar un `Services/` global como contenedor de cualquier dependencia.
- Mantener modelos y servicios específicos dentro de su feature.
- Colocar en `Core` únicamente elementos realmente compartidos y sin dependencia de una feature.

## Cambios prioritarios

### P0. Compatibilidad y configuración del proyecto

1. Cambiar el deployment target a iOS 17.0.
2. Migrar el target a Swift 6.
3. Activar Strict Concurrency en `Complete` y resolver diagnósticos sin recurrir a `@unchecked Sendable`.
4. Mantener `MainActor` como aislamiento por defecto para el app target si simplifica la UI, pero declarar límites explícitos para networking, persistencia y trabajo pesado.
5. Hacer `Sendable` los modelos, DTOs, errores y configuración que puedan cruzar dominios de aislamiento.
6. Sustituir bundle ID, team y branding específicos por valores neutrales/configurables.
7. Añadir `.xcconfig` y evitar valores de entorno escritos en Swift.

La migración a Swift 6 debe hacerse en un cambio separado de la reorganización por features para que los errores de aislamiento sean revisables.

### P0. Composition root y estado global

Sustituir `AppContainer.shared` por un valor `AppDependencies` creado en `@main` e inyectado en `AppRootView`.

Motivos:

- Elimina estado global mutable y mejora el aislamiento entre tests.
- Permite construir variantes `.live`, `.preview` y `.test` sin singletons.
- Evita que previews y tests compartan accidentalmente router, storage o cachés.

`AppState` debe contener solo estado verdaderamente global, por ejemplo sesión, onboarding o selección global. Los datos de una pantalla deben seguir perteneciendo a su ViewModel o a su feature.

También conviene mover la resolución de destinos fuera de `SwiftUIMVVMTemplateApp` hacia `AppRootView` o un componente de navegación dedicado.

### P0. Tests y mocks deterministas

Crear un target de unit tests usando Swift Testing.

Cobertura mínima recomendada:

- `AppRouterTests`: push, back y reset.
- `HomeViewModelTests`: success, empty, error, retry y cancelación.
- `APIClientTests`: request, status code, decoding, timeout y cancelación.
- Tests del mapper y de la persistencia.

Los tests no deben usar red, tiempos reales ni `Task.sleep`. El ejemplo actual puede reemplazarse por un mock inmediato o por un reloj inyectable.

Los mocks deben vivir en `PreviewSupport` si también se compilan para previews, o en el target de tests cuando solo sirven para testing.

### P0. Localización real

Crear `Localizable.xcstrings` con ES y EN.

Cambios recomendados:

- Sustituir textos hardcodeados por recursos localizados.
- Preferir `LocalizedStringResource` para valores que viajan entre capas de presentación.
- No convertir errores dinámicos arbitrarios a `LocalizedStringKey`.
- Hacer que errores y estados expongan códigos estables; la capa de presentación decide el texto localizado.
- Añadir previews en ambos idiomas y con tamaños de accesibilidad.

## Mejoras por área

### Navegación

- Mantener rutas tipadas.
- Añadir una tab bar nativa simple solo si Home y Settings forman parte del ejemplo final.
- Mantener un path por tab si cada tab tiene navegación independiente.
- Evitar poner vistas concretas o textos placeholder dentro del tipo `App`.
- Añadir deep links únicamente como módulo posterior; no son necesarios para v1.

### Estado de pantalla

`ViewState` es útil como ejemplo, pero no debería ser obligatorio para todas las pantallas.

Recomendaciones:

- Usar un estado genérico tipo `Loadable<Value>` para cargas simples.
- Usar estados específicos de feature cuando haya múltiples operaciones o estados simultáneos.
- Evitar `error(String)` como contrato principal; usar un error de presentación estable o mapear el error en el ViewModel.
- Conservar explícitamente el comportamiento de cancelación y no mostrar una alerta por una tarea cancelada.

### Networking

El `APIClient` actual es una base válida, pero necesita:

- Construcción separada de `URLRequest` para poder testearla.
- Body `Encodable` o `Data` para POST/PUT/PATCH.
- Timeout configurable.
- Política de caché configurable cuando proceda.
- Errores tipados con código estable, status code y contexto seguro.
- Propagación de `CancellationError` sin convertirlo en error genérico.
- Logs con `OSLog` y privacidad; nunca registrar tokens, cabeceras sensibles ni bodies completos.
- Decoder configurable por endpoint o por cliente.

El caso `NetworkError.unknown` debe tener un uso definido o eliminarse. `decodingFailed` no debería perder por completo el contexto útil para debug.

### Mapeo de datos

El mapper actual genera un UUID nuevo cuando el identificador remoto no es válido. Ese fallback oculta un contrato roto y produce identidad inestable.

Se recomienda:

- Lanzar un error de mapeo cuando el ID sea obligatorio.
- Conservar el ID remoto como `String` cuando UUID no sea un requisito de dominio.
- Añadir tests de valores válidos e inválidos.

### Persistencia

La abstracción actual solo guarda `String`.

Para el starter conviene ofrecer:

- Claves tipadas o namespaced.
- Lectura/escritura de valores `Codable` sencillos.
- Implementación `UserDefaults` live.
- Implementación en memoria para previews y tests.
- Errores explícitos de codificación/decodificación.

Keychain debe seguir siendo opt-in y no formar parte del núcleo inicial.

### Configuración y entornos

Se recomienda un único app target con schemes/configuraciones `Development` y `Production`.

Ventajas:

- Menos duplicación de build settings y target membership.
- Bundle ID, nombre visible, icono y base URL pueden variar por configuración.
- Sigue permitiendo instalar Development y Production a la vez usando un sufijo de bundle ID.

Crear un segundo target solo si las capabilities, entitlements o fuentes compiladas difieren de verdad.

`AppConfig` no debe usar una URL local como fallback silencioso cuando la configuración sea inválida. En Debug debe fallar de forma clara; en tests debe inyectarse explícitamente.

### Design System

Mantener el sistema pequeño, pero hacerlo semántico:

- Colores definidos en Assets con variantes Light/Dark.
- Tokens como `backgroundPrimary`, `surfaceSecondary`, `textPrimary`, `textSecondary`, `border`, `accent`, `success`, `warning` y `error`.
- Tipografía basada en estilos Dynamic Type.
- Spacing y radios limitados a una escala coherente.
- Uno o dos `ButtonStyle` de ejemplo, no una librería completa.
- Previews Light/Dark, ES/EN y tamaño de accesibilidad.

No añadir Liquid Glass como requisito del starter iOS 17; puede ofrecerse con disponibilidad y fallback en un módulo de ejemplo posterior.

### Logging

Renombrar el namespace `Logger` a `AppLog` o similar para evitar confusión con `OSLog.Logger`.

Definir categorías pequeñas (`app`, `networking`, `persistence`) y política de redacción. Los logs de red deben registrar método, host, ruta, status y duración, pero no credenciales ni payloads sensibles.

### Previews

La preview actual usa el contenedor compartido y una espera artificial. Se recomiendan previews independientes para:

- Success.
- Loading.
- Empty.
- Error.
- Light/Dark.
- ES/EN.
- Dynamic Type de accesibilidad.

Cada preview debe construir sus propias dependencias y no ejecutar red ni delays reales.

## Automatización y calidad

Aunque las capabilities de producto deben ser opt-in, una CI mínima sí aporta valor al starter.

Añadir un workflow que ejecute:

```bash
xcodebuild \
  -scheme SwiftUIMVVMTemplate \
  -project SwiftUIMVVMTemplate.xcodeproj \
  -destination 'platform=iOS Simulator,name=iPhone 16' \
  test
```

Para una validación genérica sin firma puede usarse:

```bash
xcodebuild \
  -scheme SwiftUIMVVMTemplate \
  -project SwiftUIMVVMTemplate.xcodeproj \
  -destination generic/platform=iOS \
  CODE_SIGNING_ALLOWED=NO \
  build
```

También conviene añadir:

- Auditoría básica de secretos antes de publicar releases.
- Checklist de renombrado de producto, scheme, bundle ID, display name y configuración.
- `Secrets.xcconfig.example` versionado y el archivo real ignorado.
- Opcionalmente `swift-format`, sin convertirlo en requisito para compilar el proyecto.

## Alcance recomendado para v1

La primera versión estable debería incluir:

1. iOS 17+, Swift 6 y Strict Concurrency completa.
2. Un target de app con schemes Development y Production.
3. `AppRootView`, `AppDependencies`, `AppState` y router tipado.
4. Home, Settings y ExampleDetail organizados por features.
5. Home demostrando View → ViewModel → Service protocol → Live/Mock.
6. Settings demostrando persistencia key-value.
7. Networking testeable con timeout, errores tipados y logs redactados.
8. String Catalog ES/EN.
9. Design System semántico Light/Dark.
10. Previews deterministas y target de tests con Swift Testing.
11. `.xcconfig` y secretos de ejemplo.
12. CI de build y tests sin firma ni credenciales externas.

No incluir por defecto Firebase, Keychain, Share Extension, App Intents, notificaciones, ubicación ni analítica.

## Plan de implementación recomendado

### Fase 1: Base verificable

- [x] Añadir target de tests y primeras pruebas sobre el código actual.
- [x] Añadir mocks en memoria y eliminar delays reales de previews/tests.
- [x] Añadir build sin firma a la documentación.

### Fase 2: Configuración moderna

- [x] Bajar deployment target a iOS 17.
- [x] Introducir `.xcconfig` y schemes Development/Production.
- [x] Neutralizar bundle ID, team, nombres y URLs.
- [x] Añadir String Catalog ES/EN.

### Fase 3: Swift 6

- [x] Migrar a Swift 6 en un cambio aislado.
- [x] Activar Strict Concurrency completa.
- [x] Definir límites MainActor/no UI y conformidades `Sendable`.
- [x] Ejecutar build y tests tras cada grupo de cambios.

### Fase 4: Organización por features

- [x] Introducir `AppRootView` y `AppDependencies` sin singleton.
- [x] Mover Home a `Features/Home`.
- [x] Crear Settings y ExampleDetail.
- [x] Mantener en `Core` solo infraestructura compartida.

### Fase 5: Infraestructura y experiencia de plantilla

- [x] Completar APIClient, persistencia, logging y Design System.
- [x] Añadir previews de estados, temas, idiomas y accesibilidad.
- [x] Añadir CI y auditoría de secretos.
- [ ] Validar el starter creando una segunda app pequeña; el checklist de renombrado ya está creado.

## Criterios de aceptación revisados

- Clonar y compilar no requiere cuenta de desarrollo, firma ni credenciales.
- El proyecto compila con iOS 17+ y Swift 6 Strict Concurrency.
- Development y Production se configuran sin duplicación innecesaria.
- Ninguna dependencia de infraestructura queda aislada accidentalmente al MainActor.
- Home demuestra una operación live y sus variantes mock.
- Settings demuestra persistencia intercambiable.
- Navegación, ViewModel, networking, mapper y storage tienen tests sin red.
- Todos los textos visibles del ejemplo están disponibles en ES y EN.
- Light/Dark y Dynamic Type funcionan en previews.
- Los logs no exponen secretos ni datos sensibles.
- Añadir una feature sencilla no obliga a crear capas o archivos vacíos.
- README, arquitectura, checklist y documentación de adopción reflejan el estado real.

## Decisión recomendada

Aprobar la propuesta como dirección general y usar este documento como ajuste técnico. La prioridad inicial no debería ser añadir más componentes, sino asegurar configuración neutral, Swift 6, tests, localización y dependencias deterministas. Después de eso, la reorganización por features será más segura y fácil de validar.
