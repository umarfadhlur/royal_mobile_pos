// To parse this JSON data, do
//
//     final equipMasterDetailResponseModel = equipMasterDetailResponseModelFromJson(jsonString);

import 'dart:convert';

EquipMasterDetailResponseModel equipMasterDetailResponseModelFromJson(
        String str) =>
    EquipMasterDetailResponseModel.fromJson(json.decode(str));

String equipMasterDetailResponseModelToJson(
        EquipMasterDetailResponseModel data) =>
    json.encode(data.toJson());

class EquipMasterDetailResponseModel {
  EquipMasterDetailResponseModel({
    this.equipMasterDetailHdn,
  });

  final EquipMasterDetailHdn equipMasterDetailHdn;

  factory EquipMasterDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      EquipMasterDetailResponseModel(
        equipMasterDetailHdn:
            EquipMasterDetailHdn.fromJson(json["Equip_Master_Detail_HDN"]),
      );

  Map<String, dynamic> toJson() => {
        "Equip_Master_Detail_HDN": equipMasterDetailHdn.toJson(),
      };
}

class EquipMasterDetailHdn {
  EquipMasterDetailHdn({
    this.tableId,
    this.rowset,
    this.records,
    this.moreRecords,
  });

  final String tableId;
  final List<DetailList> rowset;
  final int records;
  final bool moreRecords;

  factory EquipMasterDetailHdn.fromJson(Map<String, dynamic> json) =>
      EquipMasterDetailHdn(
        tableId: json["tableId"],
        rowset: List<DetailList>.from(
            json["rowset"].map((x) => DetailList.fromJson(x))),
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

class DetailList {
  DetailList({
    this.assetNumberF1217,
    this.unitNumberF1201,
    this.parentNumberF1201,
    this.serialNumberF1201,
    this.descriptionF1201,
    this.dateAcquiredF1201,
    this.eqStF1201,
    this.lessorAddressF1201,
    this.contractDateF1201,
    this.locationF1201,
    this.wOF1201,
    this.meterSchedulesF1217,
  });

  final String assetNumberF1217;
  final String unitNumberF1201;
  final String parentNumberF1201;
  final String serialNumberF1201;
  final String descriptionF1201;
  final String dateAcquiredF1201;
  final String eqStF1201;
  final String lessorAddressF1201;
  final String contractDateF1201;
  final String locationF1201;
  final String wOF1201;
  final String meterSchedulesF1217;

  factory DetailList.fromJson(Map<String, dynamic> json) => DetailList(
        assetNumberF1217: json["Asset Number [F1217]"],
        unitNumberF1201: json["Unit Number [F1201]"],
        parentNumberF1201: json["Parent Number [F1201]"],
        serialNumberF1201: json["Serial Number [F1201]"],
        descriptionF1201: json["Description  [F1201]"],
        dateAcquiredF1201: json["Date Acquired [F1201]"],
        eqStF1201: json["Eq St [F1201]"],
        lessorAddressF1201: json["Lessor Address [F1201]"],
        contractDateF1201: json["Contract Date [F1201]"],
        locationF1201: json["Location  [F1201]"],
        wOF1201: json["W O [F1201]"],
        meterSchedulesF1217: json["Meter Schedules [F1217]"],
      );

  Map<String, dynamic> toJson() => {
        "Asset Number [F1217]": assetNumberF1217,
        "Unit Number [F1201]": unitNumberF1201,
        "Parent Number [F1201]": parentNumberF1201,
        "Serial Number [F1201]": serialNumberF1201,
        "Description  [F1201]": descriptionF1201,
        "Date Acquired [F1201]": dateAcquiredF1201,
        "Eq St [F1201]": eqStF1201,
        "Lessor Address [F1201]": lessorAddressF1201,
        "Contract Date [F1201]": contractDateF1201,
        "Location  [F1201]": locationF1201,
        "W O [F1201]": wOF1201,
        "Meter Schedules [F1217]": meterSchedulesF1217,
      };
}
