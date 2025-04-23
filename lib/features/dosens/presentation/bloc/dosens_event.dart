part of 'dosens_bloc.dart';

abstract class DosensEvent extends Equatable {
  const DosensEvent();

  @override
  List<Object> get props => [];
}

class GetAllDosensEvent extends DosensEvent {
  const GetAllDosensEvent();

  @override
  List<Object> get props => [];
}

class SelectedDosenEvent extends DosensEvent {
  final DosenEntity selectedDosen;

  const SelectedDosenEvent({required this.selectedDosen});
}
