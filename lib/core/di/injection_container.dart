import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scanner/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:scanner/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:scanner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:scanner/features/auth/domain/repositories/auth_repository.dart';
import 'package:scanner/features/auth/domain/usecase/get_current_user.dart';
import 'package:scanner/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:scanner/features/auth/domain/usecase/sign_out_use_case.dart';
import 'package:scanner/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:scanner/features/home/presentation/bloc/home_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  /// ============================
  /// EXTERNAL
  /// ============================
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  /// ============================
  /// DATA SOURCE
  /// ============================
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  /// ============================
  /// REPOSITORY
  /// ============================
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  /// ============================
  /// USE CASE
  /// ============================
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));

  /// ============================
  /// BLOC
  /// ============================
  sl.registerFactory(
    () => HomeBloc(
      getCurrentUser: sl(),
    ),
  );
}
