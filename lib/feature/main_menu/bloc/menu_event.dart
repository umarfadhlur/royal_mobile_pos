part of 'menu_bloc.dart';

abstract class MenuEvent extends Equatable {}

class MenuGetAN8 extends MenuEvent {
  final GetAn8 an8;
  
  MenuGetAN8({this.an8});

  @override
  List<Object> get props => [an8];
}

class GetAN8Input extends MenuEvent {
  final String token;
  final String val;
  final String co;
  final String status;

  GetAN8Input({this.co, this.token, this.val, this.status});

  @override
  List<Object> get props => [token, val, co, status];
}

class MenuGetCountWO extends MenuEvent {
  final ResponseCountWo countWo;
  
  MenuGetCountWO({this.countWo});

  @override
  List<Object> get props => [countWo];
}