import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/features/account/domain/entities/user.dart';
import 'package:gnawledge_admin/features/account/domain/repositories/account_repository.dart';
import 'package:gnawledge_admin/features/account/domain/usecases/change_password.dart';
import 'package:gnawledge_admin/features/account/domain/usecases/update_profile.dart';

class AccountState {
  const AccountState({required this.me});
  final AsyncValue<UserEntity> me;
  AccountState copyWith({AsyncValue<UserEntity>? me}) =>
      AccountState(me: me ?? this.me);
}

class AccountController extends StateNotifier<AccountState> {
  AccountController({
    required this.updateProfileUc,
    required this.changePasswordUc,
    required this.repo,
  }) : super(const AccountState(me: AsyncLoading())) {
    refresh();
  }
  final UpdateProfile updateProfileUc;
  final ChangePassword changePasswordUc;
  final AccountRepository repo;

  Future<void> refresh() async {
    state = state.copyWith(me: const AsyncLoading());
    try {
      final user = await repo.getMe();
      state = state.copyWith(me: AsyncData(user));
    } catch (e, st) {
      state = state.copyWith(me: AsyncError(e, st));
    }
  }

  Future<UserEntity> updateProfile(String fullName) async {
    final updated = await updateProfileUc(fullName);
    state = state.copyWith(me: AsyncData(updated));
    return updated;
  }

  Future<void> changePassword(
          {required String current, required String next}) =>
      changePasswordUc(current: current, next: next);
}
