import 'package:gnawledge_admin/features/account/domain/entities/user.dart';
import 'package:gnawledge_admin/features/account/domain/repositories/account_repository.dart';

class FakeAccountRepository implements AccountRepository {
  String? lastCurrentPassword;
  String? lastNewPassword;
  String? lastFullName;

  bool shouldThrow = false;

  UserEntity? userToReturn;
  UserEntity? meToReturn;

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    lastCurrentPassword = currentPassword;
    lastNewPassword = newPassword;

    if (shouldThrow) {
      throw Exception('Change password failed');
    }
  }

  @override
  Future<UserEntity> updateProfile({required String fullName}) async {
    lastFullName = fullName;

    if (shouldThrow) {
      throw Exception('Update profile failed');
    }

    return userToReturn ??
        UserEntity(id: '1', fullName: fullName, email: 'test@example.com');
  }

  @override
  Future<UserEntity> getMe() async {
    if (shouldThrow) {
      throw Exception('Get me failed');
    }

    return meToReturn ??
        const UserEntity(
          id: 'me',
          fullName: 'Test User',
          email: 'me@example.com',
        );
  }
}
