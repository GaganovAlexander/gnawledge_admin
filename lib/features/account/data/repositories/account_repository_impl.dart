import 'package:gnawledge_admin/features/account/data/sources/account_data_source.dart';
import 'package:gnawledge_admin/features/account/domain/entities/user.dart';
import 'package:gnawledge_admin/features/account/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this.dataSource);
  final AccountDataSource dataSource;

  @override
  Future<UserEntity> getMe() async => (await dataSource.getMe()).toEntity();

  @override
  Future<UserEntity> updateProfile({required String fullName}) async =>
      (await dataSource.updateProfile(fullName: fullName)).toEntity();

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) =>
      dataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
}
