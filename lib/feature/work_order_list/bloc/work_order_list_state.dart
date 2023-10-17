part of 'work_order_list_bloc.dart';

abstract class WorkOrderListState extends Equatable {}

class WorkOrderListInitial extends WorkOrderListState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends WorkOrderListState {
  @override
  List<Object> get props => [];
}

class ArticleLoadedState extends WorkOrderListState {
  final List<WOList> articles;

  ArticleLoadedState({@required this.articles});
  @override
  List<Object> get props => [articles];
}

class ArticleLoadedState1 extends WorkOrderListState {
  final List<WOList> articles;

  ArticleLoadedState1({@required this.articles});
  @override
  List<Object> get props => [articles];
}

class ArticleErrorState extends WorkOrderListState {
  final String message;

  ArticleErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}

class CompanySelectState extends WorkOrderListState {
  final String name;
  final String co;

  CompanySelectState({this.name, this.co});

  @override
  List<Object> get props => [name, co];
}
