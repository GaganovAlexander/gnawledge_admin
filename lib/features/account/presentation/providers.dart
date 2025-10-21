import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/env.dart';
import 'package:gnawledge_admin/core/network/dio_client.dart';
import 'package:gnawledge_admin/features/account/data/repositories/account_repository_impl.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_data_source.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_mock_ds.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_remote_ds.dart';
import 'package:gnawledge_admin/features/account/domain/repositories/account_repository.dart';
import 'package:gnawledge_admin/features/account/domain/usecases/change_password.dart';
import 'package:gnawledge_admin/features/account/domain/usecases/update_profile.dart';
import 'package:gnawledge_admin/features/account/presentation/controllers/account_controller.dart';

final accountDataSourceProvider = Provider<AccountDataSource>((ref) {
  final env = ref.watch(envProvider);
  if (env.useMocks) {
    return AccountMockDataSource();
  } else {
    final dio = ref.watch(dioProvider);
    return AccountRemoteDataSource(dio);
  }
});

final accountRepoProvider = Provider<AccountRepository>(
  (ref) => AccountRepositoryImpl(ref.watch(accountDataSourceProvider)),
);

final updateProfileProvider = Provider<UpdateProfile>(
  (ref) => UpdateProfile(ref.watch(accountRepoProvider)),
);

final changePasswordProvider = Provider<ChangePassword>(
  (ref) => ChangePassword(ref.watch(accountRepoProvider)),
);

final accountControllerProvider =
    StateNotifierProvider<AccountController, AccountState>((ref) {
  return AccountController(
    updateProfileUc: ref.watch(updateProfileProvider),
    changePasswordUc: ref.watch(changePasswordProvider),
    repo: ref.watch(accountRepoProvider),
  );
});
