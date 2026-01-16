import 'package:flutter_test/flutter_test.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/delete_user.dart';

import '../../helpers/fake_users_repository.dart';

void main() {
  group('DeleteUser', () {
    test('deletes user by id', () async {
      final repo = FakeUsersRepository();
      final usecase = DeleteUser(repo);

      await usecase(42);

      expect(repo.lastDeletedId, 42);
    });

    test('throws exception when repository fails', () async {
      final repo = FakeUsersRepository()..shouldThrow = true;
      final usecase = DeleteUser(repo);

      await expectLater(
        () => usecase(42),
        throwsA(isA<Exception>()),
      );
    });
  });
}
