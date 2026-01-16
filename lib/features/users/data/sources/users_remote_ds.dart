import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/users/data/sources/users_data_source.dart';
import 'package:gnawledge_admin/features/users/infra/api/users_api.dart';

class UsersRemoteDataSource implements UsersDataSource {
  UsersRemoteDataSource(this.api);

  final UsersApi api;

  @override
  Future<List<UserDto>> list(String? query) async {
    final items = await api.list();
    if (query == null || query.trim().isEmpty) {
      return items;
    }
    final q = query.trim().toLowerCase();
    return items
        .where((u) {
          final name = '${u.firstName} ${u.lastName}'.toLowerCase();
          return name.contains(q) || u.email.toLowerCase().contains(q);
        })
        .toList(growable: false);
  }

  @override
  Future<UserDto> create(UserDto dto) => api.create(dto);

  @override
  Future<UserDto> update(UserDto dto) async {
    final body = dto.toUpdateRequest();
    final updated = await api.update(body);
    return updated;
  }

  @override
  Future<void> delete(int id) async {
    final items = await api.list();
    final user = items.firstWhere((u) => u.id == id);
    await api.delete(user.email);
  }
}
