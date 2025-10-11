import 'dart:async';
import 'package:gnawledge_admin/features/auth/data/sources/auth_data_source.dart';
import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';

class AuthMockDataSource implements AuthDataSource {
  static const _validEmail = 'admin@example.com';
  static const _validPassword = 'admin123';

  @override
  Future<AuthTokens> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }
    if (email != _validEmail || password != _validPassword) {
      throw Exception('Invalid credentials');
    }
    return const AuthTokens(
      access: 'mock_access_admin_123',
      refresh: 'mock_refresh_admin_456',
    );
  }

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (refreshToken.isEmpty) throw Exception('No refresh token provided');
    return const AuthTokens(
      access: 'mock_access_new',
      refresh: 'mock_refresh_admin_456',
    );
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
