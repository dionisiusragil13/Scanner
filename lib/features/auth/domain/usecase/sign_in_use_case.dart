import 'package:scanner/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<void> call({required String email, required  password}) {
    return repository.signIn(email, password);
  }
}
