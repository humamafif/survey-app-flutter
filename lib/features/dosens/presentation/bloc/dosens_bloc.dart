import 'package:survey_app/core/app/app_exports.dart';

class DosensBloc extends Bloc<DosensEvent, DosensState> {
  final GetAllDosenUsecase getAllDosenUsecase;

  DosensBloc(this.getAllDosenUsecase) : super(DosensInitial()) {
    on<GetAllDosensEvent>((event, emit) async {
      emit(DosensLoadingState());
      final result = await getAllDosenUsecase();
      print(result);

      result.fold(
        (failure) => emit(DosensErrorState(failure.message)),
        (data) => emit(DosensLoadedGetAllState(data)),
      );
    });
    on<SelectedDosenEvent>((event, emit) {
      emit(DosensSelectedState(event.selectedDosen));
    });
  }
}
