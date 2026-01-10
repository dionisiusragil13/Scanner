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
import 'package:scanner/features/expenses/data/datasource/expense_remote_data_source.dart';
import 'package:scanner/features/expenses/data/datasource/expense_remote_data_source_impl.dart';
import 'package:scanner/features/expenses/data/repositories/expense_repository_impl.dart';
import 'package:scanner/features/expenses/domain/repositories/expense_repository.dart';
import 'package:scanner/features/expenses/domain/usecase/add_expense_use_case.dart';
import 'package:scanner/features/home/presentation/bloc/home_bloc.dart';
import 'package:scanner/features/reminder/data/datasource/task_remote_data_source.dart';
import 'package:scanner/features/reminder/data/datasource/task_remote_data_source_impl.dart';
import 'package:scanner/features/reminder/data/repositories/task_repository_impl.dart';
import 'package:scanner/features/reminder/domain/repositories/task_repository.dart';
import 'package:scanner/features/reminder/domain/usecase/add_task_use_case.dart';
import 'package:scanner/features/reminder/domain/usecase/completed_task_use_case.dart';
import 'package:scanner/features/reminder/domain/usecase/delete_task_use_case.dart';
import 'package:scanner/features/reminder/domain/usecase/get_all_task_use_case.dart';
import 'package:scanner/features/reminder/domain/usecase/toggle_star_task_use_case.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_bloc.dart';
import 'package:scanner/features/reminder/presentation/bloc/task_event.dart';
import 'package:scanner/features/scan/data/repositories/receipt_scan_repository_impl.dart';
import 'package:scanner/features/scan/data/services/entity_recognition_service.dart';
import 'package:scanner/features/scan/data/services/receipt_text_preprocessor.dart';
import 'package:scanner/features/scan/data/services/text_recognition_service.dart';
import 'package:scanner/features/scan/domain/repositories/receipt_scan_repository.dart';
import 'package:scanner/features/scan/domain/usecase/process_receipt_scan_use_case.dart';

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
  sl.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<ExpenseRemoteDataSource>(
    () => ExpenseRemoteDataSourceImpl(sl()),
  );

  /// ============================
  /// SERVICE
  /// ============================
  sl.registerLazySingleton<TextRecognitionService>(
    () => TextRecognitionService(),
  );

  sl.registerLazySingleton<EntityRecognitionService>(
    () => EntityRecognitionService(),
  );
  sl.registerLazySingleton<ReceiptTextPreprocessor>(
    () => ReceiptTextPreprocessor(),
  );

  /// ============================
  /// REPOSITORY
  /// ============================
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(sl()));
  sl.registerLazySingleton<ExpenseRepository>(
    () => ExpenseRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ReceiptScanRepository>(
    () => ReceiptScanRepositoryImpl(
      textRecognition: sl(),
      entityRecognition: sl(),
      preprocessor: sl(),
    ),
  );

  /// ============================
  /// USE CASE
  /// ============================
  //auth
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));

  //task
  sl.registerLazySingleton(() => AddTaskUseCase(sl()));
  sl.registerLazySingleton(() => GetAllTaskUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTaskUseCase(sl()));
  sl.registerLazySingleton(() => ToggleStarTaskUseCase(sl()));
  sl.registerLazySingleton(() => CompletedTaskUseCase(sl()));
  sl.registerLazySingleton(() => LoadTasks());

  sl.registerLazySingleton<AddExpenseUseCase>(
  () => AddExpenseUseCase(sl()),
);

  sl.registerLazySingleton(() => ProcessReceiptScanUseCase(sl()));

  /// ============================
  /// BLOC
  /// ============================
  /// auth
  sl.registerFactory(() => HomeBloc(getCurrentUser: sl()));

  //task
  sl.registerFactory(
    () => TaskBloc(
      loadTasks: sl(),
      getCurrentUser: sl(),
      addTaskUseCase: sl(),
      getAllTaskUseCase: sl(),
      deleteTaskUseCase: sl(),
      toggleStarTaskUseCase: sl(),
      completedTaskUseCase: sl(),
    ),
  );
}
