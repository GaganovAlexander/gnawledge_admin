import 'package:gnawledge_admin/features/settings/data/models/settings_dto.dart';
import 'package:gnawledge_admin/features/settings/data/sources/settings_data_source.dart';

class SettingsMockDs implements SettingsDataSource {
  SettingsDto dto = SettingsDto(locale: 'en', theme: 'system');

  @override
  Future<SettingsDto> load() async => dto;

  @override
  Future<void> save(SettingsDto d) async {
    dto = d;
  }
}
