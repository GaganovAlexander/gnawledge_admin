# Beavers Admin 🦫

Flutter Web admin panel built with Clean Architecture and Riverpod.

## 🏗️ Run locally
```bash
flutter pub get
flutter run -d chrome
```

## 🔧 Environments

Use mocks by default.
For production API:
```bash
flutter run -d chrome --dart-define=USE_MOCKS=false --dart-define=API_BASE=https://api.example.com
```

## 📂 Structure
```
lib/
├─ app/ ... core setup
├─ features/ ... domain/data/presentation
└─ shared/ ... reusable widgets
```