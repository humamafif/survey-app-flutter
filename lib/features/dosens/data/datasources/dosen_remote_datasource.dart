import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_app/features/dosens/data/models/dosen_model.dart';

abstract class DosenRemoteDatasource {
  Future<List<DosenModel>> getAllDosen();
  Future<DosenModel> getDosenByid(int id);
  Future<DosenModel> getCarByName(String name);
}

class DosenRemoteDatasourceImpl extends DosenRemoteDatasource {
  final Dio dio;

  DosenRemoteDatasourceImpl({required this.dio});

  @override
  Future<List<DosenModel>> getAllDosen() async {
    try {
      final response = await dio.get('${dotenv.env['BASE_URL']}/dosens');
      if (response.statusCode == 200) {
        List<dynamic> dataBody = response.data['data'];
        return DosenModel.fromJsonList(dataBody);
      } else {
        String message = response.data['message'] ?? "Failed to load data";
        throw Exception(message);
      }
    } catch (e) {
      throw Exception("Failed to load data: $e");
    }
  }

  @override
  Future<DosenModel> getDosenByid(int id) async {
    try {
      final response = await dio.get('${dotenv.env['BASE_URL']}/dosens/$id');
      if (response.statusCode == 200) {
        return DosenModel.fromJson(response.data);
      } else {
        // Tangani jika server mengirimkan error message dalam respons
        String errorMessage =
            response.data['message'] ?? 'Failed to load dosen by id';
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Tangani error lain (misalnya network error)
      throw Exception('Error occurred: $e');
    }
  }

  @override
  Future<DosenModel> getCarByName(String name) async {
    try {
      final response = await dio.get(
        '${dotenv.env['BASE_URL']}/dosen',
        queryParameters: {'name': name},
      );
      if (response.statusCode == 200) {
        return DosenModel.fromJson(response.data);
      } else {
        // Tangani jika server mengirimkan error message dalam respons
        String errorMessage =
            response.data['message'] ?? 'Failed to load dosen by name';
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Tangani error lain (misalnya network error)
      throw Exception('Error occurred: $e');
    }
  }
}
