# Documentación para generar un esqueleto iOS con SwiftUI + MVVM

> **Documento archivado.** Describe la primera versión por capas del starter. Para cambios nuevos usar `README.md`, `docs/ARCHITECTURE.md`, `docs/CODEX_INSTRUCTIONS.md` y `docs/IMPLEMENTATION_CHECKLIST.md`. La arquitectura vigente está organizada por features y usa iOS 17, Swift 6 y Strict Concurrency completa.

## 1. Objetivo

Crear una estructura base para un proyecto iOS generado desde Xcode usando SwiftUI, organizada con arquitectura MVVM, preparada para crecer de forma ordenada y fácil de mantener.

Esta documentación está pensada para servir como contexto a Codex cuando se le pida modificar un proyecto iOS default y convertirlo en una base limpia para futuras aplicaciones.

## 2. Suposiciones iniciales

- Proyecto iOS creado previamente desde Xcode.
- Interfaz usando SwiftUI.
- Lenguaje Swift.
- Arquitectura principal: MVVM.
- No se asume backend concreto.
- No se asume persistencia concreta.
- No se usará UIKit salvo que sea necesario.
- El proyecto debe compilar después de aplicar los cambios.
- La estructura debe ser simple, clara y extensible.

## 3. Objetivos de arquitectura

La arquitectura debe permitir:

- Separar vistas, lógica de presentación, modelos y servicios.
- Evitar lógica de negocio directamente dentro de las vistas SwiftUI.
- Facilitar testing de ViewModels y servicios.
- Facilitar el crecimiento del proyecto sin mezclar responsabilidades.
- Mantener nombres consistentes y fáciles de entender.
- Centralizar constantes, configuración, estilos y utilidades comunes.

## 4. Arquitectura propuesta

La arquitectura base será MVVM con separación por capas:

```text
App
├── Presentation
│   ├── Views
│   ├── ViewModels
│   ├── Components
│   └── Navigation
│
├── Domain
│   ├── Models
│   ├── UseCases
│   └── Protocols
│
├── Data
│   ├── Repositories
│   ├── DataSources
│   ├── DTOs
│   └── Mappers
│
├── Core
│   ├── Networking
│   ├── Storage
│   ├── DependencyInjection
│   ├── Configuration
│   ├── Extensions
│   ├── Utilities
│   └── DesignSystem
│
└── Resources
```

## 5. Estructura de carpetas recomendada

```text
ProjectName/
├── App/
│   ├── ProjectNameApp.swift
│   └── AppEnvironment.swift
│
├── Presentation/
│   ├── Views/
│   │   └── Home/
│   │       └── HomeView.swift
│   │
│   ├── ViewModels/
│   │   └── Home/
│   │       └── HomeViewModel.swift
│   │
│   ├── Components/
│   │   ├── LoadingView.swift
│   │   ├── ErrorView.swift
│   │   └── EmptyStateView.swift
│   │
│   └── Navigation/
│       ├── AppRoute.swift
│       └── AppRouter.swift
│
├── Domain/
│   ├── Models/
│   │   └── ExampleModel.swift
│   │
│   ├── UseCases/
│   │   └── ExampleUseCase.swift
│   │
│   └── Protocols/
│       └── ExampleRepositoryProtocol.swift
│
├── Data/
│   ├── Repositories/
│   │   └── ExampleRepository.swift
│   │
│   ├── DataSources/
│   │   ├── RemoteExampleDataSource.swift
│   │   └── LocalExampleDataSource.swift
│   │
│   ├── DTOs/
│   │   └── ExampleDTO.swift
│   │
│   └── Mappers/
│       └── ExampleMapper.swift
│
├── Core/
│   ├── Networking/
│   │   ├── APIClient.swift
│   │   ├── APIEndpoint.swift
│   │   └── NetworkError.swift
│   │
│   ├── Storage/
│   │   └── LocalStorage.swift
│   │
│   ├── DependencyInjection/
│   │   └── AppContainer.swift
│   │
│   ├── Configuration/
│   │   ├── AppConfig.swift
│   │   └── Environment.swift
│   │
│   ├── Extensions/
│   │   ├── View+Extensions.swift
│   │   └── String+Extensions.swift
│   │
│   ├── Utilities/
│   │   └── Logger.swift
│   │
│   └── DesignSystem/
│       ├── AppColors.swift
│       ├── AppSpacing.swift
│       ├── AppTypography.swift
│       └── AppTheme.swift
│
├── Resources/
│   ├── Assets.xcassets
│   ├── Localizable.xcstrings
│   └── Preview Content/
│
└── Tests/
    ├── ViewModels/
    ├── UseCases/
    └── Repositories/
```

