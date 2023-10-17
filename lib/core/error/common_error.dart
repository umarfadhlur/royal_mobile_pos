import 'package:equatable/equatable.dart';

class CommonError extends Equatable{
  CommonError([List properties = const <dynamic>[]]) : super([properties]);
}

class NoConnectionError extends CommonError {
  String get message => 'There is no Internet connection';
}

class ServerError extends CommonError {
  final String message;

  ServerError({this.message}) : super([message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ServerError { message: $message }';

}

class ClientError extends CommonError{
  final String message;

  ClientError({this.message}) : super([message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ClientError { message: $message }';

}

class UnknownError extends CommonError {
  final String message;

  UnknownError({this.message}) : super([message]);

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'UnknownError { message: $message }';
}