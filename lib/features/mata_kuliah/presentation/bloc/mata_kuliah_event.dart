part of 'mata_kuliah_bloc.dart';

abstract class MataKuliahEvent extends Equatable {
  const MataKuliahEvent();

  @override
  List<Object?> get props => [];
}

class GetAllMataKuliahEvent extends MataKuliahEvent {}

class GetMataKuliahByIdEvent extends MataKuliahEvent {
  final String id;

  const GetMataKuliahByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class GetMataKuliahByDosenIdEvent extends MataKuliahEvent {
  final String dosenId;

  const GetMataKuliahByDosenIdEvent(this.dosenId);

  @override
  List<Object?> get props => [dosenId];
}

class SelectMataKuliahEvent extends MataKuliahEvent {
  final MataKuliahEntity mataKuliah;

  const SelectMataKuliahEvent(this.mataKuliah);

  @override
  List<Object?> get props => [mataKuliah];
}
