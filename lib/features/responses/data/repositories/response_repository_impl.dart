import 'package:dartz/dartz.dart';
import 'package:survey_app/core/error/failure.dart';
import 'package:survey_app/features/responses/data/datasources/response_remote_data_source.dart';
import 'package:survey_app/features/responses/data/models/response_model.dart';
import 'package:survey_app/features/responses/domain/entities/response_entity.dart';
import 'package:survey_app/features/responses/domain/repositories/response_repository.dart';

class ResponseRepositoryImpl implements ResponseRepository {
  final ResponseRemoteDataSource remoteDataSource;

  ResponseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ResponseEntity>> createResponse(
    ResponseEntity response,
  ) async {
    try {
      final result = await remoteDataSource.createResponse(
        ResponseModel(
          userId: response.userId,
          surveyId: response.surveyId,
          questionId: response.questionId,
          nilai: response.nilai,
          kritikSaran: response.kritikSaran,
        ),
      );
      return Right(result);
    } catch (e) {
      if (e.toString().contains('created successfully')) {
        return Right(response);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResponseEntity>>> createMultipleResponses(
    List<ResponseEntity> responses,
  ) async {
    try {
      final result = await remoteDataSource.createMultipleResponses(
        responses
            .map(
              (r) => ResponseModel(
                userId: r.userId,
                surveyId: r.surveyId,
                questionId: r.questionId,
                nilai: r.nilai,
                kritikSaran: r.kritikSaran,
              ),
            )
            .toList(),
      );
      return Right(result);
    } catch (e) {
      if (e.toString().contains('created successfully')) {
        return Right(responses);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> createPenilaianDosen({
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  }) async {
    try {
      final result = await remoteDataSource.createPenilaianDosen(
        mahasiswaId: mahasiswaId,
        mkId: mkId,
        dosenId: dosenId,
        surveyId: surveyId,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResponseEntity>>>
  createMultipleResponsesWithAssesment({
    required List<ResponseEntity> responses,
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  }) async {
    try {
      final result = await remoteDataSource
          .createMultipleResponsesWithPenilaian(
            responses:
                responses
                    .map(
                      (r) => ResponseModel(
                        userId: r.userId,
                        surveyId: r.surveyId,
                        questionId: r.questionId,
                        nilai: r.nilai,
                        kritikSaran: r.kritikSaran,
                      ),
                    )
                    .toList(),
            mahasiswaId: mahasiswaId,
            mkId: mkId,
            dosenId: dosenId,
            surveyId: surveyId,
          );
      return Right(result);
    } catch (e) {
      if (e.toString().contains('created successfully')) {
        return Right(responses);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResponseEntity>>> getResponsesByUser(
    int userId,
  ) async {
    try {
      final result = await remoteDataSource.getResponsesByUser(userId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResponseEntity>>> getResponsesBySurvey(
    int surveyId,
  ) async {
    try {
      final result = await remoteDataSource.getResponsesBySurvey(surveyId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
