import 'package:survey_app/core/app/app_exports.dart';

class ResponsesBloc extends Bloc<ResponsesEvent, ResponsesState> {
  final CreateResponseUsecase createResponseUsecase;
  final CreateMultipleResponsesUsecase createMultipleResponsesUsecase;
  final CreateMultipleResponsesWithAssesmentUsecase
  createMultipleResponsesWithPenilaianUsecase;
  final GetResponsesByUserUsecase getResponsesByUserUsecase;
  final GetResponsesBySurveyUsecase getResponsesBySurveyUsecase;

  ResponsesBloc({
    required this.createResponseUsecase,
    required this.createMultipleResponsesUsecase,
    required this.createMultipleResponsesWithPenilaianUsecase,
    required this.getResponsesByUserUsecase,
    required this.getResponsesBySurveyUsecase,
  }) : super(ResponsesInitial()) {
    on<CreateResponseEvent>((event, emit) async {
      emit(ResponsesLoading());
      try {
        final result = await createResponseUsecase(event.response);

        result.fold((failure) {
          if (failure.message.contains('created successfully')) {
            emit(ResponseCreatedSuccess(event.response));
          } else {
            emit(ResponsesError(failure.message));
          }
        }, (response) => emit(ResponseCreatedSuccess(response)));
      } catch (e) {
        if (e.toString().contains('created successfully')) {
          emit(ResponseCreatedSuccess(event.response));
        } else {
          emit(ResponsesError(e.toString()));
        }
      }
    });

    on<CreateMultipleResponsesEvent>((event, emit) async {
      emit(ResponsesLoading());
      try {
        final result = await createMultipleResponsesUsecase(event.responses);

        result.fold((failure) {
          if (failure.message.contains('created successfully')) {
            emit(MultipleResponsesCreatedSuccess(event.responses));
          } else {
            emit(ResponsesError(failure.message));
          }
        }, (responses) => emit(MultipleResponsesCreatedSuccess(responses)));
      } catch (e) {
        if (e.toString().contains('created successfully')) {
          emit(MultipleResponsesCreatedSuccess(event.responses));
        } else {
          emit(ResponsesError(e.toString()));
        }
      }
    });

    on<CreateMultipleResponsesWithAssesmentEvent>((event, emit) async {
      emit(ResponsesLoading());
      try {
        final result = await createMultipleResponsesWithPenilaianUsecase(
          responses: event.responses,
          mahasiswaId: event.mahasiswaId,
          mkId: event.mkId,
          dosenId: event.dosenId,
          surveyId: event.surveyId,
        );

        result.fold(
          (failure) {
            if (failure.message.contains('created successfully')) {
              emit(
                MultipleResponsesWithAssesmentCreatedSuccess(event.responses),
              );
            } else {
              emit(ResponsesError(failure.message));
            }
          },
          (responses) =>
              emit(MultipleResponsesWithAssesmentCreatedSuccess(responses)),
        );
      } catch (e) {
        if (e.toString().contains('created successfully')) {
          emit(MultipleResponsesWithAssesmentCreatedSuccess(event.responses));
        } else {
          emit(ResponsesError(e.toString()));
        }
      }
    });

    on<GetResponsesByUserEvent>((event, emit) async {
      emit(ResponsesLoading());
      final result = await getResponsesByUserUsecase(event.userId);

      result.fold(
        (failure) => emit(ResponsesError(failure.message)),
        (responses) => emit(ResponsesLoadedByUser(responses)),
      );
    });

    on<GetResponsesBySurveyEvent>((event, emit) async {
      emit(ResponsesLoading());
      final result = await getResponsesBySurveyUsecase(event.surveyId);

      result.fold(
        (failure) => emit(ResponsesError(failure.message)),
        (responses) => emit(ResponsesLoadedBySurvey(responses)),
      );
    });
  }
}
