import 'package:survey_app/core/app/app_exports.dart';

class QuestionModel extends QuestionEntity {
  const QuestionModel({
    required super.id,
    required super.surveyId,
    required super.question,
    required super.type,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      surveyId: json['survey_id'],
      question: json['pertanyaan'],
      type: json['tipe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'survey_id': surveyId,
      'pertanyaan': question,
      'tipe': type,
    };
  }

  static List<QuestionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => QuestionModel.fromJson(json)).toList();
  }
}
