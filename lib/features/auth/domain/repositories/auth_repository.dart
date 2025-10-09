import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';

abstract class AuthRepository {
  Future<AuthTokens> signIn({required String email, required String password});
  Future<AuthTokens> refresh(String refreshToken);
  Future<void> signOut();
  String? currentAccess();
  String? currentRefresh();
  bool isAccessValid();
}
