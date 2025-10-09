import 'package:gnawledge_admin/features/auth/domain/entities/auth_tokens.dart';
import 'package:gnawledge_admin/features/auth/domain/repositories/auth_repository.dart';

class SignIn {
  const SignIn(this.repo);
  final AuthRepository repo;
  Future<AuthTokens> call({required String email, required String password}) =>
      repo.signIn(email: email, password: password);
}
