# Checklist de implementación de ARKDex

Última revisión: 2026-07-24.

## Identidad y base técnica

- [x] Renombrar proyecto, target, módulo, tests y schemes a ARKDex.
- [x] Configurar bundle identifiers de Development, Production y tests.
- [x] Mantener iOS 17, Swift 6 y Strict Concurrency completa.
- [x] Mantener CI, auditoría de secretos y tests.
- [x] Aplicar la paleta de producto.
- [x] Integrar Montserrat con Dynamic Type.
- [x] Localizar textos en español e inglés.

## Home

- [x] Crear buscador centrado.
- [x] Mostrar dropdown adaptable al escribir.
- [x] Añadir tres resultados dummy claramente temporales.
- [ ] Sustituir resultados dummy por criaturas reales.
- [ ] Añadir estados vacío, carga y error del buscador.

## Catálogo de criaturas

- [ ] Seleccionar y documentar una fuente de datos permitida.
- [ ] Definir modelo `Creature`.
- [ ] Definir contrato `CreatureRepository`.
- [ ] Crear fixtures deterministas.
- [ ] Implementar búsqueda normalizada.
- [ ] Crear ficha de criatura.
- [ ] Mostrar procedencia o versión de los datos.

## Funciones posteriores

- [ ] Favoritos.
- [ ] Caché o modo offline.
- [ ] Filtros.
- [ ] Comparación de criaturas.
- [ ] Calculadoras de domesticación.

## Verificación

- [x] El proyecto Xcode reconoce `ARKDex` y `ARKDexTests`.
- [x] Build sin firma.
- [x] Tests en simulador.
- [x] Auditoría de secretos.
- [x] README y documentación orientados al producto.
