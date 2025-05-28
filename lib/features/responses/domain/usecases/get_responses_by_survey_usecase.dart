import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/responses/domain/entities/response_entity.dart';
import 'package:survey_app/features/responses/domain/repositories/response_repository.dart';

class GetResponsesBySurveyUsecase {
  final ResponseRepository repository;

  GetResponsesBySurveyUsecase(this.repository);

  Future<Either<Failure, List<ResponseEntity>>> call(int surveyId) async {
    return await repository.getResponsesBySurvey(surveyId);
  }
}
