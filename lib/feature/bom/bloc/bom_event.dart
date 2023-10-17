part of 'bom_bloc.dart';

abstract class BomEvent extends Equatable {}

class BomEntry extends BomEvent {
  @override
  List<Object> get props => [];
}

class GetBomEvent extends BomEvent {
  final String branch1;
  final String the2ndItemNumber;
  final String typBom1;

  GetBomEvent({this.branch1, this.the2ndItemNumber, this.typBom1});

  @override
  List<Object> get props => [branch1, the2ndItemNumber, typBom1];
}