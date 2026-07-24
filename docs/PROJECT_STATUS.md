# Estado del proyecto

Última revisión: 2026-07-03.

## Configuración

- Deployment target: iOS 17.0.
- Lenguaje: Swift 6.
- Concurrencia estricta: Complete.
- Schemes: Development y Production.
- Targets: app y unit tests.
- Localización: inglés y español.
- Dependencias externas: ninguna.

## Estado funcional

- Home usa mock determinista en Development.
- Production demuestra el cliente HTTP con un endpoint configurable.
- Settings demuestra persistencia key-value.
- ExampleDetail demuestra navegación tipada.
- Previews no usan red ni delays reales.
- Build genérico funciona con firma desactivada.
- Los 9 tests iniciales pasan en iPhone 16 Simulator.

## Pendiente manual

- Crear una segunda aplicación real desde el repositorio para auditar el proceso completo de renombrado y detectar acoplamientos residuales.
