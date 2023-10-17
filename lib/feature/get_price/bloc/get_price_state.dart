part of 'get_price_bloc.dart';

abstract class GetPriceState extends Equatable {}

class GetPriceInitial extends GetPriceState {
  @override
  List<Object> get props => [];
}

class GetPriceDetailInitial extends GetPriceState {
  @override
  List<Object> get props => [];
}

class ArticleLoadingState extends GetPriceState {
  @override
  List<Object> get props => [];
}

class SuccessEntry extends GetPriceState {
  final String message;

  SuccessEntry({@required this.message});

  @override
  List<Object> get props => [message];
}

class PriceListLoaded extends GetPriceState {
  final List<PriceList> articles;

  PriceListLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class PriceListNotFound extends GetPriceState {
  final String message;

  PriceListNotFound({@required this.message});

  @override
  List<Object> get props => [message];
}

// class ArticleLoadedState extends GetPriceState {
//   final List<PriceList> articles;

//   ArticleLoadedState({@required this.articles});
//   @override
//   List<Object> get props => [articles];
// }


// class ArticleErrorState extends GetPriceState {
//   final String message;

//   ArticleErrorState({@required this.message});

//   @override
//   List<Object> get props => [message];
// }