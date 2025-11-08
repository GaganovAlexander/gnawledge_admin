class AppUser {
  const AppUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.role,
    required this.status,
    required this.joinDate,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;
  final String status;
  final DateTime joinDate;

  String get fullName => '$firstName $lastName';
}
