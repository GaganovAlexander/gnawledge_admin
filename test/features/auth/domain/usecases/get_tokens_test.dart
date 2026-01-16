import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/auth/domain/usecases/get_tokens.dart';

import '../../helpers/fake_auth_repository.dart';

void main() {
  group('GetTokens', () {
    test('returns null when access token is missing', () {
      final repo = FakeAuthRepository()
        ..seedTokens(refresh: 'r');
      final usecase = GetTokens(repo);

      final result = usecase();

      expect(result, isNull);
    });

    test('returns null when refresh token is missing', () {
      final repo = FakeAuthRepository()
        ..seedTokens(access: 'a');
      final usecase = GetTokens(repo);

      final result = usecase();

      expect(result, isNull);
    });

    test('returns AuthTokens when both tokens are present', () {
      final repo = FakeAuthRepository()
        ..seedTokens(access: 'a123', refresh: 'r456');
      final usecase = GetTokens(repo);

      final result = usecase();

      expect(result, isNotNull);
      expect(result?.access, 'a123');
      expect(result?.refresh, 'r456');
    });
  });
}
