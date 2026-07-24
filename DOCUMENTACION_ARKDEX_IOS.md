# Documentación iOS de ARKDex

ARKDex es una aplicación SwiftUI para consultar información de criaturas de ARK: Survival Ascended.

## Proyecto Xcode

- Proyecto: `ARKDex.xcodeproj`.
- Target de aplicación: `ARKDex`.
- Target de tests: `ARKDexTests`.
- Schemes: `ARKDex-Development` y `ARKDex-Production`.
- Entry point: `ARKDex/App/ARKDexApp.swift`.

## Requisitos

- Xcode con Swift 6.
- iOS 17 o posterior.
- No se necesita firma para el build genérico.

## Diseño

La paleta está definida en `ARKDex/Core/DesignSystem/AppColors.swift` y la tipografía Montserrat en `AppTypography.swift`.

No se deben añadir colores nuevos sin aprobación. Los componentes deben consumir tokens semánticos y conservar soporte para Dynamic Type.

## Arquitectura

La aplicación se organiza por features. Cada feature puede contener View, estado, ViewModel, modelos y servicios propios. `Core` queda reservado para infraestructura realmente compartida.

La información de criaturas se incorporará detrás de un contrato sustituible para permitir mocks, tests y futuras estrategias offline.

## Estado actual

La Home muestra un buscador y resultados dummy. Todavía no existe un catálogo real ni una ficha completa de criatura.

El estado actualizado y los siguientes hitos se encuentran en:

- `docs/PROJECT_STATUS.md`.
- `docs/PRODUCT_ROADMAP.md`.
- `docs/IMPLEMENTATION_CHECKLIST.md`.

## Validación

```bash
bash Scripts/validate-project.sh
```

El script ejecuta auditoría de secretos, build sin firma y tests.
