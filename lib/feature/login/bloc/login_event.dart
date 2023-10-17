part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class LoginSubmit extends LoginEvent {
  final String username;
  final String password;

  LoginSubmit({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class LocalLoginSubmit extends LoginEvent {
  final String username;
  final String password;

  LocalLoginSubmit({this.username, this.password});

  @override
  List<Object> get props => [username, password];
}

class LogoutSubmit extends LoginEvent {
  final String token;

  LogoutSubmit({this.token});

  @override
  List<Object> get props => [token];
}
