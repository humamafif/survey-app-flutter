import 'package:survey_app/core/app/app_exports.dart';

class DosenModel extends DosenEntity {
  const DosenModel({required super.id, required super.name});
  // MAP TO JSON
  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(id: json['id'], name: json['nama_dosen']);
  }

  // dosen model TO MAP
  Map<String, dynamic> toJson() {
    return {'id': id, 'nama_dosen': name};
  }

  // list map convert to list model
  static List<DosenModel> fromJsonList(List<dynamic> json) {
    if (json.isEmpty) return [];
    return json.map((data) => DosenModel.fromJson(data)).toList();
  }
}
