import 'package:gnawledge_admin/features/account/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_data_source.dart';

class FakeAccountDataSource implements AccountDataSource {
  bool shouldThrow = false;
  UserDto? userToReturn;
  String? lastFullName;
  String? lastCurrentPassword;
  String? lastNewPassword;

  @override
  Future<UserDto> getMe() async {
    if (shouldThrow) {
      throw Exception('Get me failed');
    }

    return userToReturn ??
        const UserDto(
          id: '1',
          email: 'test@example.com',
          fullName: 'Test User',
        );
  }

  @override
  Future<UserDto> updateProfile({required String fullName}) async {
    lastFullName = fullName;

    if (shouldThrow) {
      throw Exception('Update profile failed');
    }

    return userToReturn ??
        UserDto(
          id: '1',
          email: 'test@example.com',
          fullName: fullName,
        );
  }

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
}
