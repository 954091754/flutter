# Building iOS IPA (unsigned)

This project includes scripts and a GitHub Actions workflow to produce an unsigned iOS .ipa. You can run the build on a macOS machine (locally or via GitHub Actions).

Requirements (local macOS):
- macOS with Xcode installed (matching your target iOS SDK)
- Flutter SDK installed and on PATH
- CocoaPods (for plugin deps)

Local build (on a Mac):

1. Make the script executable:

   chmod +x scripts/build_ios.sh

2. Run the script:

   ./scripts/build_ios.sh

This will run `flutter pub get` and then `flutter build ipa --no-codesign`. The IPA will be placed in `build/ios/ipa`.

CI (GitHub Actions):

A workflow is provided at `.github/workflows/build-ios.yml` that runs on `macos-latest`. It installs Flutter, runs `flutter pub get`, and builds the IPA with `--no-codesign`. The built IPA is uploaded as a workflow artifact named `ios-ipa`.

Notes on code signing:
- The builds here use `--no-codesign` and `exportOptions.plist` configured for manual signing/development. To produce a signed IPA, you must run the build on a macOS runner configured with your signing identities and provisioning profiles, or use Xcode archive/export with proper signing settings.

If you want, I can also add a fastlane lane to automate signing with match or integrate automatic certificate provisioning in the workflow.
