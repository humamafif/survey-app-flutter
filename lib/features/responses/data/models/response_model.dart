import 'package:survey_app/features/responses/domain/entities/response_entity.dart';

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    super.id,
    required super.userId,
    required super.surveyId,
    required super.questionId,
    required super.nilai,
    super.kritikSaran,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      id: json['id'],
      userId: int.parse(json['user_id'].toString()),
      surveyId: int.parse(json['survey_id'].toString()),
      questionId: int.parse(json['question_id'].toString()),
      nilai: int.parse(json['nilai'].toString()),
      kritikSaran: json['kritik_saran'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'user_id': userId,
      'survey_id': surveyId,
      'question_id': questionId,
      'nilai': nilai,
    };

    // Penting: hanya sertakan kritik_saran jika ada nilainya
    if (kritikSaran != null && kritikSaran!.isNotEmpty) {
      data['kritik_saran'] = kritikSaran;
      print("📝 Menambahkan kritik_saran ke JSON: $kritikSaran");
    }
    return data;
  }

  static List<ResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ResponseModel.fromJson(json)).toList();
  }
}
