import 'package:equatable/equatable.dart';

class QuestionEntity extends Equatable {
  final int id;
  final int surveyId;
  final String question;
  final String type;

  const QuestionEntity({
    required this.id,
    required this.surveyId,
    required this.question,
    required this.type,
  });

  @override
  List<Object?> get props => [id, surveyId, question, type];
}
