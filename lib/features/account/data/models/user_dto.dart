import 'package:gnawledge_admin/features/account/domain/entities/user.dart';

class UserDto {
  const UserDto({
    required this.id,
    required this.email,
    this.fullName,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json['id']?.toString() ?? '',
        email: json['email'] as String,
        fullName: json['full_name'] as String?,
      );

  factory UserDto.fromEntity(UserEntity e) => UserDto(
        id: e.id,
        email: e.email,
        fullName: e.fullName,
      );

  final String id;
  final String email;
  final String? fullName;

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'full_name': fullName,
      };

  UserEntity toEntity() => UserEntity(id: id, email: email, fullName: fullName);
}
