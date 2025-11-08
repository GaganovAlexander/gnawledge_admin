import 'dart:async';
import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';
import 'package:gnawledge_admin/features/users/data/sources/users_data_source.dart';

class UsersMockDataSource implements UsersDataSource {
  final _items = <UserDto>[
    UserDto(
      id: 1,
      firstName: 'Sarah',
      lastName: 'Johnson',
      email: 'sarah.johnson@example.com',
      role: 'Admin',
      status: 'active',
      joinDate: DateTime(2024, 1, 15),
    ),
    UserDto(
      id: 2,
      firstName: 'Michael',
      lastName: 'Chen',
      email: 'michael.chen@example.com',
      role: 'Manager',
      status: 'active',
      joinDate: DateTime(2024, 2, 20),
    ),
    UserDto(
      id: 3,
      firstName: 'Emily',
      lastName: 'Rodriguez',
      email: 'emily.r@example.com',
      role: 'User',
      status: 'active',
      joinDate: DateTime(2024, 3, 10),
    ),
    UserDto(
      id: 4,
      firstName: 'James',
      lastName: 'Wilson',
      email: 'j.wilson@example.com',
      role: 'User',
      status: 'inactive',
      joinDate: DateTime(2024, 1, 5),
    ),
    UserDto(
      id: 5,
      firstName: 'Lisa',
      lastName: 'Anderson',
      email: 'lisa.a@example.com',
      role: 'Manager',
      status: 'active',
      joinDate: DateTime(2024, 4),
    ),
  ];

  @override
  Future<List<UserDto>> list(String? query) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (query == null || query.trim().isEmpty) {
      return List<UserDto>.from(_items);
    }
    final q = query.toLowerCase();
    return _items.where((u) {
      final name = '${u.firstName} ${u.lastName}'.toLowerCase();
      return name.contains(q) || u.email.toLowerCase().contains(q);
    }).toList(growable: false);
  }

  @override
  Future<UserDto> create(UserDto dto) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final nextId = (_items.isEmpty
            ? 0
            : _items.map((e) => e.id).reduce((a, b) => a > b ? a : b)) +
        1;
    final created = UserDto(
      id: nextId,
      firstName: dto.firstName,
      lastName: dto.lastName,
      email: dto.email,
      role: dto.role,
      status: dto.status,
      joinDate: dto.joinDate,
    );
    _items.add(created);
    return created;
  }

  @override
  Future<UserDto> update(UserDto dto) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final i = _items.indexWhere((e) => e.id == dto.id);
    if (i >= 0) {
      _items[i] = dto;
      return dto;
    }
    throw StateError('User not found');
  }

  @override
  Future<void> delete(int id) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _items.removeWhere((e) => e.id == id);
  }
}
