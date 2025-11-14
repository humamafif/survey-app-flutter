import 'package:survey_app/core/app/app_exports.dart';

abstract class QuestionRepository {
  Future<Either<Failure, List<QuestionEntity>>> getQuestionsBySurveyId(
    int surveyId,
  );
  Future<Either<Failure, List<QuestionEntity>>> getAllQuestions();
}