## 6. Responsabilidades por capa

### 6.1 App

Contiene el punto de entrada de la aplicación y la configuración global inicial.

Responsabilidades:

- Inicializar dependencias principales.
- Crear el contenedor de dependencias.
- Definir la vista raíz.
- Configurar el entorno global de la app.

Archivos esperados:

- `ProjectNameApp.swift`
- `AppEnvironment.swift`

### 6.2 Presentation

Contiene todo lo relacionado con la interfaz y la lógica de presentación.

Responsabilidades:

- Vistas SwiftUI.
- ViewModels.
- Componentes reutilizables.
- Navegación.
- Estados de pantalla.

Reglas:

- Las vistas no deben hacer llamadas directas a red, base de datos o servicios externos.
- Las vistas observan el estado expuesto por los ViewModels.
- Los ViewModels no deben depender directamente de implementaciones concretas si existe un protocolo.

### 6.3 Domain

Contiene la lógica de negocio independiente de la interfaz y de los detalles técnicos.

Responsabilidades:

- Modelos de dominio.
- Casos de uso.
- Protocolos de repositorios.
- Reglas de negocio.

Reglas:

- No debe importar SwiftUI.
- No debe depender de detalles de red, almacenamiento o frameworks de UI.
- Debe poder testearse de forma aislada.

### 6.4 Data

Contiene implementaciones concretas para obtener, guardar y transformar datos.

Responsabilidades:

- Repositorios concretos.
- Data sources remotos o locales.
- DTOs.
- Mappers entre DTOs y modelos de dominio.

Reglas:

- Puede depender de `Domain`.
- No debe depender de `Presentation`.
- Los DTOs no deben filtrarse hacia las vistas.

### 6.5 Core

Contiene utilidades y piezas transversales reutilizables.

Responsabilidades:

- Networking.
- Storage.
- Dependency injection.
- Configuración.
- Extensiones.
- Logging.
- Design system.

Reglas:

- Debe evitar convertirse en una carpeta genérica sin criterio.
- Cada subcarpeta debe tener una responsabilidad clara.

## 7. Convenciones de nombres

### Vistas

```text
FeatureNameView.swift
```

Ejemplo:

```text
HomeView.swift
ProfileView.swift
SettingsView.swift
```

### ViewModels

```text
FeatureNameViewModel.swift
```

Ejemplo:

```text
HomeViewModel.swift
ProfileViewModel.swift
SettingsViewModel.swift
```

### Casos de uso

```text
ActionEntityUseCase.swift
```

Ejemplo:

```text
FetchUserProfileUseCase.swift
UpdateSettingsUseCase.swift
```

### Repositorios

Protocolo:

```text
EntityRepositoryProtocol.swift
```

Implementación:

```text
EntityRepository.swift
```

Ejemplo:

```text
UserRepositoryProtocol.swift
UserRepository.swift
```

### DTOs

```text
EntityDTO.swift
```

Ejemplo:

```text
UserDTO.swift
```

### Mappers

```text
EntityMapper.swift
```

Ejemplo:

```text
UserMapper.swift
```

## 8. Estado de pantalla recomendado

Usar un estado común para representar carga, éxito, vacío y error.

Ejemplo:

```swift
enum ViewState<Content> {
    case idle
    case loading
    case success(Content)
    case empty
    case error(String)
}
```

Este estado puede colocarse en:

```text
Core/Utilities/ViewState.swift
```

o en:

```text
Presentation/Common/ViewState.swift
```

Decisión recomendada: colocarlo en `Presentation/Common` si solo se usa en UI.

## 9. Ejemplo base de MVVM

### HomeViewModel

```swift
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var state: ViewState<String> = .idle

    func load() async {
        state = .loading

        do {
            // Simulación inicial. Sustituir por caso de uso real cuando exista.
            try await Task.sleep(nanoseconds: 300_000_000)
            state = .success("Home loaded")
        } catch {
            state = .error("No se pudo cargar la información")
        }
    }
}
```

### HomeView

```swift
import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        content
            .task {
                await viewModel.load()
            }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .idle:
            EmptyView()
        case .loading:
            LoadingView()
        case .success(let text):
            Text(text)
        case .empty:
            EmptyStateView(message: "No hay información disponible")
        case .error(let message):
            ErrorView(message: message)
        }
    }
}
```

## 10. Inyección de dependencias

Para una base simple, usar un contenedor manual.

```swift
final class AppContainer {
    static let shared = AppContainer()

    private init() {}

    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel()
    }
}
```

Uso en la app:

