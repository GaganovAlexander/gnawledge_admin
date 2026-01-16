import 'package:gnawledge_admin/features/auth/data/sources/auth_data_source.dart';
import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';

class FakeAuthDataSource implements AuthDataSource {
  bool shouldThrow = false;
  AuthTokens? tokensToReturn;

  @override
  Future<AuthTokens> signIn({
    required String email,
    required String password,
  }) async {
    if (shouldThrow) {
      throw Exception('Sign in failed');
    }

    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    if (email == 'admin@example.com' && password == 'admin123') {
      return tokensToReturn ??
          const AuthTokens(
            access: 'mock_access_admin_123',
            refresh: 'mock_refresh_admin_456',
          );
    }

    throw Exception('Invalid credentials');
  }

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    if (shouldThrow) {
      throw Exception('Refresh failed');
    }

    return tokensToReturn ??
        const AuthTokens(
          access: 'new_access_token',
          refresh: 'new_refresh_token',
        );
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    if (shouldThrow) {
      throw Exception('Request password reset failed');
    }
  }
}
