import 'package:survey_app/core/app/app_exports.dart';

abstract class MataKuliahRemoteDataSource {
  Future<List<MataKuliahModel>> getAllMataKuliah();
  Future<MataKuliahModel> getMataKuliahById(String id);
  Future<List<MataKuliahModel>> getMataKuliahByDosenId(String dosenId);
}

class MataKuliahRemoteDataSourceImpl implements MataKuliahRemoteDataSource {
  final Dio dio;

  MataKuliahRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<MataKuliahModel>> getAllMataKuliah() async {
    try {
      final response = await dio.get('${dotenv.env['BASE_URL']}/mata-kuliahs');

      if (response.statusCode == 200) {
        List<dynamic> dataBody = response.data['data'];
        return MataKuliahModel.fromJsonList(dataBody);
      } else {
        String message =
            response.data['message'] ?? "Gagal memuat data mata kuliah";
        throw Exception(message);
      }
    } catch (e) {
      throw Exception("⚠️Gagal memuat data mata kuliah: $e");
    }
  }

  @override
  Future<MataKuliahModel> getMataKuliahById(String id) async {
    try {
      final response = await dio.get(
        '${dotenv.env['BASE_URL']}/mata-kuliahs/$id',
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data['data'];
        return MataKuliahModel.fromJson(data);
      } else {
        String errorMessage =
            response.data['message'] ?? 'Gagal memuat mata kuliah';
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('⚠️Error saat mengambil mata kuliah: $e');
    }
  }

  @override
  Future<List<MataKuliahModel>> getMataKuliahByDosenId(String dosenId) async {
    try {
      final response = await dio.get(
        '${dotenv.env['BASE_URL']}/mata-kuliahs',
        queryParameters: {'dosen_id': dosenId},
      );

      if (response.statusCode == 200) {
        List<dynamic> dataBody = response.data['data'];
        return MataKuliahModel.fromJsonList(dataBody);
      } else {
        String message =
            response.data['message'] ?? "Gagal memuat data mata kuliah";
        throw Exception(message);
      }
    } catch (e) {
      throw Exception("⚠️Gagal memuat data mata kuliah berdasarkan dosen: $e");
    }
  }
}