```swift
import SwiftUI

@main
struct ProjectNameApp: App {
    private let container = AppContainer.shared

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: container.makeHomeViewModel())
        }
    }
}
```

Regla inicial:

- No usar librerías externas de dependency injection en el esqueleto base.
- Mantener la inyección explícita por inicializador.
- Evitar singletons salvo para el contenedor raíz inicial.

## 11. Navegación

Para un esqueleto inicial, usar un router sencillo basado en rutas tipadas.

```swift
enum AppRoute: Hashable {
    case home
    case detail(id: String)
}
```

```swift
@MainActor
final class AppRouter: ObservableObject {
    @Published var path: [AppRoute] = []

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func goBack() {
        _ = path.popLast()
    }

    func reset() {
        path.removeAll()
    }
}
```

Reglas:

- Evitar navegación con strings.
- Mantener rutas tipadas.
- No meter lógica de negocio en el router.

## 12. Networking base

Crear una base mínima pero funcional para futuras llamadas HTTP.

Archivos:

```text
Core/Networking/APIClient.swift
Core/Networking/APIEndpoint.swift
Core/Networking/NetworkError.swift
```

### APIEndpoint

```swift
import Foundation

protocol APIEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem] { get }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
```

### NetworkError

```swift
enum NetworkError: Error, Equatable {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(statusCode: Int)
    case unknown
}
```

### APIClient

```swift
import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T
}

final class APIClient: APIClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func request<T: Decodable>(_ endpoint: APIEndpoint) async throws -> T {
        var components = URLComponents(
            url: endpoint.baseURL.appendingPathComponent(endpoint.path),
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}
```

## 13. Design system base

Crear una estructura mínima para evitar valores mágicos repetidos.

```swift
import SwiftUI

enum AppSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}
```

```swift
import SwiftUI

enum AppTypography {
    static let title = Font.title.bold()
    static let headline = Font.headline
    static let body = Font.body
    static let caption = Font.caption
}
```

```swift
import SwiftUI

enum AppColors {
    static let primary = Color.accentColor
    static let background = Color(.systemBackground)
    static let secondaryBackground = Color(.secondarySystemBackground)
}
```

## 14. Localización

Preparar el proyecto para localización aunque solo exista un idioma inicialmente.

Recomendaciones:

- Usar `Localizable.xcstrings`.
- Evitar textos hardcodeados en vistas finales.
- Permitir que los componentes acepten strings desde fuera.

Ejemplo:

```swift
Text("home.title")
```

## 15. Testing

El esqueleto debe estar preparado para tests, aunque no se creen tests exhaustivos desde el primer commit.

Prioridades:

1. Tests de ViewModels.
2. Tests de UseCases.
3. Tests de Repositories con mocks.
4. Tests de mappers.

Estructura sugerida:

```text
ProjectNameTests/
├── ViewModels/
│   └── HomeViewModelTests.swift
├── UseCases/
├── Repositories/
└── Mocks/
```

Reglas:

- Los ViewModels deben recibir dependencias por inicializador.
- Las dependencias deben estar representadas por protocolos cuando sea necesario.
- Evitar llamadas reales de red en tests.

## 16. Reglas de calidad

Codex debe respetar estas reglas al generar la estructura:

- El proyecto debe compilar.
- No introducir dependencias externas sin permiso explícito.
- No crear código innecesariamente complejo.
- No añadir backend ficticio salvo mocks simples.
- No mezclar lógica de negocio dentro de SwiftUI Views.
- No usar nombres genéricos poco claros como `Manager` salvo que esté justificado.
- No usar force unwraps innecesarios.
- Preferir `async/await` frente a callbacks.
- Preferir `final class` para ViewModels y servicios cuando no se espere herencia.
- Marcar ViewModels como `@MainActor` cuando publiquen estado para la UI.
- Mantener archivos pequeños y con una responsabilidad clara.

## 17. Especificación funcional inicial

La app base debe incluir una pantalla inicial `HomeView` que permita verificar que la estructura funciona.

La pantalla inicial debe:

- Mostrar estado de carga.
- Mostrar contenido de ejemplo.
- Mostrar estado de error si el ViewModel lo indica.
- Usar un ViewModel inyectado desde el contenedor.
- No depender directamente de servicios externos.

## 18. Tareas para Codex

### Fase 1: Analizar proyecto existente

- [ ] Detectar el nombre real del proyecto.
- [ ] Identificar el archivo `App.swift` principal.
- [ ] Confirmar si el proyecto usa SwiftUI.
- [ ] Revisar estructura actual generada por Xcode.
- [ ] No eliminar archivos necesarios del proyecto.

