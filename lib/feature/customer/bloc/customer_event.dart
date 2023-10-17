part of 'customer_bloc.dart';

abstract class GetCustomerEvent extends Equatable {}

class GetCustomerEntry extends GetCustomerEvent {
  @override
  List<Object> get props => [];
}

class AddCustomerEvent extends GetCustomerEvent {
  final String nama;
  final String alamat;
  final String noHp;
  final String idNumber;

  AddCustomerEvent(
      {this.nama, this.alamat, this.noHp, this.idNumber});

  @override
  List<Object> get props => [nama, alamat, noHp, idNumber];
}
