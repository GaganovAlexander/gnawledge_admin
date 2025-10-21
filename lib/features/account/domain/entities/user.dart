class UserEntity {
  const UserEntity({
    required this.id,
    required this.email,
    this.fullName,
  });

  final String id;
  final String email;
  final String? fullName;

  UserEntity copyWith({String? fullName}) => UserEntity(
        id: id,
        email: email,
        fullName: fullName ?? this.fullName,
      );
}
