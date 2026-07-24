# Flujo antes de subir cambios a GitHub

- [ ] Revisar `git status` y el diff completo.
- [ ] Ejecutar `bash Scripts/check-secrets.sh`.
- [ ] Ejecutar build sin firma con el scheme Development.
- [ ] Ejecutar `SwiftUIMVVMTemplateTests` en simulador.
- [ ] Actualizar `README.md` si cambió estructura, configuración o uso.
- [ ] Actualizar documentos de `docs/` afectados.
- [ ] Actualizar String Catalog si cambiaron textos visibles.
- [ ] Confirmar que no se incluyen `Secrets.xcconfig`, credenciales ni archivos locales de Xcode.

Comando recomendado:

```bash
bash Scripts/validate-template.sh 'platform=iOS Simulator,name=iPhone 16,OS=latest'
```

La CI repite auditoría, build sin firma y tests para pushes y pull requests.

