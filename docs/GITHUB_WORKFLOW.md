# Flujo antes de subir cambios a GitHub

- [ ] Revisar `git status` y el diff completo.
- [ ] Ejecutar `bash Scripts/check-secrets.sh`.
- [ ] Ejecutar build sin firma con `ARKDex-Development`.
- [ ] Ejecutar `ARKDexTests` en simulador.
- [ ] Actualizar `README.md` y documentos afectados.
- [ ] Actualizar String Catalog si cambiaron textos visibles.
- [ ] Confirmar que fixtures y placeholders no se describen como datos reales.
- [ ] Confirmar que no se incluyen credenciales ni archivos locales de Xcode.

Comando recomendado:

```bash
bash Scripts/validate-project.sh 'platform=iOS Simulator,name=iPhone 17 Pro,OS=latest'
```

La CI repite auditoría, build sin firma y tests en pushes y pull requests.
