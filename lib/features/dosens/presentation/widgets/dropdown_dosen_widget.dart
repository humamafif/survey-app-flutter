import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/presentation/bloc/dosens_bloc.dart';
import 'package:survey_app/shared/utils/shared_preferences_utils.dart';

class DropdownDosenWidget extends StatefulWidget {
  const DropdownDosenWidget({super.key});

  @override
  State<DropdownDosenWidget> createState() => _DropdownDosenWidgetState();
}

class _DropdownDosenWidgetState extends State<DropdownDosenWidget> {
  DosenEntity? _selectedDosen;

  Future<void> loadSelectedDosenFromPrefs(List<DosenEntity> dosens) async {
    final selected = await loadSelectedDosen(dosens);
    if (mounted) {
      setState(() {
        _selectedDosen = selected?.id == -1 ? null : selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DosensBloc, DosensState>(
      listenWhen:
          (previous, current) =>
              current is DosensLoadedGetAllState && previous != current,
      listener: (context, state) {
        if (state is DosensLoadedGetAllState) {
          loadSelectedDosenFromPrefs(state.dosens.cast<DosenEntity>());
        }
      },
      child: BlocBuilder<DosensBloc, DosensState>(
        builder: (context, state) {
          if (state is DosensLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DosensErrorState) {
            return Center(child: Text(state.message));
          } else if (state is DosensLoadedGetAllState) {
            final dosens = state.dosens;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButton<DosenEntity>(
                      hint: const Text('Pilih Dosen'),
                      value: _selectedDosen,
                      isExpanded: true,
                      menuMaxHeight: 0.5.sh,
                      items:
                          dosens.map((dosen) {
                            return DropdownMenuItem<DosenEntity>(
                              value: dosen,
                              child: Text(dosen.name),
                            );
                          }).toList(),
                      onChanged: (newDosen) {
                        if (newDosen != null) {
                          setState(() {
                            _selectedDosen = newDosen;
                          });
                          saveSelectedDosen(newDosen);
                        }
                      },
                    ),
                    if (_selectedDosen != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text('Dosen Terpilih: ${_selectedDosen!.name}'),
                      ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Tidak ada data dosen.'));
          }
        },
      ),
    );
  }
}
