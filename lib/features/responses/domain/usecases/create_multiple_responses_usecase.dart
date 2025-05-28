import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/responses/domain/entities/response_entity.dart';
import 'package:survey_app/features/responses/domain/repositories/response_repository.dart';

class CreateMultipleResponsesUsecase {
  final ResponseRepository repository;

  CreateMultipleResponsesUsecase(this.repository);

  Future<Either<Failure, List<ResponseEntity>>> call(
    List<ResponseEntity> responses,
  ) async {
    return await repository.createMultipleResponses(responses);
  }
}
