import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/domain/repositories/users_repository.dart';

class ListUsers {
  const ListUsers(this.repo);

  final UsersRepository repo;

  Future<List<AppUser>> call(String? query) => repo.list(query);
}
