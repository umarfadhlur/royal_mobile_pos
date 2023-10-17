// To parse this JSON data, do
//
//     final equipMasterResponseModel = equipMasterResponseModelFromJson(jsonString);

import 'dart:convert';

EquipMasterResponseModel equipMasterResponseModelFromJson(String str) =>
    EquipMasterResponseModel.fromJson(json.decode(str));

String equipMasterResponseModelToJson(EquipMasterResponseModel data) =>
    json.encode(data.toJson());

class EquipMasterResponseModel {
  EquipMasterResponseModel({
    this.hdnEquipMasterSvr,
  });

  final HdnEquipMasterSvr hdnEquipMasterSvr;

  factory EquipMasterResponseModel.fromJson(Map<String, dynamic> json) =>
      EquipMasterResponseModel(
        hdnEquipMasterSvr:
            HdnEquipMasterSvr.fromJson(json["HDN_EQUIP_MASTER_SVR"]),
      );

  Map<String, dynamic> toJson() => {
        "HDN_EQUIP_MASTER_SVR": hdnEquipMasterSvr.toJson(),
      };
}

class HdnEquipMasterSvr {
  HdnEquipMasterSvr({
    this.tableId,
    this.rowset,
    this.records,
    this.moreRecords,
  });

  final String tableId;
  final List<EMList> rowset;
  final int records;
  final bool moreRecords;

  factory HdnEquipMasterSvr.fromJson(Map<String, dynamic> json) =>
      HdnEquipMasterSvr(
        tableId: json["tableId"],
        rowset:
            List<EMList>.from(json["rowset"].map((x) => EMList.fromJson(x))),
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

class EMList {
  EMList({
    this.assetNumberF1201,
    this.unitNumberF1201,
    this.descriptionF1201,
    this.eqStF1201,
    this.lessorAddressF1201,
    this.contractDateF1201,
  });

  final String assetNumberF1201;
  final String unitNumberF1201;
  final String descriptionF1201;
  final String eqStF1201;
  final String lessorAddressF1201;
  final String contractDateF1201;

  factory EMList.fromJson(Map<String, dynamic> json) => EMList(
        assetNumberF1201: json["Asset Number [F1201]"],
        unitNumberF1201: json["Unit Number [F1201]"],
        descriptionF1201: json["Description  [F1201]"],
        eqStF1201: json["Eq St [F1201]"],
        lessorAddressF1201: json["Lessor Address [F1201]"],
        contractDateF1201: json["Contract Date [F1201]"],
      );

  Map<String, dynamic> toJson() => {
        "Asset Number [F1201]": assetNumberF1201,
        "Unit Number [F1201]": unitNumberF1201,
        "Description  [F1201]": descriptionF1201,
        "Eq St [F1201]": eqStF1201,
        "Lessor Address [F1201]": lessorAddressF1201,
        "Contract Date [F1201]": contractDateF1201,
      };
}
