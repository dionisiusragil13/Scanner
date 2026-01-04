import 'package:get_it/get_it.dart';
import 'package:scanner/features/home/presentation/bloc/home_bloc.dart';


final sl = GetIt.instance;

Future<void> init() async {
  /// =========================
  /// AUTH (sudah kamu buat)
  /// =========================
  // sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(...));
  // sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  // sl.registerLazySingleton(() => GetCurrentUser(sl()));

  /// =========================
  /// HOME
  /// =========================
  sl.registerFactory(
    () => HomeBloc(
      getCurrentUser: sl(),
    ),
  );
}
