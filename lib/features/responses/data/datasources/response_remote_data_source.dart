import 'package:survey_app/core/app/app_exports.dart';

abstract class ResponseRemoteDataSource {
  Future<ResponseModel> createResponse(ResponseModel response);
  Future<List<ResponseModel>> createMultipleResponses(
    List<ResponseModel> responses,
  );
  Future<List<ResponseModel>> getResponsesByUser(int userId);
  Future<List<ResponseModel>> getResponsesBySurvey(int surveyId);
  Future<Map<String, dynamic>> createPenilaianDosen({
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  });
  Future<List<ResponseModel>> createMultipleResponsesWithPenilaian({
    required List<ResponseModel> responses,
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  });
}

class ResponseRemoteDataSourceImpl implements ResponseRemoteDataSource {
  final Dio dio;

  ResponseRemoteDataSourceImpl({required this.dio});

  @override
  Future<ResponseModel> createResponse(ResponseModel response) async {
    try {
      print("Mengirim response: ${response.toJson()}");
      final result = await dio.post(
        '${dotenv.env['BASE_URL']}/responses',
        data: response.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("API response status: ${result.statusCode}");
      print("API response: ${result.data}");

      if (result.statusCode == 201 || result.statusCode == 200) {
        if (result.data['data'] != null) {
          return ResponseModel.fromJson(result.data['data']);
        }
        return response;
      } else {
        String message = result.data['message'] ?? "Failed to create response";
        throw Exception(message);
      }
    } catch (e) {
      print("Error di createResponse: $e");
      if (e.toString().contains('created successfully')) {
        print("✅ Response sukses terdeteksi di error message");
        return response;
      }
      throw Exception("Error creating response: $e");
    }
  }

  @override
  Future<List<ResponseModel>> createMultipleResponses(
    List<ResponseModel> responses,
  ) async {
    try {
      print("Mengirim ${responses.length} responses ke endpoint multi-insert");
      final List<Map<String, dynamic>> responseItems =
          responses.map((response) {
            final Map<String, dynamic> item = {
              'user_id': response.userId,
              'survey_id': response.surveyId,
              'question_id': response.questionId,
            };
            if (response.kritikSaran == null || response.kritikSaran!.isEmpty) {
              item['nilai'] = response.nilai!;
            } else {
              item['kritik_saran'] = response.kritikSaran;
            }

            return item;
          }).toList();

      final requestData = {"responses": responseItems};

      print("Request data: $requestData");

      final result = await dio.post(
        '${dotenv.env['BASE_URL']}/responses/multi-insert',
        data: requestData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("API response status: ${result.statusCode}");
      print("API response: ${result.data}");

      if (result.statusCode == 201 || result.statusCode == 200) {
        return responses;
      } else {
        String message =
            result.data['message'] ?? "Failed to create multiple responses";
        throw Exception(message);
      }
    } catch (e) {
      print("Error di createMultipleResponses: $e");
      if (e.toString().contains('created successfully')) {
        return responses;
      }
      throw Exception("Error creating multiple responses: $e");
    }
  }

  @override
  Future<Map<String, dynamic>> createPenilaianDosen({
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  }) async {
    try {
      final data = {
        'mahasiswa_id': mahasiswaId,
        'mk_id': mkId,
        'dosen_id': dosenId,
        'survey_id': surveyId,
      };

      print("Mengirim penilaian dosen: $data");

      final result = await dio.post(
        '${dotenv.env['BASE_URL']}/penilaian-dosen',
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      print("Penilaian dosen response status: ${result.statusCode}");
      print("Penilaian dosen response: ${result.data}");

      if (result.statusCode == 201 || result.statusCode == 200) {
        return result.data;
      } else {
        String message =
            result.data['message'] ?? "Failed to create penilaian dosen";
        throw Exception(message);
      }
    } catch (e) {
      print("Error di createPenilaianDosen: $e");
      throw Exception("Error creating penilaian dosen: $e");
    }
  }

  @override
  Future<List<ResponseModel>> createMultipleResponsesWithPenilaian({
    required List<ResponseModel> responses,
    required int mahasiswaId,
    required int mkId,
    required int dosenId,
    required int surveyId,
  }) async {
    final multiResponseResult = await createMultipleResponses(responses);
    try {
      await createPenilaianDosen(
        mahasiswaId: mahasiswaId,
        mkId: mkId,
        dosenId: dosenId,
        surveyId: surveyId,
      );
      print("Penilaian dosen berhasil dikirim setelah multi-insert");
    } catch (e) {
      print("Warning: Penilaian dosen gagal dikirim: $e");
    }
    return multiResponseResult;
  }

  @override
  Future<List<ResponseModel>> getResponsesByUser(int userId) async {
    try {
      final result = await dio.get(
        '${dotenv.env['BASE_URL']}/responses',
        queryParameters: {'user_id': userId},
      );

      if (result.statusCode == 200) {
        final List<dynamic> data = result.data['data'];
        return data.map((json) => ResponseModel.fromJson(json)).toList();
      } else {
        String message = result.data['message'] ?? "Failed to load responses";
        throw Exception(message);
      }
    } catch (e) {
      throw Exception("Error getting responses by user: $e");
    }
  }

  @override
  Future<List<ResponseModel>> getResponsesBySurvey(int surveyId) async {
    try {
      final result = await dio.get(
        '${dotenv.env['BASE_URL']}/responses',
        queryParameters: {'survey_id': surveyId},
      );

      if (result.statusCode == 200) {
        final List<dynamic> data = result.data['data'];
        return data.map((json) => ResponseModel.fromJson(json)).toList();
      } else {
        String message = result.data['message'] ?? "Failed to load responses";
        throw Exception(message);
      }
    } catch (e) {
      throw Exception("Error getting responses by survey: $e");
    }
  }
}
