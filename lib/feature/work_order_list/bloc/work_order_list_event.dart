part of 'work_order_list_bloc.dart';

abstract class WorkOrderListEvent extends Equatable {}

class FetchListEvent extends WorkOrderListEvent {
  final String token;

  FetchListEvent({this.token});

  @override
  List<Object> get props => [token];
}

class FetchListSelectEvent extends WorkOrderListEvent {
  final String name;
  final String co;

  FetchListSelectEvent({this.name, this.co});

  @override
  List<Object> get props => [name, co];
}

class SearchListSelectEvent extends WorkOrderListEvent {
  final int orderNumber;

  SearchListSelectEvent({this.orderNumber});

  @override
  List<Object> get props => [orderNumber];
}

class FilterListSelectEvent extends WorkOrderListEvent {
  final int orderNumber;
  final String orTy;
  final String requestDate;
  final String assetNumber;
  final String woStatus;
  final String branch;

  FilterListSelectEvent(
      {this.orderNumber,
      this.orTy,
      this.requestDate,
      this.assetNumber,
      this.woStatus,
      this.branch});

  @override
  List<Object> get props =>
      [orderNumber, orTy, requestDate, assetNumber, woStatus, branch];
}
