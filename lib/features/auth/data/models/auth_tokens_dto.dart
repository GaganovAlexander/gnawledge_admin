import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_tokens_dto.g.dart';

@JsonSerializable()
class AuthTokensDto {
  const AuthTokensDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokensDto.fromJson(Map<String, dynamic> json) =>
      _$AuthTokensDtoFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  Map<String, dynamic> toJson() => _$AuthTokensDtoToJson(this);

  AuthTokens toEntity() =>
      AuthTokens(access: accessToken, refresh: refreshToken);
}
