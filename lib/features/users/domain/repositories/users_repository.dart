import 'package:gnawledge_admin/features/users/domain/entities/user.dart';

abstract class UsersRepository {
  Future<List<AppUser>> list(String? query);
  Future<AppUser> create(AppUser user);
  Future<AppUser> update(AppUser user);
  Future<void> delete(int id);
}
