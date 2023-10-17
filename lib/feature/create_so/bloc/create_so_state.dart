part of 'create_so_bloc.dart';

abstract class CreateSoState extends Equatable {}

class LoadingDataState extends CreateSoState {
  @override
  List<Object> get props => [];
}

class CreateSoInitial extends CreateSoState {
  @override
  List<Object> get props => [];
}

class SuccessEntry extends CreateSoState {
  final String message;

  SuccessEntry({@required this.message});

  @override
  List<Object> get props => [message];
}

class FailedEntry extends CreateSoState {
  final String message;

  FailedEntry({@required this.message});

  @override
  List<Object> get props => [message];
}

class PriceListLoaded extends CreateSoState {
  final List<PriceList> articles;

  PriceListLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class PriceListNotFound extends CreateSoState {
  final String message;

  PriceListNotFound({@required this.message});

  @override
  List<Object> get props => [message];
}

class GetOrderNumber extends CreateSoState {
  final CreateSoResponseModel previousOrder;

  GetOrderNumber({@required this.previousOrder});

  @override
  List<Object> get props => [previousOrder];
}

class GetOrderKitNumber extends CreateSoState {
  final CreateSoKitResponseModel previousOrder;

  GetOrderKitNumber({@required this.previousOrder});

  @override
  List<Object> get props => [previousOrder];
}

class PriceHistoryLoaded extends CreateSoState {
  final List<RudGetpriceP4074Fr1Rowset> articles;

  PriceHistoryLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class PriceHistoryFailed extends CreateSoState {
  final String message;

  PriceHistoryFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class FreeGoodsLoaded extends CreateSoState {
  final List<ArdF56CpfreRowset> articles;

  FreeGoodsLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class FreeGoodsFailed extends CreateSoState {
  final String message;

  FreeGoodsFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class FreeGoodsPriceHistoryLoaded extends CreateSoState {
  final FreeGoodsGetPriceResponse data;

  FreeGoodsPriceHistoryLoaded({this.data});

  @override
  List<Object> get props => [data];
}

class FreeGoodsPriceHistoryFailed extends CreateSoState {
  final String message;

  FreeGoodsPriceHistoryFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class FreeGoodsPriceHistoryNewLoaded extends CreateSoState {
  final FreeGoodsGetPriceResponseNew data;

  FreeGoodsPriceHistoryNewLoaded({this.data});

  @override
  List<Object> get props => [data];
}

class FreeGoodsPriceHistoryNewFailed extends CreateSoState {
  final String message;

  FreeGoodsPriceHistoryNewFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class SoHistoryLoaded extends CreateSoState {
  final List<GetSoHistory> data;

  SoHistoryLoaded({this.data});

  @override
  List<Object> get props => [data];
}

class SoHistoryFailed extends CreateSoState {
  final String message;

  SoHistoryFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class PostHistorySuccess extends CreateSoState {
  final String message;

  PostHistorySuccess({@required this.message});

  @override
  List<Object> get props => [message];
}

class PostHistoryFailed extends CreateSoState {
  final String message;

  PostHistoryFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class PostHistoryNewSuccess extends CreateSoState {
  final String message;

  PostHistoryNewSuccess({@required this.message});

  @override
  List<Object> get props => [message];
}

class PostHistoryNewFailed extends CreateSoState {
  final String message;

  PostHistoryNewFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class SoDetailLoaded extends CreateSoState {
  final List<GetSoDetail> detail;

  SoDetailLoaded({@required this.detail});

  @override
  List<Object> get props => [detail];
}

class SoDetailFailed extends CreateSoState {
  final String message;

  SoDetailFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class CustomerLoaded extends CreateSoState {
  final List<GetCustomerResponse> articles;

  CustomerLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class CustomerFailed extends CreateSoState {
  final String message;

  CustomerFailed({@required this.message});

  @override
  List<Object> get props => [message];
}

class ItemBranchLoaded extends CreateSoState {
  final List<ItemBranch> articles;

  ItemBranchLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class ItemBranchFailed extends CreateSoState {
  final String message;

  ItemBranchFailed({@required this.message});

  @override
  List<Object> get props => [message];
}