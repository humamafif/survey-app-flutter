import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/responses/domain/entities/response_entity.dart';

abstract class ResponseRepository {
  Future<Either<Failure, ResponseEntity>> createResponse(
    ResponseEntity response,
  );
  Future<Either<Failure, List<ResponseEntity>>> createMultipleResponses(
    List<ResponseEntity> responses,
  );
  Future<Either<Failure, List<ResponseEntity>>> getResponsesByUser(int userId);
  Future<Either<Failure, List<ResponseEntity>>> getResponsesBySurvey(
    int surveyId,
  );
  Future<Either<Failure, Map<String, dynamic>>> createPenilaianDosen({
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  });
  Future<Either<Failure, List<ResponseEntity>>>
  createMultipleResponsesWithAssesment({
    required List<ResponseEntity> responses,
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  });
}
