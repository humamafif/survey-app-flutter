import 'package:survey_app/features/dosens/data/models/dosen_model.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';

class MataKuliahModel extends MataKuliahEntity {
  const MataKuliahModel({
    required super.id,
    required super.namaMk,
    required super.dosenId,
    super.dosen,
  });

  factory MataKuliahModel.fromJson(Map<String, dynamic> json) {
    return MataKuliahModel(
      id: json['id'],
      namaMk: json['nama_mk'],
      dosenId: json['dosen_id'],
      dosen: json['dosen'] != null ? DosenModel.fromJson(json['dosen']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nama_mk': namaMk, 'dosen_id': dosenId};
  }

  static List<MataKuliahModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => MataKuliahModel.fromJson(json)).toList();
  }
}
