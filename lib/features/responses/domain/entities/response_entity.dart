import 'package:equatable/equatable.dart';

class ResponseEntity extends Equatable {
  final int? id;
  final int userId;
  final int surveyId;
  final int questionId;
  final int? nilai;
  final String? kritikSaran;

  const ResponseEntity({
    this.id,
    required this.userId,
    required this.surveyId,
    required this.questionId,
    this.nilai,
    this.kritikSaran,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    surveyId,
    questionId,
    nilai,
    kritikSaran,
  ];
}
