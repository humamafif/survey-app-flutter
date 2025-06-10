import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/data/datasources/dosen_remote_datasource.dart';
import 'package:survey_app/features/dosens/data/repositories/dosen_repo_impl.dart';
import 'package:survey_app/features/dosens/domain/repositories/dosen_repository.dart';
import 'package:survey_app/features/dosens/domain/usecases/get_all_dosen_usecase.dart';
import 'package:survey_app/features/dosens/presentation/bloc/dosens_bloc.dart';
import 'package:survey_app/features/mata_kuliah/data/datasources/mata_kuliah_data_source.dart';
import 'package:survey_app/features/mata_kuliah/data/repositories/mata_kuliah_repository_impl.dart';
import 'package:survey_app/features/mata_kuliah/domain/repositories/mata_kuliah_repository.dart';
import 'package:survey_app/features/mata_kuliah/domain/usecases/get_all_mata_kuliah_usecase.dart';
import 'package:survey_app/features/mata_kuliah/domain/usecases/get_mata_kuliah_by_dosen_id_usecase.dart';
import 'package:survey_app/features/mata_kuliah/domain/usecases/get_mata_kuliah_by_id_usecase.dart';
import 'package:survey_app/features/mata_kuliah/presentation/bloc/mata_kuliah_bloc.dart';
import 'package:survey_app/features/questions/data/datasources/question_remote_datasource.dart';
import 'package:survey_app/features/questions/data/repositories/question_repository_impl.dart';
import 'package:survey_app/features/questions/domain/repositories/question_repository.dart';
import 'package:survey_app/features/questions/domain/usecases/get_all_question_usecase.dart';
import 'package:survey_app/features/questions/domain/usecases/get_question_by_survey_id_usecase.dart';
import 'package:survey_app/features/questions/presentation/bloc/questions_bloc.dart';
import 'package:survey_app/features/responses/data/datasources/response_remote_data_source.dart';
import 'package:survey_app/features/responses/data/repositories/response_repository_impl.dart';
import 'package:survey_app/features/responses/domain/repositories/response_repository.dart';
import 'package:survey_app/features/responses/domain/usecases/create_multiple_responses_usecase.dart';
import 'package:survey_app/features/responses/domain/usecases/create_multiple_responses_with_assesment_usecase.dart';
import 'package:survey_app/features/responses/domain/usecases/create_response_usecase.dart';
import 'package:survey_app/features/responses/domain/usecases/get_responses_by_survey_usecase.dart';
import 'package:survey_app/features/responses/domain/usecases/get_responses_by_user_usecase.dart';
import 'package:survey_app/features/responses/presentation/bloc/responses_bloc.dart';

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
