# Checklist de evolución v2

Última revisión: 2026-07-24.

## Fase 1: Base verificable

- [x] Añadir target de tests con Swift Testing.
- [x] Añadir tests de router, ViewModels, APIClient y persistencia.
- [x] Añadir mocks deterministas.
- [x] Eliminar delays y red de tests/previews.
- [x] Documentar build sin firma.

## Fase 2: Configuración moderna

- [x] Bajar deployment target a iOS 17.
- [x] Añadir `.xcconfig` base, Development y Production.
- [x] Añadir schemes Development y Production.
- [x] Neutralizar bundle IDs, team, nombres y URLs.
- [x] Añadir String Catalog ES/EN.
- [x] Añadir plantilla de secretos ignorada por Git.

## Fase 3: Swift 6

- [x] Migrar a Swift 6.
- [x] Activar Strict Concurrency completa.
- [x] Mantener UI en MainActor e infraestructura fuera del actor global.
- [x] Añadir contratos y modelos Sendable.
- [x] Verificar build con concurrencia estricta.

## Fase 4: Organización por features

- [x] Crear `AppRootView`, `AppDependencies` y `AppState`.
- [x] Eliminar el singleton `AppContainer.shared`.
- [x] Mover Home a `Features/Home`.
- [x] Crear Settings y ExampleDetail.
- [x] Mantener en Core solo infraestructura compartida.
- [x] Añadir navegación tipada por tabs.

## Fase 5: Infraestructura y plantilla

- [x] Completar APIClient y request builder.
- [x] Añadir persistencia live e in-memory.
- [x] Añadir logging redactado.
- [x] Añadir Design System semántico con la paleta del producto.
- [x] Añadir previews de estados, temas e idiomas.
- [x] Añadir CI y auditoría de secretos.
- [x] Añadir checklist de renombrado y script de validación.
- [ ] Validar adopción creando una segunda app pequeña.

## Verificación

- [x] El proyecto Xcode reconoce app y test target.
- [x] El app build pasa con firma desactivada.
- [x] Los tests compilan bajo Swift 6 Strict Concurrency.
- [x] Los 13 tests pasan en simulador.
- [x] README y documentación reflejan la arquitectura actual.

## Evolución de producto

- [x] Crear la Home inicial con buscador centrado y tres sugerencias dummy.
- [x] Integrar Montserrat variable en los tokens tipográficos del Design System.
