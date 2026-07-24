# Checklist de renombrado

Usar esta lista al crear una aplicación nueva desde el starter.

- [ ] Renombrar el proyecto y el target `SwiftUIMVVMTemplate`.
- [ ] Renombrar los schemes Development y Production.
- [ ] Cambiar `PRODUCT_NAME` en `Config/Base.xcconfig`.
- [ ] Cambiar `DISPLAY_NAME` en Development y Production.
- [ ] Cambiar ambos `PRODUCT_BUNDLE_IDENTIFIER`.
- [ ] Configurar el Development Team local si se necesita firmar para dispositivo.
- [ ] Sustituir `API_BASE_URL` de Production.
- [ ] Revisar los valores de `APP_ENVIRONMENT`.
- [ ] Sustituir AppIcon, AccentColor y colores de marca.
- [ ] Revisar textos ES/EN del String Catalog.
- [ ] Renombrar el módulo importado por el target de tests.
- [ ] Actualizar el nombre del proyecto y schemes en CI y scripts.
- [ ] Revisar `LICENSE`, `README.md` y documentación.
- [ ] Ejecutar `bash Scripts/validate-template.sh`.
- [ ] Ejecutar `bash Scripts/check-secrets.sh`.

No versionar `Config/Secrets.xcconfig`. Si el nuevo proyecto necesita valores locales, copiar `Secrets.xcconfig.example` y mantener el archivo real fuera de Git.

