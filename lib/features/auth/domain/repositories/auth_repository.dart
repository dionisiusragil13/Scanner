import 'package:scanner/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> signUp(
    String email,
    String password,
    String name,
    String phoneNumber,
  );
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
}
