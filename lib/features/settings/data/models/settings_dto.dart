import 'package:json_annotation/json_annotation.dart';

part 'settings_dto.g.dart';

@JsonSerializable()
class SettingsDto {
  SettingsDto({
    required this.locale,
    required this.theme,
  });

  factory SettingsDto.fromJson(Map<String, dynamic> json) =>
      _$SettingsDtoFromJson(json);

  final String locale;
  final String theme;

  Map<String, dynamic> toJson() => _$SettingsDtoToJson(this);
}
