import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/users/data/sources/users_data_source.dart';
import 'package:gnawledge_admin/features/users/infra/api/users_api.dart';

class UsersRemoteDataSource implements UsersDataSource {
  UsersRemoteDataSource(this.api);

  final UsersApi api;

  @override
  Future<List<UserDto>> list(String? query) => api.list(query);

  @override
  Future<UserDto> create(UserDto dto) => api.create(dto);

  @override
  Future<UserDto> update(UserDto dto) => api.update(dto.id, dto);

  @override
  Future<void> delete(int id) => api.delete(id);
}
