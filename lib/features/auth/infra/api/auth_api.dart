import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/auth/data/models/auth_tokens_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: '/')
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<AuthTokensDto> signIn(@Body() Map<String, dynamic> body);

  @POST('/auth/refresh')
  Future<AuthTokensDto> refresh(@Body() Map<String, dynamic> body);

  @POST('/auth/password/reset')
  Future<void> requestPasswordReset(@Body() Map<String, dynamic> body);
}
