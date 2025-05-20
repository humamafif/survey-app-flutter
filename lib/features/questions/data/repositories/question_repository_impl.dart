import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/questions/data/datasources/question_remote_datasource.dart';
import 'package:survey_app/features/questions/domain/entities/question_entity.dart';
import 'package:survey_app/features/questions/domain/repositories/question_repository.dart';

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
