import 'package:gnawledge_admin/features/users/domain/repositories/users_repository.dart';

class DeleteUser {
  const DeleteUser(this.repo);

  final UsersRepository repo;

  Future<void> call(int id) => repo.delete(id);
}
