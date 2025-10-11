import 'package:gnawledge_admin/core/security/jwt_utils.dart';
import 'package:gnawledge_admin/core/security/token_storage.dart';
import 'package:gnawledge_admin/features/auth/data/sources/auth_data_source.dart';
import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';
import 'package:gnawledge_admin/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthDataSource dataSource,
    required this.tokens,
  }) : _ds = dataSource;

  final AuthDataSource _ds;
  final TokenStorage tokens;

  @override
  Future<AuthTokens> signIn({
    required String email,
    required String password,
  }) async {
    final t = await _ds.signIn(email, password);
    await tokens.save(access: t.access, refresh: t.refresh);
    return t;
  }

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    final t = await _ds.refresh(refreshToken);
    await tokens.save(access: t.access, refresh: t.refresh);
    return t;
  }

  @override
  Future<void> signOut() => tokens.clear();

  @override
  String? currentAccess() => tokens.readAccess();

  @override
  String? currentRefresh() => tokens.readRefresh();

  @override
  bool isAccessValid() => isAccessTokenValid(tokens.readAccess());

  @override
  Future<void> requestPasswordReset(String email) async {
    await _ds.requestPasswordReset(email);
  }
}
