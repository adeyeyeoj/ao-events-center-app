# First APK without owning a computer

The project is now a complete Flutter/Android project.

Recommended route:
1. Put this project in a GitHub repository from a phone.
2. Connect the repository to a cloud Flutter builder such as Codemagic.
3. Start the `android-debug-apk` workflow.
4. Download the generated `app-debug.apk` artifact to the phone.
5. Install it and test.

The first APK is a UI/local-data test build. Firebase is intentionally not required for this first phone test.
