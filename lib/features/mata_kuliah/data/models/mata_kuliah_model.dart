import 'package:survey_app/features/dosens/data/models/dosen_model.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';

class MataKuliahModel extends MataKuliahEntity {
  const MataKuliahModel({
    required super.id,
    required super.namaMk,
    super.sks,
    super.dosens,
  });

  factory MataKuliahModel.fromJson(Map<String, dynamic> json) {
    List<DosenEntity>? dosensList;
    if (json['dosens'] != null) {
      dosensList =
          (json['dosens'] as List)
              .map((dosenJson) => DosenModel.fromJson(dosenJson))
              .toList();
    }
    return MataKuliahModel(
      id: json['id'],
      namaMk: json['nama_mk'],
      sks: json['sks'],
      dosens: dosensList,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nama_mk': namaMk, 'sks': sks};
  }

  static List<MataKuliahModel> fromJsonList(List<dynamic> jsonList) {
    if (jsonList.isEmpty) return [];
    return jsonList.map((json) => MataKuliahModel.fromJson(json)).toList();
  }
}
