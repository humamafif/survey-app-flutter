import 'package:survey_app/core/app/app_exports.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final GetAllQuestionsUsecase getAllQuestionsUsecase;
  final GetQuestionsBySurveyIdUsecase getQuestionsBySurveyIdUsecase;

  QuestionsBloc({
    required this.getAllQuestionsUsecase,
    required this.getQuestionsBySurveyIdUsecase,
  }) : super(QuestionInitial()) {
    on<GetAllQuestionsEvent>((event, emit) async {
      emit(QuestionLoadingState());
      final result = await getAllQuestionsUsecase();

      result.fold(
        (failure) => emit(QuestionErrorState(failure.message)),
        (questions) => emit(QuestionLoadedAllState(questions)),
      );
    });

    on<GetQuestionsBySurveyIdEvent>((event, emit) async {
      emit(QuestionLoadingState());
      final result = await getQuestionsBySurveyIdUsecase(event.surveyId);

      result.fold(
        (failure) => emit(QuestionErrorState(failure.message)),
        (questions) => emit(QuestionLoadedBySurveyIdState(questions)),
      );
    });
  }
}
