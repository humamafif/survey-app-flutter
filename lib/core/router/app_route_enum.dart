enum AppRouteEnum {
  home,
  profile,
  login,
  register,
  surveyForm,
  selectMataKuliahDosen,
  questionPage,
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch (this) {
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
      case AppRouteEnum.selectMataKuliahDosen:
        return "/select-mata-kuliah-dosen";
      case AppRouteEnum.questionPage:
        return "/questions";
    }
  }

  String get path {
    switch (this) {
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
      case AppRouteEnum.selectMataKuliahDosen:
        return '/select-mata-kuliah-dosen';
      case AppRouteEnum.questionPage:
        return '/questions';
    }
  }
}
