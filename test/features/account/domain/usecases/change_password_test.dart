import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/account/domain/usecases/change_password.dart';

import '../../helpers/fake_account_repository.dart';

void main() {
  group('ChangePassword', () {
    test('calls repository with correct current and new passwords', () async {
      final repo = FakeAccountRepository();
      final usecase = ChangePassword(repo);

      await usecase(current: 'old_pass', next: 'new_pass');

      expect(repo.lastCurrentPassword, 'old_pass');
      expect(repo.lastNewPassword, 'new_pass');
    });

    test('throws exception when repository fails', () async {
      final repo = FakeAccountRepository()..shouldThrow = true;
      final usecase = ChangePassword(repo);

      await expectLater(
        () => usecase(current: 'old_pass', next: 'new_pass'),
        throwsA(isA<Exception>()),
      );
    });
  });
}
