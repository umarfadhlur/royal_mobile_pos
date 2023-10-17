part of 'equipment_master_bloc.dart';

abstract class EquipMasterEvent extends Equatable {}

class FetchListEvent extends EquipMasterEvent {
  final String token;

  FetchListEvent({this.token});

  @override
  List<Object> get props => [token];
}

class FetchListSelectEvent extends EquipMasterEvent {
  final String name;
  final String co;

  FetchListSelectEvent({this.name, this.co});

  @override
  List<Object> get props => [name, co];
}

class SearchListSelectEvent extends EquipMasterEvent {
  final String descriptionF1201;

  SearchListSelectEvent({this.descriptionF1201});

  @override
  List<Object> get props => [descriptionF1201];
}

class FilterListSelectEvent extends EquipMasterEvent {
  final String descriptionF1201;
  final String unitNumberF1201;

  FilterListSelectEvent({this.descriptionF1201, this.unitNumberF1201});

  @override
  List<Object> get props => [descriptionF1201, unitNumberF1201];
}

class FindEquipment extends EquipMasterEvent {
  final String assetNumberF1217;

  FindEquipment({this.assetNumberF1217});

  @override
  List<Object> get props => [assetNumberF1217];
}
