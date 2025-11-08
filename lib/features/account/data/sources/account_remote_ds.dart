import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/account/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_data_source.dart';
import 'package:gnawledge_admin/features/account/infra/api/account_api.dart';

class AccountRemoteDataSource implements AccountDataSource {
  AccountRemoteDataSource(Dio dio) : _api = AccountApi(dio);
  final AccountApi _api;

  @override
  Future<UserDto> getMe() => _api.getMe();

  @override
  Future<UserDto> updateProfile({required String fullName}) =>
      _api.updateProfile({'full_name': fullName});

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) =>
      _api.changePassword({
        'current_password': currentPassword,
        'new_password': newPassword,
      });
}
