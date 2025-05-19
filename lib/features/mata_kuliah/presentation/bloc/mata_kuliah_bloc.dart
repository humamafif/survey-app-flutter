import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:survey_app/features/mata_kuliah/domain/entities/mata_kuliah_entity.dart';
import 'package:survey_app/features/mata_kuliah/domain/usecases/get_all_mata_kuliah_usecase.dart';
import 'package:survey_app/features/mata_kuliah/domain/usecases/get_mata_kuliah_by_dosen_id_usecase.dart';
import 'package:survey_app/features/mata_kuliah/domain/usecases/get_mata_kuliah_by_id_usecase.dart';

part 'mata_kuliah_event.dart';
part 'mata_kuliah_state.dart';

class MataKuliahBloc extends Bloc<MataKuliahEvent, MataKuliahState> {
  final GetAllMataKuliahUsecase getAllMataKuliahUsecase;
  final GetMataKuliahByIdUsecase getMataKuliahByIdUsecase;
  final GetMataKuliahByDosenIdUsecase getMataKuliahByDosenIdUsecase;

  MataKuliahBloc({
    required this.getAllMataKuliahUsecase,
    required this.getMataKuliahByIdUsecase,
    required this.getMataKuliahByDosenIdUsecase,
  }) : super(MataKuliahInitial()) {
    on<GetAllMataKuliahEvent>((event, emit) async {
      emit(MataKuliahLoadingState());
      final result = await getAllMataKuliahUsecase();

      result.fold(
        (failure) => emit(MataKuliahErrorState(failure.message)),
        (data) => emit(MataKuliahLoadedAllState(data)),
      );
    });

    on<GetMataKuliahByIdEvent>((event, emit) async {
      emit(MataKuliahLoadingState());
      final result = await getMataKuliahByIdUsecase(event.id);

      result.fold(
        (failure) => emit(MataKuliahErrorState(failure.message)),
        (data) => emit(MataKuliahLoadedByIdState(data)),
      );
    });

    on<GetMataKuliahByDosenIdEvent>((event, emit) async {
      emit(MataKuliahLoadingState());
      final result = await getMataKuliahByDosenIdUsecase(event.dosenId);

      result.fold(
        (failure) => emit(MataKuliahErrorState(failure.message)),
        (data) => emit(MataKuliahLoadedByDosenIdState(data)),
      );
    });

    on<SelectMataKuliahEvent>((event, emit) {
      emit(MataKuliahSelectedState(event.mataKuliah));
    });
  }
}
