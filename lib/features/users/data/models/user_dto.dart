import 'package:gnawledge_admin/features/users/domain/entities/user.dart';

class UserDto {
  const UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.roleLevel,
    this.birthDate,
    this.middleName,
    this.studentGroup,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      firstName: json['name'] as String? ?? '',
      lastName: json['surname'] as String? ?? '',
      email: json['email'] as String? ?? '',
      roleLevel: json['role_level'] as int? ?? 0,
      birthDate: json['birth_date'] as String?,
      middleName: json['middle_name'] as String?,
      studentGroup: json['student_group'] as String?,
    );
  }

  factory UserDto.fromEntity(AppUser user) {
    return UserDto(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      roleLevel: levelFromRole(user.role),
    );
  }

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int roleLevel;
  final String? birthDate;
  final String? middleName;
  final String? studentGroup;

  AppUser toEntity() {
    final join = DateTime.tryParse(birthDate ?? '') ?? DateTime(1970);
    return AppUser(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: _roleFromLevel(roleLevel),
      status: 'active',
      joinDate: join,
    );
  }

  Map<String, dynamic> toUpdateRequest() {
    return {
      'user_id': id,
      'new_data': {
        'email': email,
        'name': firstName,
        'surname': lastName,
        'middle_name': middleName,
        'student_group': studentGroup,
        'role_level': roleLevel,
        'birth_date': birthDate,
      },
    };
  }

  static String _roleFromLevel(int level) {
    if (level >= 2) return 'Admin';
    if (level == 1) return 'Manager';
    return 'User';
  }

  static int levelFromRole(String role) {
    switch (role) {
      case 'Admin':
        return 2;
      case 'Manager':
        return 1;
      default:
        return 0;
    }
  }

  UserDto copyWithFromEntity(AppUser user) {
    return UserDto(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      roleLevel: levelFromRole(user.role),
      birthDate: birthDate,
      middleName: middleName,
      studentGroup: studentGroup,
    );
  }
}
