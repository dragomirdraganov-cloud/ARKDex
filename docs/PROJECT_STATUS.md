# Estado del proyecto ARKDex

Última revisión: 2026-07-24.

## Configuración

- Proyecto: `ARKDex.xcodeproj`.
- App target: `ARKDex`.
- Test target: `ARKDexTests`.
- Deployment target: iOS 17.
- Swift 6 con Strict Concurrency completa.
- Schemes Development y Production.
- Bundle principal: `com.dragomirdraganov.arkdex`.
- Localización: español e inglés.
- Dependencias externas: ninguna.

## Implementado

- Home con buscador centrado.
- Dropdown de altura adaptable.
- Tres resultados dummy.
- Paleta semántica de ARKDex.
- Montserrat normal e itálica variable.
- Dynamic Type.
- Router tipado.
- Persistencia intercambiable.
- Cliente HTTP testeable.
- CI y auditoría de secretos.

## Pendiente

- Fuente real de datos de ARK: Survival Ascended.
- Modelo de criatura.
- Resultados reales.
- Ficha de criatura.
- Eliminación de infraestructura de ejemplo que deje de aportar valor.

## Riesgos abiertos

- La licencia y estabilidad de la futura fuente de datos deben verificarse antes de integrarla.
- El endpoint de Production es un placeholder.
- Ningún texto dummy debe confundirse con información de juego.

## Validación

La suite actual contiene 13 tests deterministas. El script recomendado es:

```bash
bash Scripts/validate-project.sh
```
