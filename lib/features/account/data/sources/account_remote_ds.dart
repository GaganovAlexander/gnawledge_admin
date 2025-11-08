import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/account/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_data_source.dart';

class AccountRemoteDataSource implements AccountDataSource {
  AccountRemoteDataSource(this.dio);
  final Dio dio;

  @override
  Future<UserDto> getMe() async {
    final res = await dio.get<Map<String, dynamic>>('/account/me');
    return UserDto.fromJson(res.data!);
  }

  @override
  Future<UserDto> updateProfile({required String fullName}) async {
    final res = await dio.patch<Map<String, dynamic>>(
      '/account/profile',
      data: {'full_name': fullName},
    );
    return UserDto.fromJson(res.data!);
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await dio.post<Map<String, dynamic>>(
      '/account/change-password',
      data: {
        'current_password': currentPassword,
        'new_password': newPassword,
      },
    );
  }
}
