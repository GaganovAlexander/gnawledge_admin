import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/auth/data/models/auth_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: '/api')
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<AuthResponseDto> signIn(@Body() Map<String, dynamic> body);

  @POST('/auth/refresh')
  Future<AuthResponseDto> refresh(@Body() Map<String, dynamic> body);

  @POST('/auth/reset_password')
  Future<void> resetPassword(@Body() Map<String, dynamic> body);

  @POST('/auth/set_new_password')
  Future<void> setNewPassword(@Body() Map<String, dynamic> body);
}
