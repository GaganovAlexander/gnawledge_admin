import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';
import 'package:gnawledge_admin/features/auth/domain/repositories/auth_repository.dart';

class GetTokens {
  const GetTokens(this.repo);
  final AuthRepository repo;

  AuthTokens? call() {
    final a = repo.currentAccess();
    final r = repo.currentRefresh();
    if (a == null || r == null) return null;
    return AuthTokens(access: a, refresh: r);
  }
}
