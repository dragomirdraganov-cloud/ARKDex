#!/bin/bash

set -euo pipefail

forbidden_files=$(rg --files --hidden --no-ignore \
  -g '!.git/**' \
  -g '!.derivedData/**' \
  -g '**/Secrets.xcconfig' \
  -g '**/GoogleService-Info.plist' \
  -g '**/*.p8' || true)

if [[ -n "$forbidden_files" ]]; then
  printf '%s\n' "Potential secret files found:" >&2
  printf '%s\n' "$forbidden_files" >&2
  exit 1
fi

if rg -n --hidden \
  --glob '!.git/**' \
  --glob '!Scripts/check-secrets.sh' \
  --glob '!Config/Secrets.xcconfig.example' \
  -- '-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----|sk_live_[A-Za-z0-9]+|AIza[0-9A-Za-z_-]{20,}' .; then
  printf '%s\n' "Potential credential material found." >&2
  exit 1
fi

printf '%s\n' "Secret audit passed."
