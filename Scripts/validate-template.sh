#!/bin/bash

set -euo pipefail

project="SwiftUIMVVMTemplate.xcodeproj"
scheme="SwiftUIMVVMTemplate-Development"
destination="${1:-platform=iOS Simulator,name=iPhone 16,OS=latest}"
derived_data="${DERIVED_DATA_PATH:-$PWD/.derivedData}"

bash Scripts/check-secrets.sh

xcodebuild \
  -quiet \
  -scheme "$scheme" \
  -project "$project" \
  -derivedDataPath "$derived_data" \
  -destination generic/platform=iOS \
  CODE_SIGNING_ALLOWED=NO \
  build

xcodebuild \
  -quiet \
  -scheme "$scheme" \
  -project "$project" \
  -derivedDataPath "$derived_data" \
  -destination "$destination" \
  test

printf '%s\n' "Template validation passed."
