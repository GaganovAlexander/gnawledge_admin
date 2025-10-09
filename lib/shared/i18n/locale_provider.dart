import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateProvider<Locale?>((_) => const Locale('ru'));

final supportedLocales = <Locale>[
  const Locale('en'),
  const Locale('ru'),
];
