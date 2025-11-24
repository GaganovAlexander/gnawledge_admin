import 'package:flutter/material.dart';
import 'package:gnawledge_admin/features/settings/data/models/settings_dto.dart';
import 'package:gnawledge_admin/features/settings/data/sources/settings_data_source.dart';
import 'package:gnawledge_admin/features/settings/domain/entities/settings.dart';
import 'package:gnawledge_admin/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this.ds);

  final SettingsDataSource ds;

  @override
  Future<Settings> load() async {
    final dto = await ds.load();
    return Settings(
      locale: Locale(dto.locale),
      themeMode: _parseMode(dto.theme),
    );
  }

  @override
  Future<void> setLocale(Locale locale) async {
    final dto = await ds.load();
    await ds.save(SettingsDto(
      locale: locale.languageCode,
      theme: dto.theme,
    ));
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) async {
    final dto = await ds.load();
    await ds.save(SettingsDto(
      locale: dto.locale,
      theme: _modeToStr(mode),
    ));
  }

  ThemeMode _parseMode(String v) {
    switch (v) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _modeToStr(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}
