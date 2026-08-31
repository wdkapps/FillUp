FillUp - Gas Mileage Log
========================

A cross-platform Flutter application to calculate and track gas mileage (fuel economy/efficiency).
Rewritten from the original Android Java app to Flutter.

**Author:** Muhammad Bashir Al-Noimi  
**Date:** August 31, 2026  
**Original App:** FillUp - Gas Mileage Log Android App (Java) by William D. Kraemer  
**Source:** https://github.com/wdkapps/FillUp

## Project Overview

FillUp helps you track fuel consumption and calculate mileage for your vehicles. Features include:
- Multiple vehicle support
- Fuel record tracking with full/partial tank detection
- Mileage calculations (MPG, L/100km, km/L, UK MPG)
- Statistics and charts per vehicle and overall
- CSV import/export
- Material Design 3 UI with dark/light theme
- Localization: English, Arabic (RTL), Turkish

## Requirements

- **Flutter SDK:** 3.24+ (stable channel)
- **Dart:** 3.5+
- **Platform targets:** Linux (default), Android, iOS, Windows, macOS, Web
- **Database:** SQLite (via sqflite)
- **State Management:** GetX
- **Charts:** fl_chart
- **Localization:** intl with ARB files

## Development Setup

```bash
# Clone and navigate
cd fillup_flutter  # or src/ if using the source directory

# Install dependencies
flutter pub get

# Generate localization files
flutter gen-l10n

# Run on Linux (default)
flutter run -d linux

# Run on Android (requires device/emulator)
flutter run -d android
```

## Building

### Linux (Development)
```bash
flutter build linux
```
Output: `build/linux/x64/release/bundle/fillup`

### Android APK (Release)
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (Play Store)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS (macOS only)
```bash
flutter build ios --release
```

### Windows
```bash
flutter build windows
```

### macOS
```bash
flutter build macos
```

### Web
```bash
flutter build web
```

## Demo Data

Populate with sample data (12 vehicles, 212 records):
```bash
flutter build linux --dart-define=FILL_DEMO=true
timeout 15 ./build/linux/x64/release/bundle/fillup
flutter build linux  # rebuild normally
```

Reset demo data:
```bash
flutter build linux --dart-define=RESET_DEMO=true
timeout 15 ./build/linux/x64/release/bundle/fillup
flutter build linux
```

Alternative: `./lib/tools/demo_data.sh fill|reset`

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## Project Structure

```
src/
├── lib/
│   ├── main.dart              # App entry point, FFI init, seed data
│   ├── app.dart               # MaterialApp, GetX, theming, localization
│   ├── l10n/                  # ARB files (app_en.arb, app_ar.arb, app_tr.arb)
│   ├── models/                # Data models
│   ├── database/              # SQLite CRUD layer
│   ├── controllers/           # GetX state management
│   ├── screens/               # UI screens (8 screens)
│   ├── widgets/               # Reusable widgets
│   ├── utils/                 # Utilities
│   ├── constants/             # App constants and icons
│   └── tools/                 # Demo data scripts
├── assets/
│   ├── icons/                 # App icons
│   └── brands_icons/          # Vehicle brand logos (git submodule)
├── test/                      # Unit and widget tests
├── android/                   # Android configuration
├── ios/                       # iOS configuration
├── linux/                     # Linux configuration
├── macos/                     # macOS configuration
├── windows/                   # Windows configuration
└── web/                       # Web configuration
```

## Key Implementation Notes

- **Mileage calculations** match the original Java implementation exactly
- **Unit system:** SettingsController.unit is the single source of truth
- **Data storage:** User's current unit system (not canonical base unit)
- **Desktop SQLite:** Requires `databaseFactory = databaseFactoryFfi;` before openDatabase
- **CSV format:** Java-compatible (header `#,version,5`, rows with MM/dd/yyyy HH:mm, etc.)
- **Statistics:** Monthly trips from consecutive record pairs; empty months show zeros

## License

Apache License 2.0 - same as original project.
Copyright 2013,2014 William D. Kraemer (original Java app)
Flutter conversion copyright 2026 Muhammad Bashir Al-Noimi

See LICENSE file for details.