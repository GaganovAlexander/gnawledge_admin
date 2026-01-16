import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/users/data/sources/users_data_source.dart';

class FakeUsersDataSource implements UsersDataSource {
  final List<UserDto> _users = [];
  bool shouldThrow = false;

  void seedUsers(List<UserDto> users) {
    _users.clear();
    _users.addAll(users);
  }

  @override
  Future<List<UserDto>> list(String? query) async {
    if (shouldThrow) {
      throw Exception('List users failed');
    }

    if (query == null || query.isEmpty) {
      return List.from(_users);
    }

    return _users.where((user) {
      final searchTerm = query.toLowerCase();
      return user.firstName.toLowerCase().contains(searchTerm) ||
          user.lastName.toLowerCase().contains(searchTerm) ||
          user.email.toLowerCase().contains(searchTerm);
    }).toList();
  }

  @override
  Future<UserDto> create(UserDto user) async {
    if (shouldThrow) {
      throw Exception('Create user failed');
    }

    _users.add(user);
    return user;
  }

  @override
  Future<UserDto> update(UserDto user) async {
    if (shouldThrow) {
      throw Exception('Update user failed');
    }

    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
    }
    return user;
  }

  @override
  Future<void> delete(int id) async {
    if (shouldThrow) {
      throw Exception('Delete user failed');
    }

    _users.removeWhere((user) => user.id == id);
  }
}
