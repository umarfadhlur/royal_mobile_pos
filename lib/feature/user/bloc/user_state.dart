part of 'user_bloc.dart';

abstract class GetUserState extends Equatable {}

class GetUserInitial extends GetUserState {
  @override
  List<Object> get props => [];
}

class LoadingUserState extends GetUserState {}

class UserLoaded extends GetUserState {
  final List<GetUserResponse> articles;

  UserLoaded({this.articles});

  @override
  List<Object> get props => [articles];
}

class UserFailed extends GetUserState {
  final String message;

  UserFailed({this.message});

  @override
  List<Object> get props => [message];
}

class AddUserSuccess extends GetUserState {
  final String message;

  AddUserSuccess({@required this.message});

  @override
  List<Object> get props => [message];
}

class AddUserFailed extends GetUserState {
  final String message;

  AddUserFailed({@required this.message});

  @override
  List<Object> get props => [message];
}