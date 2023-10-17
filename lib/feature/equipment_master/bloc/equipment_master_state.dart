part of 'equipment_master_bloc.dart';

abstract class EquipMasterState extends Equatable {}

class EquipMasterInitial extends EquipMasterState {
  @override
  List<Object> get props => [];
}

class EquipMasterDetailInitial extends EquipMasterState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends EquipMasterState {
  @override
  List<Object> get props => [];
}

class ArticleLoadedState extends EquipMasterState {
  final List<EMList> articles;

  ArticleLoadedState({@required this.articles});
  @override
  List<Object> get props => [articles];
}

class DetailLoadedState extends EquipMasterState {
  final List<DetailList> articles;

  DetailLoadedState({@required this.articles});
  @override
  List<Object> get props => [articles];
}

class ArticleErrorState extends EquipMasterState {
  final String message;

  ArticleErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

class CompanySelectState extends EquipMasterState {
  final String name;
  final String co;

  CompanySelectState({this.name, this.co});

  @override
  List<Object> get props => [name, co];
}
