# Instrucciones para Codex

Usar este documento antes de programar cambios en el proyecto.

## Reglas generales

- Mantener el proyecto compilable al terminar cada cambio relevante.
- No anadir dependencias externas sin permiso explicito.
- No usar UIKit salvo necesidad clara.
- No introducir backend real ni servicios ficticios complejos.
- No eliminar assets, configuraciones o archivos necesarios.
- Mantener el codigo simple, legible y con responsabilidades claras.

## SwiftUI y MVVM

- Las vistas SwiftUI solo deben encargarse de declarar UI y reaccionar al estado.
- No poner logica de negocio dentro de vistas.
- Crear ViewModels testeables.
- Inyectar dependencias por inicializador siempre que sea razonable.
- Usar protocolos para dependencias que deban sustituirse en tests.
- Marcar ViewModels como `@MainActor` cuando publiquen estado para la UI.
- Preferir `@Observable` para ViewModels nuevos mientras el deployment target siga permitiendo Observation moderna.
- Preferir `final class` para ViewModels y servicios cuando no se espere herencia.

## Concurrencia

- Preferir `async/await` frente a callbacks.
- Evitar trabajo pesado en el hilo principal.
- Mantener cambios de estado de UI en MainActor.

## Calidad

- Evitar force unwraps innecesarios.
- Evitar nombres genericos como `Manager` salvo justificacion clara.
- Mantener archivos pequenos y enfocados.
- Usar `ViewState` para representar `idle`, `loading`, `success`, `empty` y `error` cuando una pantalla tenga carga asincrona.

## Antes de terminar una tarea

- Marcar tareas completadas en `docs/IMPLEMENTATION_CHECKLIST.md`.
- Actualizar `README.md` si cambia la estructura, el flujo de trabajo o el estado del proyecto.
- Actualizar documentos en `docs/` si cambian reglas, arquitectura o convenciones.
- Compilar con `xcodebuild` cuando se hayan hecho cambios de codigo.
