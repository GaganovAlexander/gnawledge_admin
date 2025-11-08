import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/di.dart';
import 'package:gnawledge_admin/core/network/dio_client.dart';
import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/create_user.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/delete_user.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/list_users.dart';
import 'package:gnawledge_admin/features/users/domain/usecases/update_user.dart';
import 'package:gnawledge_admin/features/users/infra/api/users_api.dart';
import 'package:gnawledge_admin/features/users/presentation/controllers/users_controller.dart';

final usersApiProvider = Provider((ref) {
  final dio = ref.read(dioClientProvider);
  return UsersApi(dio);
});

final usersRepoProvider = Provider((ref) => ref.read(usersRepositoryProvider));

final listUsersProvider =
    Provider((ref) => ListUsers(ref.read(usersRepoProvider)));
final createUserProvider =
    Provider((ref) => CreateUser(ref.read(usersRepoProvider)));
final updateUserProvider =
    Provider((ref) => UpdateUser(ref.read(usersRepoProvider)));
final deleteUserProvider =
    Provider((ref) => DeleteUser(ref.read(usersRepoProvider)));

final usersControllerProvider =
    StateNotifierProvider<UsersController, AsyncValue<List<AppUser>>>((ref) {
  return UsersController(
    listUsers: ref.read(listUsersProvider),
    createUser: ref.read(createUserProvider),
    updateUser: ref.read(updateUserProvider),
    deleteUser: ref.read(deleteUserProvider),
  )..refresh();
});
