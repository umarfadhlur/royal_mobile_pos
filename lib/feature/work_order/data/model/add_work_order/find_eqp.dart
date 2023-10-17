// To parse this JSON data, do
//
//     final findEqpResponseModel = findEqpResponseModelFromJson(jsonString);

import 'dart:convert';

FindEqpResponseModel findEqpResponseModelFromJson(String str) =>
    FindEqpResponseModel.fromJson(json.decode(str));

String findEqpResponseModelToJson(FindEqpResponseModel data) =>
    json.encode(data.toJson());

class FindEqpResponseModel {
  FindEqpResponseModel({
    this.rudFindeqpF1201Dr1,
  });

  final RudFindeqpF1201Dr1 rudFindeqpF1201Dr1;

  factory FindEqpResponseModel.fromJson(Map<String, dynamic> json) =>
      FindEqpResponseModel(
        rudFindeqpF1201Dr1:
            RudFindeqpF1201Dr1.fromJson(json["RUD_FINDEQP_F1201_DR1"]),
      );

  Map<String, dynamic> toJson() => {
        "RUD_FINDEQP_F1201_DR1": rudFindeqpF1201Dr1.toJson(),
      };
}

class RudFindeqpF1201Dr1 {
  RudFindeqpF1201Dr1({
    this.tableId,
    this.rowset,
    this.records,
    this.moreRecords,
  });

  final String tableId;
  final List<Equipment> rowset;
  final int records;
  final bool moreRecords;

  factory RudFindeqpF1201Dr1.fromJson(Map<String, dynamic> json) =>
      RudFindeqpF1201Dr1(
        tableId: json["tableId"],
        rowset: List<Equipment>.from(
            json["rowset"].map((x) => Equipment.fromJson(x))),
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

class Equipment {
  Equipment({
    this.countEquipment,
  });

  final int countEquipment;

  factory Equipment.fromJson(Map<String, dynamic> json) => Equipment(
        countEquipment: json["Count Equipment"],
      );

  Map<String, dynamic> toJson() => {
        "Count Equipment": countEquipment,
      };
}
