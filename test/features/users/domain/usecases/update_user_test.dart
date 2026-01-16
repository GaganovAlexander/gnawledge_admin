import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/update_user.dart';

import '../../helpers/fake_users_repository.dart';

void main() {
  group('UpdateUser', () {
    test('updates user and returns it', () async {
      final repo = FakeUsersRepository();
      final usecase = UpdateUser(repo);

      final user = AppUser(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        role: 'admin',
        status: 'active',
        joinDate: DateTime(2024, 1, 1),
      );

      final result = await usecase(user);

      expect(result, user);
      expect(repo.lastUpdatedUser, user);
    });

    test('throws exception when repository fails', () async {
      final repo = FakeUsersRepository()..shouldThrow = true;
      final usecase = UpdateUser(repo);

      final user = AppUser(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'john@example.com',
        role: 'admin',
        status: 'active',
        joinDate: DateTime(2024, 1, 1),
      );

      await expectLater(
        () => usecase(user),
        throwsA(isA<Exception>()),
      );
    });
  });
}
