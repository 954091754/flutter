#!/bin/bash
# Simple helper to build an unsigned iOS IPA locally on macOS.

set -euo pipefail

echo "Running flutter pub get..."
flutter pub get

echo "Building IPA (no codesign)..."
flutter build ipa --no-codesign --export-options-plist=ios/exportOptions.plist

echo "IPA should be in: build/ios/ipa"
