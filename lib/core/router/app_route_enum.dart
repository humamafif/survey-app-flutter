enum AppRouteEnum { splashScreen, home, profile, login, register, surveyForm }

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
      case AppRouteEnum.splashScreen:
        return '/';
      case AppRouteEnum.home:
        return '/home';
      case AppRouteEnum.profile:
        return '/profile';
      case AppRouteEnum.login:
        return '/login';
      case AppRouteEnum.register:
        return "/register";
      case AppRouteEnum.surveyForm:
        return "/survey-form";
    }
  }

  String get path {
    switch (this) {
      case AppRouteEnum.splashScreen:
        return '/splash-screen';
      case AppRouteEnum.home:
        return '/home';
      case AppRouteEnum.profile:
        return '/profile';
      case AppRouteEnum.login:
        return '/login';
      case AppRouteEnum.register:
        return '/register';
      case AppRouteEnum.surveyForm:
        return '/survey-form';
    }
  }
}
