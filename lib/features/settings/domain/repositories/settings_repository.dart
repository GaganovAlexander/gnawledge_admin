import 'package:flutter/material.dart';
import 'package:gnawledge_admin/features/settings/domain/entities/settings.dart';

abstract class SettingsRepository {
  Future<Settings> load();
  Future<void> setLocale(Locale locale);
  Future<void> setThemeMode(ThemeMode mode);
}
