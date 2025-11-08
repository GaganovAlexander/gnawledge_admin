import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';

abstract class UsersDataSource {
  Future<List<UserDto>> list(String? query);
  Future<UserDto> create(UserDto dto);
  Future<UserDto> update(UserDto dto);
  Future<void> delete(int id);
}
