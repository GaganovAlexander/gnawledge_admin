import 'package:gnawledge_admin/features/auth/data/models/auth_tokens_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_dto.g.dart';

@JsonSerializable()
class AuthResponseDto {
  const AuthResponseDto({required this.auth});

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseDtoFromJson(json);

  final AuthTokensDto auth;

  Map<String, dynamic> toJson() => _$AuthResponseDtoToJson(this);
}
