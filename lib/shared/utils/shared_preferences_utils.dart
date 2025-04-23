import 'package:shared_preferences/shared_preferences.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';

Future<void> saveSelectedDosen(DosenEntity selectedDosen) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('selected_dosen_id', selectedDosen.id);
}

Future<DosenEntity?> loadSelectedDosen(List<DosenEntity> dosens) async {
  final prefs = await SharedPreferences.getInstance();
  final selectedId = prefs.getInt('selected_dosen_id');
  if (selectedId != null) {
    return dosens.firstWhere(
      (dosen) => dosen.id == selectedId,
      orElse: () => DosenEntity(id: -1, name: 'Tidak Ditemukan'),
    );
  }
  return null;
}
