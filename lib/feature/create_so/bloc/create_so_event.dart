part of 'create_so_bloc.dart';

abstract class CreateSoEvent extends Equatable {}

class CreateSoEntry extends CreateSoEvent {
  final String branchPlant;
  final String customer;
  final String customerPo;
  final List<GridIn13> gridData;
  final String transactionOriginator;

  CreateSoEntry({
    this.branchPlant,
    this.customer,
    this.customerPo,
    this.gridData,
    this.transactionOriginator,
  });

  @override
  List<Object> get props => [
        branchPlant,
        customer,
        customerPo,
        gridData,
        transactionOriginator,
      ];
}

class CreateSoKitEntry extends CreateSoEvent {
  final String branchPlant;
  final String customer;
  final String customerPo;
  final List<GridIn13> gridData;
  final String transactionOriginator;

  CreateSoKitEntry({
    this.branchPlant,
    this.customer,
    this.customerPo,
    this.gridData,
    this.transactionOriginator,
  });

  @override
  List<Object> get props => [
        branchPlant,
        customer,
        customerPo,
        gridData,
        transactionOriginator,
      ];
}

class GetPriceListEvent extends CreateSoEvent {
  final String businessUnit;
  final String itemNumber;
  final String addressNumber;

  GetPriceListEvent({this.businessUnit, this.itemNumber, this.addressNumber});

  @override
  List<Object> get props => [businessUnit, itemNumber, addressNumber];
}

class GetPriceHistoryEvent extends CreateSoEvent {
  final List<GridIn11> gridData;

  GetPriceHistoryEvent({this.gridData});

  @override
  List<Object> get props => [gridData];
}

class GetFreeGoodsEvent extends CreateSoEvent {
  final List<GridIn11> gridData;

  GetFreeGoodsEvent({this.gridData});

  @override
  List<Object> get props => [gridData];
}

class GetFreeGoodsPriceHistoryEvent extends CreateSoEvent {
  final List<GridIn11> gridData;

  GetFreeGoodsPriceHistoryEvent({this.gridData});

  @override
  List<Object> get props => [gridData];
}

class GetFreeGoodsPriceHistoryNewEvent extends CreateSoEvent {
  final List<GridIn11> gridData;

  GetFreeGoodsPriceHistoryNewEvent({this.gridData});

  @override
  List<Object> get props => [gridData];
}

class GetSoHistoryLoadEvent extends CreateSoEvent {}

class PostSoHistoryEvent extends CreateSoEvent {
  final String doco;
  final String mcu;
  final String an8;
  final String vr01;
  final DateTime soDate;

  PostSoHistoryEvent({this.doco, this.mcu, this.an8, this.vr01, this.soDate});

  @override
  List<Object> get props => [doco, mcu, an8, vr01, soDate];
}

class PostSoHistoryNewEvent extends CreateSoEvent {
  final String doco;
  final String mcu;
  final String an8;
  final String vr01;
  final DateTime soDate;
  final List<Detail> gridData;

  PostSoHistoryNewEvent(
      {this.doco, this.mcu, this.an8, this.vr01, this.soDate, this.gridData});

  @override
  List<Object> get props => [doco, mcu, an8, vr01, soDate, gridData];
}

class FetchSoDetailEvent extends CreateSoEvent {
  final int soHeaderId;

  FetchSoDetailEvent({this.soHeaderId});

  @override
  List<Object> get props => [soHeaderId];
}

class GetCustomerEntry extends CreateSoEvent {
  @override
  List<Object> get props => [];
}

class GetItemBranchEvent extends CreateSoEvent {
  final String the2NdItemNumber1;
  final String businessUnit1;

  GetItemBranchEvent({this.the2NdItemNumber1, this.businessUnit1});

  @override
  List<Object> get props => [the2NdItemNumber1, businessUnit1];
}
