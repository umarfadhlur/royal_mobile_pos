part of 'po_receipt_bloc.dart';

abstract class PoReceiptEvent extends Equatable {}

class NewPoEntry extends PoReceiptEvent {
  final String noSurat;
  final String driver;
  final String containerID;
  final String noKendaraan;
  final List<GridDatum> gridData;

  NewPoEntry({
    this.noSurat,
    this.driver,
    this.containerID,
    this.noKendaraan,
    this.gridData,
  });

  @override
  List<Object> get props => [
        noSurat,
        driver,
        containerID,
        noKendaraan,
        gridData,
      ];
}

class PoEntry extends PoReceiptEvent {
  final String noSurat;
  final String driver;
  final String containerID;
  final String noKendaraan;
  final String poNumber;
  final String lotNumber;
  final String itemNumber;
  final String quantity;
  final String uom;

  PoEntry({
    this.noSurat,
    this.driver,
    this.containerID,
    this.noKendaraan,
    this.poNumber,
    this.lotNumber,
    this.itemNumber,
    this.quantity,
    this.uom,
  });

  @override
  List<Object> get props => [
        noSurat,
        driver,
        containerID,
        noKendaraan,
        poNumber,
        lotNumber,
        itemNumber,
        quantity,
        uom
      ];
}

class LotCheck extends PoReceiptEvent {
  final String lotNumber;

  LotCheck({
    this.lotNumber,
  });

  @override
  List<Object> get props => [
        lotNumber,
      ];
}

class GetQtyUom extends PoReceiptEvent {
  final String lotNumber;

  GetQtyUom({
    this.lotNumber,
  });

  @override
  List<Object> get props => [
        lotNumber,
      ];
}

class UpdateItem extends PoReceiptEvent {
  final String lotNumber;
  final String itemNumber;

  UpdateItem({
    this.lotNumber,
    this.itemNumber,
  });

  @override
  List<Object> get props => [
        lotNumber,
        itemNumber,
      ];
}

class GetItemDesc extends PoReceiptEvent {
  final String itemDesc;

  GetItemDesc({
    this.itemDesc,
  });

  @override
  List<Object> get props => [
        itemDesc,
      ];
}
