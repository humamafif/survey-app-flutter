import 'package:survey_app/core/app/app_exports.dart';

class QuestionRepositoryImpl implements QuestionRepository {
  final QuestionRemoteDataSource remoteDataSource;

  QuestionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<QuestionEntity>>> getQuestionsBySurveyId(
    int surveyId,
  ) async {
    try {
      final result = await remoteDataSource.getQuestionsBySurveyId(surveyId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<QuestionEntity>>> getAllQuestions() async {
    try {
      final result = await remoteDataSource.getAllQuestions();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
