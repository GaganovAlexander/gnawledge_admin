import 'package:gnawledge_admin/features/account/domain/repositories/account_repository.dart';

class ChangePassword {
  const ChangePassword(this.repo);
  final AccountRepository repo;

  Future<void> call({
    required String current,
    required String next,
  }) =>
      repo.changePassword(
        currentPassword: current,
        newPassword: next,
      );
}
