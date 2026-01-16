import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/account/domain/entities/user.dart';
import 'package:gnawledge_admin/features/account/domain/usecases/update_profile.dart';

import '../../helpers/fake_account_repository.dart';

void main() {
  group('UpdateProfile', () {
    test('returns updated user with new full name', () async {
      final repo = FakeAccountRepository();
      final usecase = UpdateProfile(repo);

      final result = await usecase('John Doe');

      expect(result.fullName, 'John Doe');
      expect(repo.lastFullName, 'John Doe');
    });

    test('returns user provided by repository', () async {
      final repo = FakeAccountRepository()
        ..userToReturn = const UserEntity(
          id: '42',
          fullName: 'Custom Name',
          email: 'custom@example.com',
        );

      final usecase = UpdateProfile(repo);

      final result = await usecase('Ignored Name');

      expect(result.id, '42');
      expect(result.fullName, 'Custom Name');
    });

    test('throws exception when repository fails', () async {
      final repo = FakeAccountRepository()..shouldThrow = true;
      final usecase = UpdateProfile(repo);

      await expectLater(() => usecase('John Doe'), throwsA(isA<Exception>()));
    });
  });
}