### Fase 2: Crear estructura de carpetas

- [ ] Crear carpeta `App`.
- [ ] Crear carpeta `Presentation`.
- [ ] Crear subcarpetas `Views`, `ViewModels`, `Components`, `Navigation`.
- [ ] Crear carpeta `Domain`.
- [ ] Crear subcarpetas `Models`, `UseCases`, `Protocols`.
- [ ] Crear carpeta `Data`.
- [ ] Crear subcarpetas `Repositories`, `DataSources`, `DTOs`, `Mappers`.
- [ ] Crear carpeta `Core`.
- [ ] Crear subcarpetas `Networking`, `Storage`, `DependencyInjection`, `Configuration`, `Extensions`, `Utilities`, `DesignSystem`.
- [ ] Mantener `Resources` o assets existentes.

### Fase 3: Crear base de Presentation

- [ ] Crear `HomeView.swift`.
- [ ] Crear `HomeViewModel.swift`.
- [ ] Crear `LoadingView.swift`.
- [ ] Crear `ErrorView.swift`.
- [ ] Crear `EmptyStateView.swift`.
- [ ] Crear `ViewState.swift`.

### Fase 4: Crear navegación base

- [ ] Crear `AppRoute.swift`.
- [ ] Crear `AppRouter.swift`.
- [ ] Preparar `NavigationStack` si encaja con la estructura actual.

### Fase 5: Crear Core base

- [ ] Crear `AppContainer.swift`.
- [ ] Crear `AppConfig.swift`.
- [ ] Crear `Environment.swift`.
- [ ] Crear `APIClient.swift`.
- [ ] Crear `APIEndpoint.swift`.
- [ ] Crear `NetworkError.swift`.
- [ ] Crear `LocalStorage.swift` como placeholder simple.
- [ ] Crear `Logger.swift` simple.
- [ ] Crear archivos base de design system.

### Fase 6: Crear Domain y Data de ejemplo

- [ ] Crear `ExampleModel.swift`.
- [ ] Crear `ExampleRepositoryProtocol.swift`.
- [ ] Crear `ExampleUseCase.swift`.
- [ ] Crear `ExampleDTO.swift`.
- [ ] Crear `ExampleMapper.swift`.
- [ ] Crear `ExampleRepository.swift`.
- [ ] Mantener el ejemplo mínimo para no contaminar el proyecto.

### Fase 7: Integrar app

- [ ] Actualizar el archivo principal de la app para usar `AppContainer`.
- [ ] Mostrar `HomeView` como pantalla inicial.
- [ ] Verificar que la app compila.
- [ ] Corregir imports necesarios.
- [ ] Eliminar o adaptar `ContentView.swift` si existe.

### Fase 8: Testing inicial

- [ ] Crear test básico para `HomeViewModel` si existe target de tests.
- [ ] Crear mocks si son necesarios.
- [ ] No forzar testing si el proyecto no tiene target de tests, salvo que se pida explícitamente.

### Fase 9: Documentación dentro del repositorio

- [ ] Crear o actualizar `README.md`.
- [ ] Documentar estructura de carpetas.
- [ ] Documentar reglas de arquitectura.
- [ ] Documentar cómo añadir una nueva feature.
- [ ] Documentar convenciones de nombres.

## 19. Prompt para Codex

