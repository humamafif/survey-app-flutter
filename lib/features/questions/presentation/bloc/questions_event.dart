part of 'questions_bloc.dart';

abstract class QuestionsEvent extends Equatable {
  const QuestionsEvent();

  @override
  List<Object?> get props => [];
}

class GetAllQuestionsEvent extends QuestionsEvent {}

class GetQuestionsBySurveyIdEvent extends QuestionsEvent {
  final int surveyId;

  const GetQuestionsBySurveyIdEvent(this.surveyId);

  @override
  List<Object?> get props => [surveyId];
}
