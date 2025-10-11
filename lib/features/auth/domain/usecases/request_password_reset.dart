import 'package:gnawledge_admin/features/auth/domain/repositories/auth_repository.dart';

class RequestPasswordReset {
  const RequestPasswordReset(this.repo);
  final AuthRepository repo;

  Future<void> call(String email) => repo.requestPasswordReset(email);
}