```text
Quiero que transformes este proyecto iOS default de Xcode en un esqueleto base usando SwiftUI + MVVM.

Objetivo:
Crear una estructura limpia, mantenible y preparada para crecer, sin añadir dependencias externas y asegurando que el proyecto compile al terminar.

Contexto:
- El proyecto ya existe.
- Usa SwiftUI.
- Debes adaptar el nombre real del proyecto y respetar los archivos existentes necesarios.
- No debes introducir backend real ni dependencias externas.
- No debes sobrecomplicar la arquitectura.

Arquitectura deseada:
Usa MVVM con separación en estas capas:

1. App
   - Punto de entrada de la app.
   - Inicialización de dependencias.
   - AppEnvironment si es útil.

2. Presentation
   - Views
   - ViewModels
   - Components
   - Navigation

3. Domain
   - Models
   - UseCases
   - Protocols

4. Data
   - Repositories
   - DataSources
   - DTOs
   - Mappers

5. Core
   - Networking
   - Storage
   - DependencyInjection
   - Configuration
   - Extensions
   - Utilities
   - DesignSystem

Tareas:

1. Analiza la estructura actual del proyecto.
2. Detecta el nombre real del proyecto y el archivo principal `App.swift`.
3. Crea la estructura de carpetas propuesta.
4. Crea una pantalla inicial `HomeView`.
5. Crea `HomeViewModel` usando `@MainActor` y `ObservableObject`.
6. Crea un estado reutilizable de pantalla con casos `idle`, `loading`, `success`, `empty` y `error`.
7. Crea componentes reutilizables básicos:
   - `LoadingView`
   - `ErrorView`
   - `EmptyStateView`
8. Crea navegación base con:
   - `AppRoute`
   - `AppRouter`
9. Crea un contenedor manual de dependencias llamado `AppContainer`.
10. Actualiza el punto de entrada de la app para mostrar `HomeView` usando el contenedor.
11. Crea una base mínima de networking:
   - `APIClient`
   - `APIClientProtocol`
   - `APIEndpoint`
   - `HTTPMethod`
   - `NetworkError`
12. Crea un design system mínimo:
   - `AppColors`
   - `AppSpacing`
   - `AppTypography`
   - `AppTheme`
13. Crea ejemplos mínimos en Domain y Data:
   - `ExampleModel`
   - `ExampleRepositoryProtocol`
   - `ExampleUseCase`
   - `ExampleDTO`
   - `ExampleMapper`
   - `ExampleRepository`
14. Si existe target de tests, añade un test básico para `HomeViewModel`.
15. Crea o actualiza `README.md` explicando la arquitectura, estructura de carpetas, convenciones y cómo añadir una nueva feature.
16. Comprueba que el proyecto compila.

Reglas importantes:

- No añadas librerías externas.
- No uses UIKit salvo necesidad clara.
- No introduzcas lógica de negocio dentro de las vistas SwiftUI.
- Los ViewModels deben ser testeables.
- Usa inyección por inicializador siempre que sea razonable.
- Usa protocolos para dependencias que deban poder sustituirse en tests.
- Usa `async/await` para operaciones asíncronas.
- Evita force unwraps.
- No elimines assets, configuraciones o archivos necesarios del proyecto.
- Si `ContentView.swift` existe, puedes reemplazarlo o adaptarlo, pero asegúrate de que la app compile.
- Mantén el código simple y legible.

Resultado esperado:

- Proyecto compilable.
- Estructura de carpetas creada.
- Home inicial funcional.
- MVVM aplicado correctamente.
- README actualizado.
- Código base preparado para añadir nuevas features.
```

## 20. Prompt corto alternativo

```text
Convierte este proyecto iOS SwiftUI default en una base MVVM limpia y compilable.

Crea estructura por capas: App, Presentation, Domain, Data, Core y Resources.

Incluye:
- HomeView
- HomeViewModel
- ViewState
- LoadingView
- ErrorView
- EmptyStateView
- AppRoute
- AppRouter
- AppContainer
- APIClient base
- APIEndpoint
- NetworkError
- Design system mínimo
- Ejemplos mínimos de Domain/Data
- README con arquitectura, estructura y convenciones

Reglas:
- Sin dependencias externas.
- Sin lógica de negocio en SwiftUI Views.
- Inyección por inicializador.
- ViewModels testeables.
- async/await.
- El proyecto debe compilar al terminar.
```

## 21. Cómo añadir una nueva feature

Para añadir una nueva feature llamada `Profile`, seguir este patrón:

```text
Presentation/
├── Views/Profile/ProfileView.swift
├── ViewModels/Profile/ProfileViewModel.swift

Domain/
├── Models/Profile.swift
├── UseCases/FetchProfileUseCase.swift
├── Protocols/ProfileRepositoryProtocol.swift

Data/
├── Repositories/ProfileRepository.swift
├── DataSources/RemoteProfileDataSource.swift
├── DTOs/ProfileDTO.swift
├── Mappers/ProfileMapper.swift
```

Pasos:

1. Crear modelo de dominio.
2. Crear protocolo del repositorio.
3. Crear caso de uso.
4. Crear DTO si hay datos externos.
5. Crear mapper de DTO a dominio.
6. Crear repositorio concreto.
7. Crear ViewModel.
8. Crear View.
9. Registrar dependencias en `AppContainer`.
10. Añadir ruta en `AppRoute` si la feature requiere navegación.
11. Añadir tests básicos.

## 22. Criterios de aceptación

El trabajo se considera terminado cuando:

- La app compila.
- La pantalla inicial se muestra correctamente.
- Existe separación clara entre Presentation, Domain, Data y Core.
- Las vistas no contienen lógica de negocio.
- Los ViewModels pueden testearse.
- No hay dependencias externas añadidas.
- El README explica cómo trabajar con la arquitectura.
- La estructura permite añadir nuevas features siguiendo un patrón repetible.
