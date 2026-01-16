import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'users_api.g.dart';

@RestApi(baseUrl: '/api')
abstract class UsersApi {
  factory UsersApi(Dio dio, {String baseUrl}) = _UsersApi;

  @GET('/admin/users')
  Future<List<UserDto>> list();

  @POST('/users')
  Future<UserDto> create(@Body() UserDto body);

  @PATCH('/admin/update_user')
  Future<UserDto> update(@Body() Map<String, dynamic> body);

  @DELETE('/admin/delete_user/{email}')
  Future<void> delete(@Path('email') String email);
}
