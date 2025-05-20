import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey_app/features/questions/domain/entities/question_entity.dart';
import 'package:survey_app/features/questions/domain/usecases/get_all_question_usecase.dart';
import 'package:survey_app/features/questions/domain/usecases/get_question_by_survey_id_usecase.dart';

part 'questions_event.dart';
part 'questions_state.dart';

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
