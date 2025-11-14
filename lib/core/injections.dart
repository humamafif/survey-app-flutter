import 'package:survey_app/core/app/app_exports.dart';

var sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // ENV
  await dotenv.load(fileName: ".env");

  sl.registerLazySingleton(
    () => Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL']!)),
  );
  // FIREBASE
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // SIGN IN WITH GOOGLE
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(auth: sl(), googleSignIn: sl(), dio: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SignoutUsecase(repository: sl()));
  sl.registerLazySingleton(() => SigninWithGoogleUsecase(repository: sl()));
  sl.registerLazySingleton(() => CheckAuthUsecase(repository: sl()));

  // Bloc
  sl.registerLazySingleton(
    () => AuthBloc(
      signOutUseCase: sl(),
      checkAuthUsecase: sl(),
      signInWithGoogleUsecase: sl(),
    ),
  );

  // dosen
  sl.registerLazySingleton<DosenRemoteDatasource>(
    () => DosenRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<DosenRepository>(
    () => DosenRepoImpl(dosenRemoteDatasource: sl()),
  );
  sl.registerLazySingleton(() => GetAllDosenUsecase(sl()));
  sl.registerLazySingleton(() => DosensBloc(sl()));

  // Mata Kuliah Feature
  // Data sources
  sl.registerLazySingleton<MataKuliahRemoteDataSource>(
    () => MataKuliahRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<MataKuliahRepository>(
    () => MataKuliahRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllMataKuliahUsecase(sl()));
  sl.registerLazySingleton(() => GetMataKuliahByIdUsecase(sl()));
  sl.registerLazySingleton(() => GetMataKuliahByDosenIdUsecase(sl()));

  // BLoC
  sl.registerFactory(
    () => MataKuliahBloc(
      getAllMataKuliahUsecase: sl(),
      getMataKuliahByIdUsecase: sl(),
      getMataKuliahByDosenIdUsecase: sl(),
    ),
  );

  // Questions Feature
  // Data sources
  sl.registerLazySingleton<QuestionRemoteDataSource>(
    () => QuestionRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<QuestionRepository>(
    () => QuestionRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllQuestionsUsecase(sl()));
  sl.registerLazySingleton(() => GetQuestionsBySurveyIdUsecase(sl()));

  // BLoC
  sl.registerFactory(
    () => QuestionsBloc(
      getAllQuestionsUsecase: sl(),
      getQuestionsBySurveyIdUsecase: sl(),
    ),
  );

  // Responses Feature
  // Data sources
  sl.registerLazySingleton<ResponseRemoteDataSource>(
    () => ResponseRemoteDataSourceImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<ResponseRepository>(
    () => ResponseRepositoryImpl(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => CreateResponseUsecase(sl()));
  sl.registerLazySingleton(() => CreateMultipleResponsesUsecase(sl()));
  sl.registerLazySingleton(
    () => CreateMultipleResponsesWithAssesmentUsecase(sl()),
  );
  sl.registerLazySingleton(() => GetResponsesByUserUsecase(sl()));
  sl.registerLazySingleton(() => GetResponsesBySurveyUsecase(sl()));

  // BLoC
  sl.registerFactory(
    () => ResponsesBloc(
      createResponseUsecase: sl(),
      createMultipleResponsesWithPenilaianUsecase: sl(),
      createMultipleResponsesUsecase: sl(),
      getResponsesByUserUsecase: sl(),
      getResponsesBySurveyUsecase: sl(),
    ),
  );
}
