import 'package:gnawledge_admin/features/account/domain/entities/user.dart';

class UserDto {
  const UserDto({
    required this.id,
    required this.email,
    required this.fullName,
  });

  final String id;
  final String email;
  final String fullName;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final parts = <String>[
      json['surname'] as String? ?? '',
      json['name'] as String? ?? '',
      json['middle_name'] as String? ?? '',
    ].where((e) => e.trim().isNotEmpty).toList(growable: false);

    final fullName = parts.join(' ');

    final rawId = json['book_id'] ?? json['email'];

    return UserDto(
      id: rawId.toString(),
      email: json['email'] as String? ?? '',
      fullName: fullName,
    );
  }

  UserEntity toEntity() => UserEntity(id: id, email: email, fullName: fullName);
}
