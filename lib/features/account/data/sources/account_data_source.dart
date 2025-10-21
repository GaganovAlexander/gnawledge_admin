import 'package:gnawledge_admin/features/account/data/models/user_dto.dart';

abstract class AccountDataSource {
  Future<UserDto> getMe();
  Future<UserDto> updateProfile({required String fullName});
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
}
