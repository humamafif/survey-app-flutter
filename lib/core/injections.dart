import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/data/datasources/dosen_remote_datasource.dart';
import 'package:survey_app/features/dosens/data/repositories/dosen_repo_impl.dart';
import 'package:survey_app/features/dosens/domain/repositories/dosen_repository.dart';
import 'package:survey_app/features/dosens/domain/usecases/get_all_dosen_usecase.dart';
import 'package:survey_app/features/dosens/domain/usecases/get_dosen_by_id_usecase.dart';
import 'package:survey_app/features/dosens/domain/usecases/get_dosen_byname_usecase.dart';
import 'package:survey_app/features/dosens/presentation/bloc/dosens_bloc.dart';

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

  // Use cases (pastikan ini sebelum AuthBloc)

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
  sl.registerLazySingleton(() => GetDosenByIdUsecase(sl()));
  sl.registerLazySingleton(() => GetDosenBynameUsecase(sl()));

  sl.registerLazySingleton(() => DosensBloc(sl()));
}
