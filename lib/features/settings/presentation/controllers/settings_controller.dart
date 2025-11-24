import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/settings/domain/entities/settings.dart';
import 'package:gnawledge_admin/features/settings/domain/repositories/settings_repository.dart';
import 'package:gnawledge_admin/features/settings/presentation/providers.dart';

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, AsyncValue<Settings>>((ref) {
  final repo = ref.watch(settingsRepositoryProvider);
  return SettingsController(repo);
});

class SettingsController extends StateNotifier<AsyncValue<Settings>> {
  SettingsController(this.repo) : super(const AsyncValue.loading()) {
    _load();
  }

  final SettingsRepository repo;

  Future<void> _load() async {
    state = const AsyncValue.loading();
    final s = await repo.load();
    state = AsyncValue.data(s);
  }

  Future<void> setLocale(Locale locale) async {
    await repo.setLocale(locale);
    final current = state.value!;
    state = AsyncValue.data(current.copyWith(locale: locale));
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await repo.setThemeMode(mode);
    final current = state.value!;
    state = AsyncValue.data(current.copyWith(themeMode: mode));
  }
}
