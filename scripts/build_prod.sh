#!/bin/bash
flutter build web \
  --dart-define=USE_MOCKS=false \
  --dart-define=API_BASE=https://beavers.althgamer.ru
