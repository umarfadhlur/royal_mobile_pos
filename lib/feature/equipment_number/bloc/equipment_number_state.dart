part of 'equipment_number_bloc.dart';

abstract class EquipmentNumberState extends Equatable {}

class EquipmentNumberInitial extends EquipmentNumberState {
  @override
  List<Object> get props => [];
}

class EquipmentFound extends EquipmentNumberState {
  final ResponseEquipment equipment;

  EquipmentFound({this.equipment});

  @override
  List<Object> get props => [equipment];
}

class AddError extends EquipmentNumberState {
  final String error;

  AddError({@required this.error});

  @override
  List<Object> get props => [error];
}

class AddSuccess extends EquipmentNumberState {
  final String success;

  AddSuccess({@required this.success});

  @override
  List<Object> get props => [success];
}
