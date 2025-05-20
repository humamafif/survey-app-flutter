import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/presentation/bloc/dosens_bloc.dart';
import 'package:survey_app/features/mata_kuliah/presentation/bloc/mata_kuliah_bloc.dart';
import 'package:survey_app/features/questions/presentation/bloc/questions_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsBinding.instance);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initServiceLocator();
  Future.delayed(
    const Duration(seconds: 2),
    () => FlutterNativeSplash.remove(),
  );
  runApp(const SurveyApp());
}

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(CheckAuthEvent()),
        ),
        BlocProvider<DosensBloc>(
          create: (context) => sl<DosensBloc>()..add(GetAllDosensEvent()),
        ),
        BlocProvider<MataKuliahBloc>(
          create:
              (context) => sl<MataKuliahBloc>()..add(GetAllMataKuliahEvent()),
        ),
        BlocProvider<QuestionsBloc>(
          create: (context) => sl<QuestionsBloc>()..add(GetAllQuestionsEvent()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Survey App',
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
