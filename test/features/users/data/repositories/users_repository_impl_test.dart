import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/users/data/repositories/users_repository_impl.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';

import '../sources/fake_users_data_source.dart';

void main() {
  group('UsersRepositoryImpl', () {
    group('list', () {
      test('returns list of user entities from data source', () async {
        final dataSource = FakeUsersDataSource()
          ..seedUsers([
            const UserDto(
              id: 1,
              firstName: 'John',
              lastName: 'Doe',
              email: 'john@example.com',
              roleLevel: 2,
            ),
            const UserDto(
              id: 2,
              firstName: 'Jane',
              lastName: 'Smith',
              email: 'jane@example.com',
              roleLevel: 1,
            ),
          ]);
        final repository = UsersRepositoryImpl(dataSource);

        final users = await repository.list(null);

        expect(users.length, 2);
        expect(users[0].firstName, 'John');
        expect(users[1].firstName, 'Jane');
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeUsersDataSource()..shouldThrow = true;
        final repository = UsersRepositoryImpl(dataSource);

        await expectLater(
          () => repository.list(null),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('create', () {
      test('converts entity to DTO and returns created entity', () async {
        final dataSource = FakeUsersDataSource();
        final repository = UsersRepositoryImpl(dataSource);

        final user = AppUser(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          role: 'Admin',
          status: 'active',
          joinDate: DateTime(2024, 1, 1),
        );

        final result = await repository.create(user);

        expect(result.firstName, 'John');
        expect(result.lastName, 'Doe');
        expect(result.email, 'john@example.com');
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeUsersDataSource()..shouldThrow = true;
        final repository = UsersRepositoryImpl(dataSource);

        final user = AppUser(
          id: 1,
          firstName: 'John',
          lastName: 'Doe',
          email: 'john@example.com',
          role: 'Admin',
          status: 'active',
          joinDate: DateTime(2024, 1, 1),
        );

        await expectLater(
          () => repository.create(user),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('update', () {
      test('converts entity to DTO and returns updated entity', () async {
        final dataSource = FakeUsersDataSource();
        final repository = UsersRepositoryImpl(dataSource);

        final user = AppUser(
          id: 1,
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          role: 'Manager',
          status: 'active',
          joinDate: DateTime(2024, 1, 1),
        );

        final result = await repository.update(user);

        expect(result.firstName, 'Jane');
        expect(result.lastName, 'Smith');
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeUsersDataSource()..shouldThrow = true;
        final repository = UsersRepositoryImpl(dataSource);

        final user = AppUser(
          id: 1,
          firstName: 'Jane',
          lastName: 'Smith',
          email: 'jane@example.com',
          role: 'Manager',
          status: 'active',
          joinDate: DateTime(2024, 1, 1),
        );

        await expectLater(
          () => repository.update(user),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('delete', () {
      test('deletes user by id', () async {
        final dataSource = FakeUsersDataSource();
        final repository = UsersRepositoryImpl(dataSource);

        await repository.delete(42);

        // No exception means success
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeUsersDataSource()..shouldThrow = true;
        final repository = UsersRepositoryImpl(dataSource);

        await expectLater(
          () => repository.delete(42),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
