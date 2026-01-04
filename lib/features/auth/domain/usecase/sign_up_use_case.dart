import 'package:scanner/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<void> call({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) {
    return repository.signUp(email, password, name, phoneNumber);
  }
}
