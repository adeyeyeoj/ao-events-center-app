# AO Events Center — Complete Android Build Project

This is the consolidated Flutter project intended for the first real Android APK test.

## Build locally
flutter pub get
flutter analyze
flutter test
flutter build apk --debug

## Cloud build
A `codemagic.yaml` is included for cloud Android builds.

## Important
The first debug APK does not require Firebase. It is intended to validate the UI and booking journey on a real Android phone.

Firebase, production signing, and Play Store configuration come later.
