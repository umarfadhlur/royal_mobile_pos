part of 'work_order_bloc.dart';

abstract class WorkOrderState extends Equatable {}

class AddWorkOrderInitial extends WorkOrderState {
  @override
  List<Object> get props => [];
}

class AddWorkOrderLoad extends WorkOrderState {
  final String message;

  AddWorkOrderLoad({@required this.message});

  @override
  List<Object> get props => [message];
}

class WorkOrderLoaded extends WorkOrderState {
  final WorkOrderResponseModel model;

  WorkOrderLoaded({this.model});

  @override
  List<Object> get props => [model];
}

class CustomerFound extends WorkOrderState {
  final FindCustomerResponseModel model;

  CustomerFound({this.model});

  @override
  List<Object> get props => [model];
}

class AddWorkOrderError extends WorkOrderState {
  final String error;

  AddWorkOrderError({@required this.error});

  @override
  List<Object> get props => [error];
}

class AddError extends WorkOrderState {
  final String error;

  AddError({@required this.error});

  @override
  List<Object> get props => [error];
}
