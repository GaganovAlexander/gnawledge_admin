import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';
import 'package:gnawledge_admin/features/auth/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  String? _access;
  String? _refresh;
  bool _accessValid = true;
  bool shouldThrow = false;

  void seedTokens({String? access, String? refresh}) {
    _access = access;
    _refresh = refresh;
  }

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
      _access = 'mock_access_admin_123';
      _refresh = 'mock_refresh_admin_456';
      _accessValid = true;
      return AuthTokens(access: _access!, refresh: _refresh!);
    }

    throw Exception('Invalid credentials');
  }

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    if (shouldThrow) {
      throw Exception('Refresh failed');
    }

    _access = 'new_access_token';
    _refresh = 'new_refresh_token';
    _accessValid = true;
    return AuthTokens(access: _access!, refresh: _refresh!);
  }

  @override
  Future<void> signOut() async {
    _access = null;
    _refresh = null;
    _accessValid = false;
  }

  @override
  String? currentAccess() => _access;

  @override
  String? currentRefresh() => _refresh;

  @override
  bool isAccessValid() => _accessValid && _access != null;

  @override
  Future<void> requestPasswordReset(String email) async {
    if (shouldThrow) {
      throw Exception('Request password reset failed');
    }
    // Success - do nothing
  }
}
