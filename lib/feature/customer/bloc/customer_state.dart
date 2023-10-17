part of 'customer_bloc.dart';

abstract class GetCustomerState extends Equatable {}

class GetCustomerInitial extends GetCustomerState {
  @override
  List<Object> get props => [];
}

class LoadingCustomerState extends GetCustomerState {}

class CustomerLoaded extends GetCustomerState {
  final List<GetCustomerResponse> articles;

  CustomerLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class CustomerFailed extends GetCustomerState {
  final String message;

  CustomerFailed({this.message});

  @override
  List<Object> get props => [message];
}

class AddCustomerSuccess extends GetCustomerState {
  final String message;

  AddCustomerSuccess({@required this.message});

  @override
  List<Object> get props => [message];
}

class AddCustomerFailed extends GetCustomerState {
  final String message;

  AddCustomerFailed({@required this.message});

  @override
  List<Object> get props => [message];
}