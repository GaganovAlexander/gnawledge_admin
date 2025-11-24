import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:gnawledge_admin/features/settings/data/sources/settings_mock_ds.dart';
import 'package:gnawledge_admin/features/settings/domain/repositories/settings_repository.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(SettingsMockDs());
});
