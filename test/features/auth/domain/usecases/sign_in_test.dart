import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/auth/domain/usecases/sign_in.dart';

import '../../helpers/fake_auth_repository.dart';

void main() {
  group('SignIn', () {
    test(
      'succeeds with valid credentials and stores tokens in repository',
      () async {
        final repo = FakeAuthRepository();
        final usecase = SignIn(repo);

        final tokens = await usecase(
          email: 'admin@example.com',
          password: 'admin123',
        );

        expect(tokens.access, 'mock_access_admin_123');
        expect(tokens.refresh, 'mock_refresh_admin_456');
        expect(repo.currentAccess(), 'mock_access_admin_123');
        expect(repo.currentRefresh(), 'mock_refresh_admin_456');
      },
    );

    test('throws an exception when password is incorrect', () async {
      final repo = FakeAuthRepository();
      final usecase = SignIn(repo);

      await expectLater(
        () => usecase(email: 'admin@example.com', password: 'wrong'),
        throwsA(isA<Exception>()),
      );
      expect(repo.currentAccess(), isNull);
      expect(repo.currentRefresh(), isNull);
    });

    test('throws an exception when email or password is empty', () async {
      final repo = FakeAuthRepository();
      final usecase = SignIn(repo);

      await expectLater(
        () => usecase(email: '', password: ''),
        throwsA(isA<Exception>()),
      );
    });
  });
}
