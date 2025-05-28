part of 'responses_bloc.dart';

abstract class ResponsesState extends Equatable {
  const ResponsesState();

  @override
  List<Object?> get props => [];
}

class ResponsesInitial extends ResponsesState {}

class ResponsesLoading extends ResponsesState {}

class ResponseCreatedSuccess extends ResponsesState {
  final ResponseEntity response;

  const ResponseCreatedSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class MultipleResponsesCreatedSuccess extends ResponsesState {
  final List<ResponseEntity> responses;

  const MultipleResponsesCreatedSuccess(this.responses);

  @override
  List<Object?> get props => [responses];
}

// Dihapus atau dipertahankan untuk backward compatibility
class BulkResponsesCreatedSuccess extends ResponsesState {
  final List<ResponseEntity> responses;

  const BulkResponsesCreatedSuccess(this.responses);

  @override
  List<Object?> get props => [responses];
}

class ResponsesLoadedByUser extends ResponsesState {
  final List<ResponseEntity> responses;

  const ResponsesLoadedByUser(this.responses);

  @override
  List<Object?> get props => [responses];
}

class ResponsesLoadedBySurvey extends ResponsesState {
  final List<ResponseEntity> responses;

  const ResponsesLoadedBySurvey(this.responses);

  @override
  List<Object?> get props => [responses];
}

class ResponsesError extends ResponsesState {
  final String message;

  const ResponsesError(this.message);

  @override
  List<Object?> get props => [message];
}

class MultipleResponsesWithAssesmentCreatedSuccess extends ResponsesState {
  final List<ResponseEntity> responses;

  const MultipleResponsesWithAssesmentCreatedSuccess(this.responses);

  @override
  List<Object> get props => [responses];
}
