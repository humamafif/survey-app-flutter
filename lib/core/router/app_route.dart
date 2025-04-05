import 'package:survey_app/core/app/app_exports.dart';

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
    initialLocation: AppRouteEnum.splashScreen.path,
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
        path: AppRouteEnum.splashScreen.path,
        name: AppRouteEnum.splashScreen.name,
        builder:
            (context, state) =>
                SplashScreen(), //TODO Change Page (splashScreen)!
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRouteEnum.login.path,
        name: AppRouteEnum.login.name,
        builder: (context, state) => LoginPage(), //TODO Change Page (login)!
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: AppRouteEnum.register.path,
        name: AppRouteEnum.register.name,
        builder:
            (context, state) => RegisterPage(), //TODO Change Page (register)!
      ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: AppRouteEnum.surveyForm.path,
      //   name: AppRouteEnum.surveyForm.name,
      //   builder:
      //       (context, state) => SurveyPage(), //TODO Change Page (register)!
      // ),

      //Authentication
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: AppRouteEnum.login.path,
      //   name: AppRouteEnum.login.name,
      //   builder: (context, state) => Container(), //TODO Change Page (login)!
      // ),
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
                    path: AppRouteEnum.surveyForm.path,
                    name: AppRouteEnum.surveyForm.name,
                    builder: (context, state) => SurveyPage(),
                  ),
                  // GoRoute(
                  //   parentNavigatorKey: _rootNavigatorKey,
                  //   path: AppRouteEnum.member.path,
                  //   name: AppRouteEnum.member.name,
                  //   builder:
                  //       (context, state) =>
                  //           Container(), //TODO change page (member)!
                  //   routes: [
                  //     GoRoute(
                  //       parentNavigatorKey: _rootNavigatorKey,
                  //       path: AppRouteEnum.detailMember.path,
                  //       name: AppRouteEnum.detailMember.name,
                  //       builder:
                  //           (context, state) =>
                  //               Container(), //TODO change page (detailMember)!
                  //     ),
                  //   ],
                  // ),
                  // GoRoute(
                  //   parentNavigatorKey: _rootNavigatorKey,
                  //   path: AppRouteEnum.courses.path,
                  //   name: AppRouteEnum.courses.name,
                  //   builder:
                  //       (context, state) =>
                  //           Container(), //TODO change page (courses)
                  //   routes: [
                  //     GoRoute(
                  //       parentNavigatorKey: _rootNavigatorKey,
                  //       path: AppRouteEnum.detailCourse.path,
                  //       name: AppRouteEnum.detailCourse.name,
                  //       builder:
                  //           (context, state) =>
                  //               Container(), //TODO change page (detailCourse)!
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),
          //post index = 1
          // StatefulShellBranch(
          //   navigatorKey: _shellNavigatorPost,
          //   routes: [
          //     GoRoute(
          //       parentNavigatorKey: _shellNavigatorPost,
          //       path: AppRouteEnum.post.path,
          //       name: AppRouteEnum.post.name,
          //       pageBuilder:
          //           (context, state) => NoTransitionPage(
          //             child: Container(),
          //           ), //TODO Change Page (post)!
          //       routes: [
          //         GoRoute(
          //           parentNavigatorKey: _rootNavigatorKey,
          //           path: AppRouteEnum.newPost.path,
          //           name: AppRouteEnum.newPost.name,
          //           builder:
          //               (context, state) =>
          //                   Container(), //TODO change page (new post)!
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          //profile index = 2
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfile,
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorProfile,
                path: AppRouteEnum.profile.path,
                name: AppRouteEnum.profile.name,
                builder: (context, state) => ProfilePage(),
                //TODO Change Page (profile)!
                routes: [
                  // GoRoute(
                  //   parentNavigatorKey: _rootNavigatorKey,
                  //   path: AppRouteEnum.about.path,
                  //   name: AppRouteEnum.about.name,
                  //   builder:
                  //       (context, state) =>
                  //           Container(), //TODO Change Page (about)!
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
