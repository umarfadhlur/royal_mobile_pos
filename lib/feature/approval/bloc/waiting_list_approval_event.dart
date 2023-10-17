part of 'waiting_list_approval_bloc.dart';

abstract class WaitingListApprovalEvent extends Equatable {}

class SearchListSelectEvent extends WaitingListApprovalEvent {
  final String descriptionF1201;

  SearchListSelectEvent({this.descriptionF1201});

  @override
  List<Object> get props => [descriptionF1201];
}

class FilterListSelectEvent extends WaitingListApprovalEvent {
  final String personResponsible;
  final String eventPoint;

  FilterListSelectEvent({this.personResponsible, this.eventPoint});

  @override
  List<Object> get props => [personResponsible, eventPoint];
}

class DetailListSelectEvent extends WaitingListApprovalEvent {
  final String orderCompany;
  final String orderNumber;
  final String orderType;

  DetailListSelectEvent({this.orderCompany, this.orderNumber, this.orderType});

  @override
  List<Object> get props => [orderCompany, orderNumber, orderType];
}

class ApproveEntry extends WaitingListApprovalEvent {
  final String orderNumber;

  ApproveEntry({this.orderNumber});

  @override
  List<Object> get props => [orderNumber];
}

class RejectEntry extends WaitingListApprovalEvent {
  final String orderNumber;
  final String remarks;

  RejectEntry({this.orderNumber, this.remarks});

  @override
  List<Object> get props => [orderNumber, remarks];
}
