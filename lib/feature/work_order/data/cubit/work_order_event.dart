part of 'work_order_bloc.dart';

abstract class WorkOrderEvent extends Equatable {}

class FetchWorkOrderAdd extends WorkOrderEvent {
  final int customerNumber;
  final String contactName;
  final String prefix;
  final String phone;
  final String equipNumber;
  final String invItemNumber;
  final String failureDesc;
  final String reqFinishDate;
  final String reqFinishTime;
  final String notes;

  FetchWorkOrderAdd(
      this.customerNumber,
      this.contactName,
      this.prefix,
      this.phone,
      this.equipNumber,
      this.invItemNumber,
      this.failureDesc,
      this.reqFinishDate,
      this.reqFinishTime,
      this.notes);

  @override
  List<Object> get props => [
        customerNumber,
        contactName,
        prefix,
        phone,
        equipNumber,
        invItemNumber,
        failureDesc,
        reqFinishDate,
        reqFinishTime,
        notes
      ];
}

class FindCustomer extends WorkOrderEvent {
  final String customerNumber;

  FindCustomer(this.customerNumber);

  @override
  List<Object> get props => [customerNumber];
}

class FindEquipment extends WorkOrderEvent {
  final String equipNumber;

  FindEquipment(this.equipNumber);

  @override
  List<Object> get props => [equipNumber];
}

class FindItem extends WorkOrderEvent {
  final String invItemNumber;

  FindItem(this.invItemNumber);

  @override
  List<Object> get props => [invItemNumber];
}
