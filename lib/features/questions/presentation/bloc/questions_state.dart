part of 'questions_bloc.dart';

abstract class QuestionsState extends Equatable {
  const QuestionsState();

  @override
  List<Object?> get props => [];
}

class QuestionInitial extends QuestionsState {}

class QuestionLoadingState extends QuestionsState {}

class QuestionErrorState extends QuestionsState {
  final String message;

  const QuestionErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class QuestionLoadedAllState extends QuestionsState {
  final List<QuestionEntity> questions;

  const QuestionLoadedAllState(this.questions);

  @override
  List<Object?> get props => [questions];
}

class QuestionLoadedByIdState extends QuestionsState {
  final QuestionEntity question;

  const QuestionLoadedByIdState(this.question);

  @override
  List<Object?> get props => [question];
}

class QuestionLoadedBySurveyIdState extends QuestionsState {
  final List<QuestionEntity> questions;

  const QuestionLoadedBySurveyIdState(this.questions);

  @override
  List<Object?> get props => [questions];
}
