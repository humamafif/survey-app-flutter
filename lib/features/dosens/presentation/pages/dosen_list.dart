import 'package:survey_app/core/app/app_exports.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/presentation/bloc/dosens_bloc.dart';

class DosenList extends StatelessWidget {
  const DosenList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DosensBloc, DosensState>(
        builder: (context, state) {
          if (state is DosensLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is DosensErrorState) {
            return Center(child: Text(state.message));
          } else if (state is DosensLoadedGetAllState) {
            List<DosenEntity> dosen = state.dosens;
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                itemCount: dosen.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(dosen[index].name));
                },
              ),
            );
          } else {
            return Center(child: Text('Tidak ada data dosen.'));
          }
        },
      ),
    );
  }
}
