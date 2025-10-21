import 'package:gnawledge_admin/features/account/domain/entities/user.dart';
import 'package:gnawledge_admin/features/account/domain/repositories/account_repository.dart';

class UpdateProfile {
  const UpdateProfile(this.repo);

  final AccountRepository repo;

  Future<UserEntity> call(String fullName) =>
      repo.updateProfile(fullName: fullName);
}
