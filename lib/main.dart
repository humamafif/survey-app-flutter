import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:survey_app/core/injections.dart';
import 'package:survey_app/core/router/app_route.dart';
import 'package:survey_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:survey_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initServiceLocator();
  runApp(SurveyApp());
}

class SurveyApp extends StatelessWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>())],
      child: ScreenUtilInit(
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Survey App',
          theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
