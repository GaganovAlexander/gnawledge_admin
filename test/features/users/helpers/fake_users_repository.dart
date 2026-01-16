import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/domain/repositories/users_repository.dart';

class FakeUsersRepository implements UsersRepository {
  final List<AppUser> _users = [];
  bool shouldThrow = false;
  String? lastQuery;
  AppUser? lastCreatedUser;
  AppUser? lastUpdatedUser;
  int? lastDeletedId;

  void seedUsers(List<AppUser> users) {
    _users.clear();
    _users.addAll(users);
  }

  @override
  Future<List<AppUser>> list(String? query) async {
    lastQuery = query;

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
  Future<AppUser> create(AppUser user) async {
    lastCreatedUser = user;

    if (shouldThrow) {
      throw Exception('Create user failed');
    }

    _users.add(user);
    return user;
  }

  @override
  Future<AppUser> update(AppUser user) async {
    lastUpdatedUser = user;

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
    lastDeletedId = id;

    if (shouldThrow) {
      throw Exception('Delete user failed');
    }

    _users.removeWhere((user) => user.id == id);
  }
}
