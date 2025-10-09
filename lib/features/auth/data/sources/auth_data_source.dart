import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';

abstract class AuthDataSource {
  Future<AuthTokens> signIn(String email, String password);
  Future<AuthTokens> refresh(String refreshToken);
}
