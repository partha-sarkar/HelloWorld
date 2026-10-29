# HelloWorld Android App

A simple Hello World Android application built with **Jetpack Compose** and **Kotlin**.

## Features

- Modern Android UI with **Jetpack Compose**
- **Material 3** theming (Light & Dark mode)
- Interactive button with click counter
- Minimal dependencies

## Tech Stack

- **Language**: Kotlin
- **UI**: Jetpack Compose
- **Architecture**: MVVM (ViewModel-ready)
- **Build**: Gradle (Kotlin DSL)
- **Min SDK**: 24 (Android 7.0)
- **Target SDK**: 34 (Android 14)

## Screenshots

| Light Mode | Dark Mode |
|------------|-----------|
| ![Light](screenshots/light.png) | ![Dark](screenshots/dark.png) |

## Getting Started

### Prerequisites

- **JDK 17+** (required for Android Gradle Plugin 8.x)
- **Android Studio** (recommended) or command line

### Build from Command Line

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/HelloWorld.git
cd HelloWorld

# Build debug APK
./gradlew assembleDebug
# Windows: gradlew.bat assembleDebug

# APK location: app/build/outputs/apk/debug/app-debug.apk
```

### Build with Android Studio

1. Open Android Studio
2. Select **File → Open** and choose this project
3. Wait for Gradle sync
4. Click **Run** (▶) or **Build → Build Bundle(s) / APK(s) → Build APK(s)**

## Project Structure

```
HelloWorld/
├── app/
│   ├── src/main/
│   │   ├── java/com/example/helloworld/
│   │   │   ├── MainActivity.kt      # Main Compose screen
│   │   │   └── ui/theme/            # Material3 theming
│   │   ├── res/
│   │   │   ├── values/strings.xml
│   │   │   └── xml/                 # Backup & data rules
│   │   └── AndroidManifest.xml
│   ├── build.gradle.kts
│   └── proguard-rules.pro
├── gradle/wrapper/
├── build.gradle.kts
├── settings.gradle.kts
├── gradle.properties
└── .gitignore
```

## Customization

### Change App Name
Edit `app/src/main/res/values/strings.xml`:
```xml
<string name="app_name">MyApp</string>
```

### Change Package Name
1. Update `namespace` and `applicationId` in `app/build.gradle.kts`
2. Refactor package in `app/src/main/java/com/example/helloworld/`
3. Update `AndroidManifest.xml`

### Modify Theme
Edit `app/src/main/java/com/example/helloworld/ui/theme/Theme.kt` to customize colors.

## License

MIT License - feel free to use this as a starting point for your apps!