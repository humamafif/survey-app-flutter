import 'package:survey_app/core/app/app_exports.dart';

class DosenEntity extends Equatable {
  final int id;
  final String name;

  const DosenEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];
}
