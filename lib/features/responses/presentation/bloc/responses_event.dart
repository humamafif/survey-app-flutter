import 'package:survey_app/core/app/app_exports.dart';

abstract class ResponsesEvent extends Equatable {
  const ResponsesEvent();

  @override
  List<Object?> get props => [];
}

class CreateResponseEvent extends ResponsesEvent {
  final ResponseEntity response;

  const CreateResponseEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateMultipleResponsesEvent extends ResponsesEvent {
  final List<ResponseEntity> responses;

  const CreateMultipleResponsesEvent(this.responses);

  @override
  List<Object?> get props => [responses];
}

// Dihapus atau dipertahankan untuk backward compatibility
class CreateBulkResponsesEvent extends ResponsesEvent {
  final List<ResponseEntity> responses;

  const CreateBulkResponsesEvent(this.responses);

  @override
  List<Object?> get props => [responses];
}

class GetResponsesByUserEvent extends ResponsesEvent {
  final int userId;

  const GetResponsesByUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class GetResponsesBySurveyEvent extends ResponsesEvent {
  final int surveyId;

  const GetResponsesBySurveyEvent(this.surveyId);

  @override
  List<Object?> get props => [surveyId];
}

// Tambahkan ini di responses_event.dart
class CreateMultipleResponsesWithAssesmentEvent extends ResponsesEvent {
  final List<ResponseEntity> responses;
  final int mahasiswaId;
  final int mkId;
  final int dosenId;
  final int surveyId;

  const CreateMultipleResponsesWithAssesmentEvent({
    required this.responses,
    required this.mahasiswaId,
    required this.mkId,
    required this.dosenId,
    required this.surveyId,
  });

  @override
  List<Object> get props => [responses, mahasiswaId, mkId, dosenId, surveyId];
}
