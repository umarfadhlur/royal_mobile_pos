// To parse this JSON data, do
//
//     final poReceiptNewParam = poReceiptNewParamFromJson(jsonString);

import 'dart:convert';

PoReceiptNewParam poReceiptNewParamFromJson(String str) =>
    PoReceiptNewParam.fromJson(json.decode(str));

String poReceiptNewParamToJson(PoReceiptNewParam data) =>
    json.encode(data.toJson());

class PoReceiptNewParam {
  PoReceiptNewParam({
    this.token,
    this.nomorSuratJalan,
    this.driver,
    this.containerId,
    this.nomorKendaraan,
    this.gridData,
  });

  final String token;
  final String nomorSuratJalan;
  final String driver;
  final String containerId;
  final String nomorKendaraan;
  final List<GridDatum> gridData;

  factory PoReceiptNewParam.fromJson(Map<String, dynamic> json) =>
      PoReceiptNewParam(
        token: json["token"],
        nomorSuratJalan: json["NomorSuratJalan"],
        driver: json["Driver"],
        containerId: json["Container ID"],
        nomorKendaraan: json["NomorKendaraan"],
        gridData: List<GridDatum>.from(
            json["GridData"].map((x) => GridDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "NomorSuratJalan": nomorSuratJalan,
        "Driver": driver,
        "Container ID": containerId,
        "NomorKendaraan": nomorKendaraan,
        "GridData": List<dynamic>.from(gridData.map((x) => x.toJson())),
      };
}

class GridDatum {
  GridDatum({
    this.poNumber,
    this.lotSerialNumber,
    this.itemNumber,
    this.quantity,
    this.uom,
  });

  final String poNumber;
  final String lotSerialNumber;
  final String itemNumber;
  final String quantity;
  final String uom;

  factory GridDatum.fromJson(Map<String, dynamic> json) => GridDatum(
        poNumber: json["PO Number"],
        lotSerialNumber: json["Lot Serial Number"],
        itemNumber: json["Item Number"],
        quantity: json["Quantity"],
        uom: json["UOM"],
      );

  Map<String, dynamic> toJson() => {
        "PO Number": poNumber,
        "Lot Serial Number": lotSerialNumber,
        "Item Number": itemNumber,
        "Quantity": quantity,
        "UOM": uom,
      };
  
  @override toString() => 'poNumber: $poNumber, lotSerialNumber: $lotSerialNumber, itemNumber: $itemNumber, quantity: $quantity, uom: $uom';
}
