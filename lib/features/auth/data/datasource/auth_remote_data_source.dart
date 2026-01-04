
import 'package:scanner/features/auth/data/models/user_models.dart';

abstract class AuthRemoteDataSource {
  Future<UserModels> signIn(String email, String password);
  Future<UserModels> signUp(
    String email,
    String password,
    String name,
    String phoneNumber,
  );
  Future<void> signOut();
  Future<UserModels?> getCurrentUser();
}
