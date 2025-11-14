import 'package:survey_app/core/app/app_exports.dart';

class GetQuestionsBySurveyIdUsecase {
  final QuestionRepository repository;

  GetQuestionsBySurveyIdUsecase(this.repository);

  Future<Either<Failure, List<QuestionEntity>>> call(int surveyId) async {
    return await repository.getQuestionsBySurveyId(surveyId);
  }
}
