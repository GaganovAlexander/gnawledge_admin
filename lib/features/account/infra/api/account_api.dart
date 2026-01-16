import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/account/data/models/user_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'account_api.g.dart';

@RestApi(baseUrl: '/api')
abstract class AccountApi {
  factory AccountApi(Dio dio, {String baseUrl}) = _AccountApi;

  @GET('/me/profile')
  Future<UserDto> getMe();

  @PATCH('/account/profile')
  Future<UserDto> updateProfile(@Body() Map<String, dynamic> body);

  @POST('/account/change-password')
  Future<void> changePassword(@Body() Map<String, dynamic> body);
}
