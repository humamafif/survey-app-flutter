import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:survey_app/features/questions/data/models/question_model.dart';

abstract class QuestionRemoteDataSource {
  Future<List<QuestionModel>> getQuestionsBySurveyId(int surveyId);
  Future<List<QuestionModel>> getAllQuestions();
}

class QuestionRemoteDataSourceImpl implements QuestionRemoteDataSource {
  final Dio dio;

  QuestionRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<QuestionModel>> getQuestionsBySurveyId(int surveyId) async {
    try {
      final response = await dio.get(
        '${dotenv.env['BASE_URL']}/survey-questions/2',
        queryParameters: {'survey_id': surveyId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return QuestionModel.fromJsonList(data);
      } else {
        String message = response.data['message'] ?? 'Failed to load questions';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Error getting questions by survey ID: $e');
    }
  }

  @override
  Future<List<QuestionModel>> getAllQuestions() async {
    try {
      final response = await dio.get(
        '${dotenv.env['BASE_URL']}/survey-questions/2',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return QuestionModel.fromJsonList(data);
      } else {
        String message = response.data['message'] ?? 'Failed to load questions';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Error getting all questions: $e');
    }
  }
}
