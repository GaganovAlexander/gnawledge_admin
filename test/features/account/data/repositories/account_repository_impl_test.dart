import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/account/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/account/data/repositories/account_repository_impl.dart';

import '../sources/fake_account_data_source.dart';

void main() {
  group('AccountRepositoryImpl', () {
    group('getMe', () {
      test('returns user entity from data source', () async {
        final dataSource = FakeAccountDataSource()
          ..userToReturn = const UserDto(
            id: '42',
            email: 'john@example.com',
            fullName: 'John Doe',
          );
        final repository = AccountRepositoryImpl(dataSource);

        final user = await repository.getMe();

        expect(user.id, '42');
        expect(user.email, 'john@example.com');
        expect(user.fullName, 'John Doe');
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeAccountDataSource()..shouldThrow = true;
        final repository = AccountRepositoryImpl(dataSource);

        await expectLater(
          () => repository.getMe(),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('updateProfile', () {
      test('passes fullName to data source and returns entity', () async {
        final dataSource = FakeAccountDataSource();
        final repository = AccountRepositoryImpl(dataSource);

        final user = await repository.updateProfile(fullName: 'Jane Smith');

        expect(dataSource.lastFullName, 'Jane Smith');
        expect(user.fullName, 'Jane Smith');
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeAccountDataSource()..shouldThrow = true;
        final repository = AccountRepositoryImpl(dataSource);

        await expectLater(
          () => repository.updateProfile(fullName: 'Jane Smith'),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('changePassword', () {
      test('passes passwords to data source', () async {
        final dataSource = FakeAccountDataSource();
        final repository = AccountRepositoryImpl(dataSource);

        await repository.changePassword(
          currentPassword: 'old123',
          newPassword: 'new456',
        );

        expect(dataSource.lastCurrentPassword, 'old123');
        expect(dataSource.lastNewPassword, 'new456');
      });

      test('throws exception when data source fails', () async {
        final dataSource = FakeAccountDataSource()..shouldThrow = true;
        final repository = AccountRepositoryImpl(dataSource);

        await expectLater(
          () => repository.changePassword(
            currentPassword: 'old123',
            newPassword: 'new456',
          ),
          throwsA(isA<Exception>()),
        );
      });
    });
  });
}
