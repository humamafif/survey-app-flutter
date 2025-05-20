import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/questions/domain/entities/question_entity.dart';

abstract class QuestionRepository {
  Future<Either<Failure, List<QuestionEntity>>> getQuestionsBySurveyId(
    int surveyId,
  );
  Future<Either<Failure, List<QuestionEntity>>> getAllQuestions();
}
