import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/auth/domain/usecases/request_password_reset.dart';

import '../../helpers/fake_auth_repository.dart';

void main() {
  group('RequestPasswordReset', () {
    test('completes without throwing an error', () async {
      final repo = FakeAuthRepository();
      final usecase = RequestPasswordReset(repo);

      await expectLater(usecase('someone@example.com'), completes);
    });

    test('throws exception when repository fails', () async {
      final repo = FakeAuthRepository()..shouldThrow = true;
      final usecase = RequestPasswordReset(repo);

      await expectLater(
        () => usecase('someone@example.com'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
