# Cómo añadir una feature

Ejemplo para una feature `Profile`:

```text
Features/Profile/
├── ProfileView.swift
├── ProfileViewModel.swift
├── ProfileModels.swift
├── ProfileService.swift
└── ProfileServiceLive.swift
```

## Pasos

1. Crear la View.
2. Añadir ViewModel solo si existe estado o lógica de pantalla.
3. Definir un protocolo de servicio si la feature depende de red, persistencia u otra fuente sustituible.
4. Crear implementación live y mock determinista.
5. Registrar la implementación live en `AppDependencies`.
6. Añadir una ruta tipada si la feature necesita navegación.
7. Añadir recursos ES/EN al String Catalog.
8. Añadir previews de estados relevantes.
9. Añadir tests sin red ni tiempos reales.
10. Actualizar documentación si cambia la arquitectura o el flujo de trabajo.

## Reglas

- Mantener modelos y servicios específicos dentro de la feature.
- Mover algo a Core solo cuando sea utilizado por varias features y no dependa de ellas.
- No crear DTO, mapper, repository o use case si no aportan una separación real.
- ViewModels de UI: `@MainActor @Observable`.
- Valores que cruzan aislamiento: `Sendable`.
- Dependencias por inicializador.

