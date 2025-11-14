import 'package:survey_app/core/app/app_exports.dart';

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
