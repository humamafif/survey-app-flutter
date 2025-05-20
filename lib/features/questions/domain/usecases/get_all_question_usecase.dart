import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/questions/domain/entities/question_entity.dart';
import 'package:survey_app/features/questions/domain/repositories/question_repository.dart';

class GetAllQuestionsUsecase {
  final QuestionRepository repository;

  GetAllQuestionsUsecase(this.repository);

  Future<Either<Failure, List<QuestionEntity>>> call() async {
    return await repository.getAllQuestions();
  }
}
