import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/auth/data/sources/auth_data_source.dart';
import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';
import 'package:gnawledge_admin/features/auth/infra/api/auth_api.dart';

class AuthRemoteDataSource implements AuthDataSource {
  AuthRemoteDataSource(Dio dio) : _api = AuthApi(dio);
  final AuthApi _api;

  @override
  Future<AuthTokens> signIn(String email, String password) async {
    final dto = await _api.signIn({'email': email, 'password': password});
    return dto.toEntity();
  }

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    final dto = await _api.refresh({'refresh_token': refreshToken});
    return dto.toEntity();
  }

  @override
  Future<void> requestPasswordReset(String email) =>
      _api.requestPasswordReset({'email': email});
}
