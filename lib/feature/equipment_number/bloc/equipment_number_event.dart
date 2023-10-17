part of 'equipment_number_bloc.dart';

abstract class EquipmentNumberEvent extends Equatable {}

class FindEquipment extends EquipmentNumberEvent {
  final String equipmentNumber;

  FindEquipment({this.equipmentNumber});

  @override
  List<Object> get props => [equipmentNumber];
}

class UpdateEquipment extends EquipmentNumberEvent {
  final String equipmentNumber;
  final String longitude;
  final String latitude;

  UpdateEquipment({this.equipmentNumber, this.longitude, this.latitude});

  @override
  List<Object> get props => [equipmentNumber, longitude, latitude];
}
