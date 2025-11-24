import 'package:gnawledge_admin/features/settings/data/models/settings_dto.dart';

abstract class SettingsDataSource {
  Future<SettingsDto> load();
  Future<void> save(SettingsDto dto);
}
