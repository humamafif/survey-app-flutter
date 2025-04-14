import 'package:survey_app/core/app/app_exports.dart';

var sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // FIREBASE
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // SIGN IN WITH GOOGLE
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(auth: sl(), googleSignIn: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases (pastikan ini sebelum AuthBloc)
  sl.registerLazySingleton(() => SigninUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignoutUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupWithGoogleUsecase(repository: sl()));
  sl.registerLazySingleton(() => SigninWithGoogleUsecase(repository: sl()));
  sl.registerLazySingleton(() => CheckAuthUsecase(repository: sl()));

  // Bloc
  sl.registerLazySingleton(
    () => AuthBloc(
      signInUseCase: sl(),
      signUpUseCase: sl(),
      signOutUseCase: sl(),
      checkAuthUsecase: sl(),
      signUpWithGoogleUsecase: sl(),
      signInWithGoogleUsecase: sl(),
    ),
  );
}
