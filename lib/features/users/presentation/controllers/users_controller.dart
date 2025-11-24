import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/create_user.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/delete_user.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/list_users.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/update_user.dart';

class UsersController extends StateNotifier<AsyncValue<List<AppUser>>> {
  UsersController({
    required this.listUsers,
    required this.createUser,
    required this.updateUser,
    required this.deleteUser,
  }) : super(const AsyncValue.loading());

  final ListUsers listUsers;
  final CreateUser createUser;
  final UpdateUser updateUser;
  final DeleteUser deleteUser;

  String? _query;
  Timer? _debounce;

  void setQuery(String? q) {
    const debounceDelay = 300;

    final v = q?.trim();
    _query = (v == null || v.isEmpty) ? null : v;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: debounceDelay), refresh);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final data = await listUsers(_query);
      state = AsyncValue.data(data);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(AppUser u) async {
    final created = await createUser(u);
    final list = [...?state.value, created];
    state = AsyncValue.data(list);
  }

  Future<void> edit(AppUser u) async {
    final upd = await updateUser(u);
    final list = [...?state.value];
    final i = list.indexWhere((e) => e.id == upd.id);
    if (i >= 0) list[i] = upd;
    state = AsyncValue.data(list);
  }

  Future<void> remove(int id) async {
    await deleteUser(id);
    final list = [...?state.value]..removeWhere((e) => e.id == id);
    state = AsyncValue.data(list);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
