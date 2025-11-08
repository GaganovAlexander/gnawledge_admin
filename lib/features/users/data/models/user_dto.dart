import 'package:gnawledge_admin/features/users/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.status,
    required this.joinDate,
  });

  factory UserDto.fromEntity(AppUser u) => UserDto(
        id: u.id,
        firstName: u.firstName,
        lastName: u.lastName,
        email: u.email,
        role: u.role,
        status: u.status,
        joinDate: u.joinDate,
      );

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  final int id;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  final String role;
  final String status;
  @JsonKey(name: 'join_date')
  final DateTime joinDate;
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  AppUser toEntity() => AppUser(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        role: role,
        status: status,
        joinDate: joinDate,
      );
}
