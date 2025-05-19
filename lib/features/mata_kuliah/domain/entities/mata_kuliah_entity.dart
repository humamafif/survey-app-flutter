import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';

class MataKuliahEntity extends Equatable {
  final int id;
  final String namaMk;
  final int dosenId;
  final DosenEntity? dosen;

  const MataKuliahEntity({
    required this.id,
    required this.namaMk,
    required this.dosenId,
    this.dosen,
  });

  @override
  List<Object?> get props => [id, namaMk, dosenId, dosen];
}
