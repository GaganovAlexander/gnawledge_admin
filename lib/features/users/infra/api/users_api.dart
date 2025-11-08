import 'package:dio/dio.dart';
import 'package:gnawledge_admin/features/users/data/models/user_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'users_api.g.dart';

@RestApi()
abstract class UsersApi {
  factory UsersApi(Dio dio, {String baseUrl}) = _UsersApi;

  @GET('/users')
  Future<List<UserDto>> list(@Query('q') String? query);

  @POST('/users')
  Future<UserDto> create(@Body() UserDto body);

  @PUT('/users/{id}')
  Future<UserDto> update(@Path('id') int id, @Body() UserDto body);

  @DELETE('/users/{id}')
  Future<void> delete(@Path('id') int id);
}
