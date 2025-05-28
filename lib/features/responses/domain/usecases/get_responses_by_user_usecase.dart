import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/responses/domain/entities/response_entity.dart';
import 'package:survey_app/features/responses/domain/repositories/response_repository.dart';

class GetResponsesByUserUsecase {
  final ResponseRepository repository;

  GetResponsesByUserUsecase(this.repository);

  Future<Either<Failure, List<ResponseEntity>>> call(int userId) async {
    return await repository.getResponsesByUser(userId);
  }
}
