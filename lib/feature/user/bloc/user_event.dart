part of 'user_bloc.dart';

abstract class GetUserEvent extends Equatable {}

class GetUserEntry extends GetUserEvent {
  @override
  List<Object> get props => [];
}

class AddUserEvent extends GetUserEvent {
  final String userId;
  final String password;
  final String name;
  final String branchPlant;
  final String shopId;

  AddUserEvent(
      {this.userId, this.password, this.name, this.branchPlant, this.shopId});

  @override
  List<Object> get props => [userId, password, name, branchPlant, shopId];
}
