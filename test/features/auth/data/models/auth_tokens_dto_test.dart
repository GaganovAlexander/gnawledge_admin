import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/auth/data/models/auth_tokens_dto.dart';

void main() {
  group('AuthTokensDto', () {
    group('fromJson', () {
      test('parses tokens from JSON', () {
        final json = {
          'access_token': 'access123',
          'refresh_token': 'refresh456',
        };

        final dto = AuthTokensDto.fromJson(json);

        expect(dto.accessToken, 'access123');
        expect(dto.refreshToken, 'refresh456');
      });
    });

    group('toJson', () {
      test('converts DTO to JSON', () {
        const dto = AuthTokensDto(
          accessToken: 'access123',
          refreshToken: 'refresh456',
        );

        final json = dto.toJson();

        expect(json['access_token'], 'access123');
        expect(json['refresh_token'], 'refresh456');
      });
    });

    group('toEntity', () {
      test('converts DTO to entity', () {
        const dto = AuthTokensDto(
          accessToken: 'access123',
          refreshToken: 'refresh456',
        );

        final entity = dto.toEntity();

        expect(entity.access, 'access123');
        expect(entity.refresh, 'refresh456');
      });
    });
  });
}
