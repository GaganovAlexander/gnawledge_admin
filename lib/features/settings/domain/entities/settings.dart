import 'package:flutter/material.dart';

class Settings {
  const Settings({
    required this.locale,
    required this.themeMode,
  });

  final Locale locale;
  final ThemeMode themeMode;

  Settings copyWith({
    Locale? locale,
    ThemeMode? themeMode,
  }) {
    return Settings(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
