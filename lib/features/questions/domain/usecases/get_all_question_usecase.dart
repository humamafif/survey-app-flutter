import 'package:survey_app/core/app/app_exports.dart';

class GetAllQuestionsUsecase {
  final QuestionRepository repository;

  GetAllQuestionsUsecase(this.repository);

  Future<Either<Failure, List<QuestionEntity>>> call() async {
    return await repository.getAllQuestions();
  }
}
