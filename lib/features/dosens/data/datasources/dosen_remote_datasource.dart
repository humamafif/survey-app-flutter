import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_app/features/dosens/data/models/dosen_model.dart';

abstract class DosenRemoteDatasource {
  Future<List<DosenModel>> getAllDosen();
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
}
