part of 'get_price_bloc.dart';

abstract class GetPriceEvent extends Equatable {}

class FetchListEvent extends GetPriceEvent {
  final String token;

  FetchListEvent({this.token});

  @override
  List<Object> get props => [token];
}

class GetPriceListEvent extends GetPriceEvent {
  final String businessUnit;
  final String itemNumber;
  final String addressNumber;

  GetPriceListEvent({this.businessUnit, this.itemNumber, this.addressNumber});

  @override
  List<Object> get props => [businessUnit, itemNumber, addressNumber];
}
