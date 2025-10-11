import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/auth/data/sources/auth_data_source.dart';
import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';

class AuthRemoteDataSource implements AuthDataSource {
  AuthRemoteDataSource(this._dio);
  final Dio _dio;

  @override
  Future<AuthTokens> signIn(String email, String password) async {
    final resp = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    final d = resp.data!;
    return AuthTokens(
      access: d['access_token'] as String,
      refresh: d['refresh_token'] as String,
    );
  }

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    final resp = await _dio.post<Map<String, dynamic>>(
      '/auth/refresh',
      data: {'refresh_token': refreshToken},
    );
    final d = resp.data!;
    return AuthTokens(
      access: d['access_token'] as String,
      refresh: d['refresh_token'] as String,
    );
  }

  @override
  Future<void> requestPasswordReset(String email) async {
    await _dio.post<void>('/auth/password/reset', data: {'email': email});
  }
}
