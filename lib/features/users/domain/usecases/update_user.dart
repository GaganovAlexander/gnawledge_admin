import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/domain/repositories/users_repository.dart';

class UpdateUser {
  const UpdateUser(this.repo);

  final UsersRepository repo;

  Future<AppUser> call(AppUser user) => repo.update(user);
}
