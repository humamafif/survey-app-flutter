part of 'mata_kuliah_bloc.dart';

abstract class MataKuliahState extends Equatable {
  const MataKuliahState();

  @override
  List<Object?> get props => [];
}

class MataKuliahInitial extends MataKuliahState {}

class MataKuliahLoadingState extends MataKuliahState {}

class MataKuliahErrorState extends MataKuliahState {
  final String message;

  const MataKuliahErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class MataKuliahLoadedAllState extends MataKuliahState {
  final List<MataKuliahEntity> mataKuliah;

  const MataKuliahLoadedAllState(this.mataKuliah);

  @override
  List<Object?> get props => [mataKuliah];
}

class MataKuliahLoadedByIdState extends MataKuliahState {
  final MataKuliahEntity mataKuliah;

  const MataKuliahLoadedByIdState(this.mataKuliah);

  @override
  List<Object?> get props => [mataKuliah];
}

class MataKuliahLoadedByDosenIdState extends MataKuliahState {
  final List<MataKuliahEntity> mataKuliah;

  const MataKuliahLoadedByDosenIdState(this.mataKuliah);

  @override
  List<Object?> get props => [mataKuliah];
}

class MataKuliahSelectedState extends MataKuliahState {
  final MataKuliahEntity selectedMataKuliah;

  const MataKuliahSelectedState(this.selectedMataKuliah);

  @override
  List<Object?> get props => [selectedMataKuliah];
}
