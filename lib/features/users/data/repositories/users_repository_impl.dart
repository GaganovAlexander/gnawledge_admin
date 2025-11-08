import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/users/data/sources/users_data_source.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/domain/repositories/users_repository.dart';

class UsersRepositoryImpl implements UsersRepository {
  UsersRepositoryImpl(this.ds);

  final UsersDataSource ds;

  @override
  Future<List<AppUser>> list(String? query) async =>
      (await ds.list(query)).map((e) => e.toEntity()).toList();

  @override
  Future<AppUser> create(AppUser user) async =>
      (await ds.create(UserDto.fromEntity(user))).toEntity();

  @override
  Future<AppUser> update(AppUser user) async =>
      (await ds.update(UserDto.fromEntity(user))).toEntity();

  @override
  Future<void> delete(int id) => ds.delete(id);
}
