// To parse this JSON data, do
//
//     final findItemResponseModel = findItemResponseModelFromJson(jsonString);

import 'dart:convert';

FindItemResponseModel findItemResponseModelFromJson(String str) =>
    FindItemResponseModel.fromJson(json.decode(str));

String findItemResponseModelToJson(FindItemResponseModel data) =>
    json.encode(data.toJson());

class FindItemResponseModel {
  FindItemResponseModel({
    this.rudFinditemF4101Dr1,
  });

  final RudFinditemF4101Dr1 rudFinditemF4101Dr1;

  factory FindItemResponseModel.fromJson(Map<String, dynamic> json) =>
      FindItemResponseModel(
        rudFinditemF4101Dr1:
            RudFinditemF4101Dr1.fromJson(json["RUD_FINDITEM_F4101_DR1"]),
      );

  Map<String, dynamic> toJson() => {
        "RUD_FINDITEM_F4101_DR1": rudFinditemF4101Dr1.toJson(),
      };
}

class RudFinditemF4101Dr1 {
  RudFinditemF4101Dr1({
    this.tableId,
    this.rowset,
    this.records,
    this.moreRecords,
  });

  final String tableId;
  final List<Item> rowset;
  final int records;
  final bool moreRecords;

  factory RudFinditemF4101Dr1.fromJson(Map<String, dynamic> json) =>
      RudFinditemF4101Dr1(
        tableId: json["tableId"],
        rowset: List<Item>.from(json["rowset"].map((x) => Item.fromJson(x))),
        records: json["records"],
        moreRecords: json["moreRecords"],
      );

  Map<String, dynamic> toJson() => {
        "tableId": tableId,
        "rowset": List<dynamic>.from(rowset.map((x) => x.toJson())),
        "records": records,
        "moreRecords": moreRecords,
      };
}

class Item {
  Item({
    this.countItem,
  });

  final int countItem;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        countItem: json["Count Item"],
      );

  Map<String, dynamic> toJson() => {
        "Count Item": countItem,
      };
}
