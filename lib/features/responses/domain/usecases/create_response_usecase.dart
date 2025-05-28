import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/responses/domain/entities/response_entity.dart';

import 'package:survey_app/features/responses/domain/repositories/response_repository.dart';

class CreateResponseUsecase {
  final ResponseRepository repository;

  CreateResponseUsecase(this.repository);

  Future<Either<Failure, ResponseEntity>> call(ResponseEntity response) async {
    return await repository.createResponse(response);
  }
}
