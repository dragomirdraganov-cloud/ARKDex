# ARKDex

ARKDex es una aplicación iOS de consulta para jugadores de **ARK: Survival Ascended**. Su objetivo es ofrecer acceso rápido y claro a información sobre las criaturas del juego, con una experiencia inspirada en la utilidad de herramientas como Dododex.

El proyecto es independiente y no está afiliado con Studio Wildcard ni con Dododex. ARK y ARK: Survival Ascended pertenecen a sus respectivos titulares.

## Estado actual

La base técnica está operativa y la primera Home incluye:

- Buscador centrado.
- Dropdown adaptable con resultados temporales.
- Paleta visual propia de ARKDex.
- Tipografía Montserrat con Dynamic Type.
- Localización en español e inglés.
- Navegación y persistencia preparadas para crecer por features.

Los datos reales de criaturas todavía no están integrados. El siguiente hito es definir el modelo `Creature`, seleccionar una fuente de datos verificable y conectar los resultados del buscador.

## Objetivo del producto

La primera versión útil de ARKDex deberá permitir:

- Buscar criaturas por nombre.
- Consultar una ficha con información relevante para el jugador.
- Mostrar estadísticas y datos de domesticación con su fuente y versión.
- Identificar mapas, hábitats o ubicaciones cuando los datos disponibles lo permitan.
- Mantener una experiencia rápida, legible y útil durante una partida.

Las calculadoras avanzadas, favoritos y disponibilidad offline forman parte del roadmap, no del estado actual.

## Tecnología

- SwiftUI.
- iOS 17 o posterior.
- Swift 6 con Strict Concurrency completa.
- Arquitectura MVVM pragmática organizada por features.
- Swift Testing.
- String Catalog ES/EN.
- Configuraciones Development y Production mediante `.xcconfig`.
- Sin dependencias externas.

## Estructura

```text
ARKDex/
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

ARKDexTests/
├── App/
├── Core/
└── Features/
```

## Schemes

- `ARKDex-Development`: configuración Debug, bundle `.dev` y datos mock.
- `ARKDex-Production`: configuración Release y endpoint definido mediante `API_BASE_URL`.

La URL incluida actualmente es un placeholder. No debe considerarse una fuente de datos de ARK.

## Validación

Validación completa:

```bash
bash Scripts/validate-project.sh 'platform=iOS Simulator,name=iPhone 17 Pro,OS=latest'
```

Build sin firma:

```bash
xcodebuild \
  -scheme ARKDex-Development \
  -project ARKDex.xcodeproj \
  -destination generic/platform=iOS \
  CODE_SIGNING_ALLOWED=NO \
  build
```

Tests:

```bash
xcodebuild \
  -scheme ARKDex-Development \
  -project ARKDex.xcodeproj \
  -destination 'platform=iOS Simulator,name=iPhone 17 Pro,OS=latest' \
  test
```

## Configuración sensible

`Config/Secrets.xcconfig.example` documenta el formato permitido. El archivo real `Secrets.xcconfig` está ignorado y nunca debe subirse al repositorio.

Antes de publicar cambios:

```bash
bash Scripts/check-secrets.sh
```

## Documentación

- `ARKDEX_PRODUCT_VISION.md`: visión, alcance y principios del producto.
- `ARKDEX_TECHNICAL_FOUNDATION.md`: decisiones técnicas y evolución prevista.
- `DOCUMENTACION_ARKDEX_IOS.md`: guía general del proyecto iOS.
- `docs/ARCHITECTURE.md`: límites de arquitectura y datos.
- `docs/FEATURE_GUIDE.md`: patrón para añadir features.
- `docs/PROJECT_STATUS.md`: estado funcional real.
- `docs/PRODUCT_ROADMAP.md`: próximos hitos.
- `docs/IMPLEMENTATION_CHECKLIST.md`: checklist de implementación.
- `docs/GITHUB_WORKFLOW.md`: validación antes de subir cambios.

## Licencias

El código del repositorio se distribuye bajo la licencia incluida en `LICENSE`. Montserrat conserva su licencia SIL Open Font License en `Montserrat/OFL.txt`.
