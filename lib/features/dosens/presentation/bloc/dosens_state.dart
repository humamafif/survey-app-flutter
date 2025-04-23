part of 'dosens_bloc.dart';

abstract class DosensState extends Equatable {
  const DosensState();

  @override
  List<Object> get props => [];
}

class DosensInitial extends DosensState {}

class DosensLoadingState extends DosensState {}

class DosensLoadedGetAllState extends DosensState {
  final List<DosenEntity> dosens;

  const DosensLoadedGetAllState(this.dosens);

  @override
  List<Object> get props => [dosens];
}

class DosensErrorState extends DosensState {
  final String message;

  const DosensErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class DosensSelectedState extends DosensState {
  final DosenEntity selectedDosenState;

  const DosensSelectedState(this.selectedDosenState);
}
