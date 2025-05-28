import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/responses/domain/entities/response_entity.dart';
import 'package:survey_app/features/responses/domain/repositories/response_repository.dart';

class CreateMultipleResponsesWithAssesmentUsecase {
  final ResponseRepository repository;

  CreateMultipleResponsesWithAssesmentUsecase(this.repository);

  Future<Either<Failure, List<ResponseEntity>>> call({
    required List<ResponseEntity> responses,
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  }) async {
    return await repository.createMultipleResponsesWithAssesment(
      responses: responses,
      mahasiswaId: mahasiswaId,
      mkId: mkId,
      dosenId: dosenId,
      surveyId: surveyId,
    );
  }
}
