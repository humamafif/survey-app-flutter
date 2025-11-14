import 'package:survey_app/core/app/app_exports.dart';

class MataKuliahEntity extends Equatable {
  final int id;
  final String namaMk;
  final int? sks;
  final List<DosenEntity>? dosens;

  const MataKuliahEntity({
    required this.id,
    required this.namaMk,
    this.sks,
    this.dosens,
  });

  @override
  List<Object?> get props => [id, namaMk, sks, dosens];
}
