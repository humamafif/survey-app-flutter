import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/mata_kuliah/presentation/pages/select_mata_kuliah_dosen_page.dart';
import 'package:survey_app/features/questions/presentation/pages/questions_list_page.dart';
import 'package:survey_app/shared/pages/loading_page.dart';

/*
Example Use of Go_Router:

  Go To Another Page:
    context.pushNamed(
      AppRoutesEnum.register.name),

  Go To Another Page with parameter:
    context.push(
      AppRoutesEnum.register.path,
      extras: data
      )

  Go To Previous Page:
    context.pop();

*/

class AppRouter {
  static final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  // Home branch
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'Home',
  );

  // Profile branch
  static final _shellNavigatorProfile = GlobalKey<NavigatorState>(
    debugLabel: 'Profile',
  );

  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRouteEnum.home.path,
    debugLogDiagnostics: true,
    routes: [
      /*
        example use of go_router:
        GoRoute(
          parentNavigatorKey: _rootNavigatorKey, ** parent key, use _rootNavigatorKey, if page is not nested, if nested use _shellNavigator key instead, like _shellNavigatorHome **
          path: AppRouteEnum.login.name,  ** Route Path, use AppRouteEnum, add item in AppRouteEnum if neccessarily **
          builder: (context, state) => MyPage()
        )        
      */
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRouteEnum.login.path,
        name: AppRouteEnum.login.name,
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRouteEnum.loadingPage.path,
        name: AppRouteEnum.loadingPage.name,
        builder: (context, state) => LoadingPage(),
      ),
      //Main Page
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) => NavigationPage(
              navigationShell: navigationShell,
              scaffoldKey: _scaffoldKey,
            ),
        branches: [
          //home index = 0
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorHome,
                path: AppRouteEnum.home.path,
                name: AppRouteEnum.home.name,
                pageBuilder:
                    (context, state) => NoTransitionPage(child: HomePage()),
                routes: [
                  GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: AppRouteEnum.selectMataKuliahDosen.path,
                    name: AppRouteEnum.selectMataKuliahDosen.name,
                    builder:
                        (context, state) =>
                            SelectMataKuliahDosenPage(surveyId: 1),
                    pageBuilder:
                        (context, state) => NoTransitionPage(
                          child: SelectMataKuliahDosenPage(surveyId: 1),
                        ),
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _rootNavigatorKey,
                        path: AppRouteEnum.questionPage.path,
                        name: AppRouteEnum.questionPage.name,
                        builder: (context, state) {
                          return QuestionsListPage(
                            dosenId: int.parse(
                              state.uri.queryParameters['dosenId']!,
                            ),
                            matakuliahId: int.parse(
                              state.uri.queryParameters['matakuliahId']!,
                            ),
                            surveyId: int.parse(
                              state.uri.queryParameters['surveyId']!,
                            ),
                            namaMk: state.uri.queryParameters['namaMk'],
                            namaDosen: state.uri.queryParameters['namaDosen'],
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorProfile,
                path: AppRouteEnum.profile.path,
                name: AppRouteEnum.profile.name,
                builder: (context, state) => ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
