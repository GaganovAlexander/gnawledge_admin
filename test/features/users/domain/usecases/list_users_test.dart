import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/list_users.dart';

import '../../helpers/fake_users_repository.dart';

void main() {
  group('ListUsers', () {
    test('returns all users when query is null', () async {
      final users = [
        AppUser(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          role: 'admin',
          status: 'active',
          joinDate: DateTime(2024, 1, 1),
        ),
        AppUser(
          id: 2,
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          role: 'user',
          status: 'active',
          joinDate: DateTime(2024, 1, 2),
        ),
      ];

      final repo = FakeUsersRepository()..seedUsers(users);
      final usecase = ListUsers(repo);

      final result = await usecase(null);

      expect(result.length, 2);
      expect(result, users);
    });

    test('returns filtered users when query is provided', () async {
      final users = [
        AppUser(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          role: 'admin',
          status: 'active',
          joinDate: DateTime(2024, 1, 1),
        ),
        AppUser(
          id: 2,
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          role: 'user',
          status: 'active',
          joinDate: DateTime(2024, 1, 2),
        ),
      ];

      final repo = FakeUsersRepository()..seedUsers(users);
      final usecase = ListUsers(repo);

      final result = await usecase('john');

      expect(result.length, 1);
      expect(result.first.firstName, 'John');
    });

    test('throws exception when repository fails', () async {
      final repo = FakeUsersRepository()..shouldThrow = true;
      final usecase = ListUsers(repo);

      await expectLater(
        () => usecase(null),
        throwsA(isA<Exception>()),
      );
    });
  });
}
