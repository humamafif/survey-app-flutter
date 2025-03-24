import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:survey_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:survey_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:survey_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:survey_app/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:survey_app/features/auth/domain/usecases/signin_usecase.dart';
import 'package:survey_app/features/auth/domain/usecases/signout_usecase.dart';
import 'package:survey_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_bloc.dart';

var sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // FIREBASE
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(auth: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases (pastikan ini sebelum AuthBloc)
  sl.registerLazySingleton(() => SigninUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignoutUsecase(repository: sl()));
  sl.registerLazySingleton(() => CheckAuthUsecase(repository: sl()));

  // Bloc
  sl.registerLazySingleton(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      checkAuthUsecase: sl(),
    ),
  );
}
