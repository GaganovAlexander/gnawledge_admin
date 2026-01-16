import 'package:gnawledge_admin/features/auth/data/sources/auth_data_source.dart';
import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';
import 'package:gnawledge_admin/features/auth/infra/api/auth_api.dart';

class AuthRemoteDataSource implements AuthDataSource {
  AuthRemoteDataSource(this.api);

  final AuthApi api;

  @override
  Future<AuthTokens> signIn({
    required String email,
    required String password,
  }) async {
    final response = await api.signIn({'email': email, 'password': password});
    return response.auth.toEntity();
  }

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    final response = await api.refresh({'refresh_token': refreshToken});
    return response.auth.toEntity();
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await api.resetPassword({'email': email});
  }
}
