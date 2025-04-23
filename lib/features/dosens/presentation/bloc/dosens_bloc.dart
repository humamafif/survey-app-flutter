import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey_app/features/dosens/domain/entities/dosen_entity.dart';
import 'package:survey_app/features/dosens/domain/usecases/get_all_dosen_usecase.dart';

part 'dosens_event.dart';
part 'dosens_state.dart';

class DosensBloc extends Bloc<DosensEvent, DosensState> {
  final GetAllDosenUsecase getAllDosenUsecase;
  // final GetDosenByIdUsecase getDosenByIdUsecase;
  // final GetDosenBynameUsecase getDosenBynameUsecase;
  // final DosenRemoteDatasource dosenRemoteDatasource;

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
