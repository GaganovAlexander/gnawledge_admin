import 'package:gnawledge_admin/features/account/domain/entities/user.dart';

abstract class AccountRepository {
  Future<UserEntity> updateProfile({required String fullName});
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<UserEntity> getMe();
}
