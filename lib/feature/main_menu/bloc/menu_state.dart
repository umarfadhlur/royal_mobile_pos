part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {}

class MenuInitial extends MenuState {
  @override
  List<Object> get props => [];
}

class GetCountWOSuccess extends MenuState {
  final ResponseCountWo countWo;
  final ResponseWatchlistCountWo watchList;

  GetCountWOSuccess({@required this.countWo, @required this.watchList});

  @override
  List<Object> get props => [countWo, watchList];
}

class MenuErrorState extends MenuState {
  final String message;

  MenuErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

class GetWatchListSuccess extends MenuState {
  final ResponseWatchlistCountWo watchList;

  GetWatchListSuccess({@required this.watchList});

  @override
  List<Object> get props => [watchList];
}
