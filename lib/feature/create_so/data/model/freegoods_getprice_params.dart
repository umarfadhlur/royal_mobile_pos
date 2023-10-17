// To parse this JSON data, do
//
//     final freeGoodsGetPriceParams = freeGoodsGetPriceParamsFromJson(jsonString);

import 'dart:convert';

FreeGoodsGetPriceParams freeGoodsGetPriceParamsFromJson(String str) =>
    FreeGoodsGetPriceParams.fromJson(json.decode(str));

String freeGoodsGetPriceParamsToJson(FreeGoodsGetPriceParams data) =>
    json.encode(data.toJson());

class FreeGoodsGetPriceParams {
  String token;
  String username;
  String password;

  List<GridIn11> gridIn11;

  FreeGoodsGetPriceParams({
    this.token,
    this.username,
    this.password,
    this.gridIn11,
  });

  factory FreeGoodsGetPriceParams.fromJson(Map<String, dynamic> json) =>
      FreeGoodsGetPriceParams(
        token: json["token"],
        username: json["username"],
        password: json["password"],
        gridIn11: List<GridIn11>.from(
            json["GridIn_1_1"].map((x) => GridIn11.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "username": username,
        "password": password,
        "GridIn_1_1": List<dynamic>.from(gridIn11.map((x) => x.toJson())),
      };
}

class GridIn11 {
  String orderCo;
  String orTy;
  String lineNumber;
  String customerNumber;
  String the2NdItemNumber;
  String businessUnit;
  String transQty;
  String um;
  String dateUpdated;

  GridIn11({
    this.orderCo,
    this.orTy,
    this.lineNumber,
    this.customerNumber,
    this.the2NdItemNumber,
    this.businessUnit,
    this.transQty,
    this.um,
    this.dateUpdated,
  });

  factory GridIn11.fromJson(Map<String, dynamic> json) => GridIn11(
        orderCo: json["Order_Co"],
        orTy: json["Or_Ty"],
        lineNumber: json["Line_Number"],
        customerNumber: json["Customer_Number"],
        the2NdItemNumber: json["2nd_Item_Number"],
        businessUnit: json["Business_Unit"],
        transQty: json["Trans_QTY"],
        um: json["UM"],
        dateUpdated: json["Date_Updated"],
      );

  Map<String, dynamic> toJson() => {
        "Order_Co": orderCo,
        "Or_Ty": orTy,
        "Line_Number": lineNumber,
        "Customer_Number": customerNumber,
        "2nd_Item_Number": the2NdItemNumber,
        "Business_Unit": businessUnit,
        "Trans_QTY": transQty,
        "UM": um,
        "Date_Updated": dateUpdated,
      };
}
