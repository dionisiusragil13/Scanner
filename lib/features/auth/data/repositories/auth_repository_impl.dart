
import 'package:scanner/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:scanner/features/auth/data/models/user_models.dart';
import 'package:scanner/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<void> signOut() {
    return remote.signOut();
  }

  @override
  Future<UserModels?> getCurrentUser() {
    return remote.getCurrentUser();
  }
  @override
  Future<UserModels> signIn(String email, String password) async{
    return await remote.signIn(email, password);
  }
  @override
  Future<UserModels> signUp(
    String email,
    String password,
    String name,
    String phoneNumber,
  ) async{
    return await remote.signUp(email, password, name, phoneNumber);
  }
}
