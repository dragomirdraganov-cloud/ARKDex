# Propuesta: iOS MVVM Starter

Última revisión: 2026-07-03

## Viabilidad

Sí, es viable crear un proyecto separado a partir de los patrones consolidados en NavDrop. Debe ser un starter neutral, no una copia de la app: sin marca NavDrop, Tesla, endpoints, API keys, Firebase obligatorio ni lógica de negocio específica.

## Objetivo

Un proyecto Xcode que permita empezar una app SwiftUI con:

- iOS 17+, Swift 6 y concurrency estricta;
- MVVM pragmático por features;
- estado global observable y aislado al `MainActor`;
- navegación tipada;
- protocolos e inyección de servicios;
- cliente HTTP base con errores tipados y logs redactados;
- persistencia intercambiable;
- Design System semántico Light/Dark;
- localización ES/EN;
- previews, mocks y tests de ejemplo;
- target Production y Development sin secretos versionados.

## Estructura propuesta

```text
AppStarter/
├── App/
│   ├── AppStarterApp.swift
│   ├── AppRootView.swift
│   ├── AppState.swift
│   └── AppRouter.swift
├── Core/
│   ├── Components/
│   ├── DesignSystem/
│   ├── Localization/
│   ├── Logging/
│   └── Networking/
├── Features/
│   ├── Home/
│   ├── Settings/
│   └── ExampleDetail/
├── Models/
├── Services/
│   ├── Protocols/
│   ├── Live/
│   ├── Mock/
│   └── Persistence/
├── Config/
├── Resources/
├── Assets.xcassets/
└── Localizable.xcstrings

AppStarterTests/
├── AppRouterTests.swift
├── APIClientTests.swift
└── ExampleViewModelTests.swift
```

## Decisiones que conviene reutilizar

- `@Observable @MainActor` para estado de UI compartido.
- Views pequeñas; ViewModel solo cuando existe estado/lógica de pantalla.
- Dependencias como protocolos, construidas en un composition root.
- DTO de red separado de modelos de dominio cuando el contrato lo justifique.
- Errores con código estable y recuperación explícita.
- Tokens visuales semánticos; nada de colores o fuentes dispersos.
- Mocks deterministas para previews/tests.
- Configuración por `.xcconfig`/Info.plist, sin secretos reales en Git.
- Documentación mínima: README, arquitectura, diseño, tareas y deuda.

## Qué no copiar

- nombres `NavDrop`/`VoltPath`, bundle IDs, App Group o schemes URL;
- clientes/endpoints Tesla y reglas VCP;
- API keys, dominios, Firebase plist o entitlements firmados;
- Share Extension o App Intents por defecto;
- historial/favoritos específicos;
- compatibilidad legacy o decisiones temporales del producto.

## Alcance v1 recomendado

1. Proyecto compilable con targets App y App Dev.
2. Home y Settings de ejemplo.
3. Router tipado y tab bar nativa simple.
4. Design System pequeño: colores, tipografía, spacing, radios y botones.
5. `APIClient` con `URLSession`, async/await, `Decodable`, timeout y error tipado.
6. Servicio de ejemplo live/mock.
7. Persistencia key-value abstracta.
8. Catálogo ES/EN.
9. Previews Light/Dark y tests unitarios básicos.
10. Checklist para renombrar producto, bundles y configuración.

## Opcionales por módulos

Share Extension, App Intents, Keychain, Firebase, notificaciones, ubicación y CI deberían añadirse como módulos opt-in. Así el starter se mantiene pequeño y cada proyecto solo asume capabilities que realmente usa.

## Forma de distribución

La opción más mantenible es un repositorio Git independiente, por ejemplo `iOS-MVVM-Starter`, con una release estable y un script/checklist de renombrado. Una plantilla de Xcode o un generador puede llegar después; primero conviene probar el starter creando dos apps pequeñas para descubrir acoplamientos ocultos.

## Plan de creación

1. Abrir repositorio separado y fijar licencia/compatibilidad.
2. Extraer patrones, no archivos de producto completos.
3. Sustituir branding/configuración por placeholders seguros.
4. Añadir ejemplo end-to-end pequeño.
5. Ejecutar build, tests y auditoría de secretos.
6. Crear documentación de adopción y checklist de renombrado.
7. Validarlo en un segundo proyecto antes de declararlo plantilla estable.

## Criterios de aceptación

- Clona, compila y ejecuta sin credenciales externas.
- Ningún identificador o secreto de NavDrop aparece en el bundle.
- Una feature de ejemplo demuestra View → ViewModel → Service → API/Mock.
- Light/Dark, ES/EN y previews funcionan.
- Los tests no requieren red.
- Crear una nueva feature no obliga a editar infraestructura no relacionada.
