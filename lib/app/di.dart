import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gnawledge_admin/app/env.dart';
import 'package:gnawledge_admin/core/security/token_storage.dart';
import 'package:gnawledge_admin/core/security/web_cookie_storage.dart';
import 'package:gnawledge_admin/core/security/web_cookie_token_storage.dart';
import 'package:gnawledge_admin/features/account/data/repositories/account_repository_impl.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_data_source.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_mock_ds.dart';
import 'package:gnawledge_admin/features/account/data/sources/account_remote_ds.dart';
import 'package:gnawledge_admin/features/account/domain/repositories/account_repository.dart';
import 'package:gnawledge_admin/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:gnawledge_admin/features/auth/data/sources/auth_data_source.dart';
import 'package:gnawledge_admin/features/auth/data/sources/auth_mock_ds.dart';
import 'package:gnawledge_admin/features/auth/data/sources/auth_remote_ds.dart';
import 'package:gnawledge_admin/features/auth/domain/repositories/auth_repository.dart';
import 'package:gnawledge_admin/features/auth/domain/usecases/get_tokens.dart';
import 'package:gnawledge_admin/features/auth/domain/usecases/request_password_reset.dart';
import 'package:gnawledge_admin/features/auth/domain/usecases/sign_in.dart';

final dioProvider = Provider<Dio>((ref) {
  final env = ref.watch(envProvider);
  return Dio(BaseOptions(baseUrl: env.apiBase));
});

final tokenStorageProvider = Provider<TokenStorage>((_) {
  return WebCookieTokenStorage(WebCookieStorage());
});

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  final env = ref.watch(envProvider);
  if (env.useMocks) {
    return AuthMockDataSource();
  } else {
    final dio = ref.watch(dioProvider);
    return AuthRemoteDataSource(dio);
  }
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    dataSource: ref.watch(authDataSourceProvider),
    tokens: ref.watch(tokenStorageProvider),
  );
});

final signInUseCaseProvider =
    Provider<SignIn>((ref) => SignIn(ref.watch(authRepositoryProvider)));
final getTokensUseCaseProvider =
    Provider<GetTokens>((ref) => GetTokens(ref.watch(authRepositoryProvider)));

final requestPasswordResetProvider = Provider<RequestPasswordReset>(
  (ref) => RequestPasswordReset(ref.watch(authRepositoryProvider)),
);

final accountDataSourceProvider = Provider<AccountDataSource>((ref) {
  final env = ref.watch(envProvider);
  if (env.useMocks) {
    return AccountMockDataSource();
  } else {
    final dio = ref.watch(dioProvider);
    return AccountRemoteDataSource(dio);
  }
});

final accountRepositoryProvider = Provider<AccountRepository>(
  (ref) => AccountRepositoryImpl(ref.watch(accountDataSourceProvider)),
);
