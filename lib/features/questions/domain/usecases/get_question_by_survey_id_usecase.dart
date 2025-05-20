import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/questions/domain/entities/question_entity.dart';
import 'package:survey_app/features/questions/domain/repositories/question_repository.dart';

class GetQuestionsBySurveyIdUsecase {
  final QuestionRepository repository;

  GetQuestionsBySurveyIdUsecase(this.repository);

  Future<Either<Failure, List<QuestionEntity>>> call(int surveyId) async {
    return await repository.getQuestionsBySurveyId(surveyId);
  }
}
