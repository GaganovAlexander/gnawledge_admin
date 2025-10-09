#!/bin/bash
flutter run -d chrome \
  --dart-define=USE_MOCKS=true \
  --dart-define=API_BASE=https://dev.beavers.althgamer.ru
