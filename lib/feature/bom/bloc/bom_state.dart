part of 'bom_bloc.dart';

abstract class BomState extends Equatable {}

class BomInitial extends BomState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends BomState {
  @override
  List<Object> get props => [];
}

class SuccessEntry extends BomState {
  final String message;

  SuccessEntry({@required this.message});

  @override
  List<Object> get props => [message];
}

class BomLoaded extends BomState {
  final List<Rowset> articles;

  BomLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class BomNotFound extends BomState {
  final String message;

  BomNotFound({@required this.message});

  @override
  List<Object> get props => [message];
}