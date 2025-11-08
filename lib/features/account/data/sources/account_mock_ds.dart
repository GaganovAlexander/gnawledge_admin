import 'dart:async';
import 'package:gnawledge_admin/features/account/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_data_source.dart';

class AccountMockDataSource implements AccountDataSource {
  final UserDto _mockUser = const UserDto(
    id: '1',
    email: 'admin@example.com',
    fullName: 'Admin User',
  );

  @override
  Future<UserDto> getMe() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return _mockUser;
  }

  @override
  Future<UserDto> updateProfile({required String fullName}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return UserDto(
      id: _mockUser.id,
      email: _mockUser.email,
      fullName: fullName,
    );
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (currentPassword != 'admin123') {
      throw Exception('Invalid current password');
    }
  }
}
