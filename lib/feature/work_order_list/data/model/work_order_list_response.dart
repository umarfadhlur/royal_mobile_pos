// To parse this JSON data, do
//
//     final workOrderListResponse = workOrderListResponseFromJson(jsonString);

import 'dart:convert';

WorkOrderListResponse workOrderListResponseFromJson(String str) =>
    WorkOrderListResponse.fromJson(json.decode(str));

String workOrderListResponseToJson(WorkOrderListResponse data) =>
    json.encode(data.toJson());

class WorkOrderListResponse {
  WorkOrderListResponse({
    this.rudListwoF4801Dr,
  });

  final RudListwoF4801Dr rudListwoF4801Dr;

  factory WorkOrderListResponse.fromJson(Map<String, dynamic> json) =>
      WorkOrderListResponse(
        rudListwoF4801Dr:
            RudListwoF4801Dr.fromJson(json["RUD_LISTWO_F4801_DR"]),
      );

  Map<String, dynamic> toJson() => {
        "RUD_LISTWO_F4801_DR": rudListwoF4801Dr.toJson(),
      };
}

class RudListwoF4801Dr {
  RudListwoF4801Dr({
    this.tableId,
    this.rowset,
    this.records,
    this.moreRecords,
  });

  final String tableId;
  final List<WOList> rowset;
  final int records;
  final bool moreRecords;

  factory RudListwoF4801Dr.fromJson(Map<String, dynamic> json) =>
      RudListwoF4801Dr(
        tableId: json["tableId"],
        rowset:
            List<WOList>.from(json["rowset"].map((x) => WOList.fromJson(x))),
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

class WOList {
  WOList({
    this.orTy,
    this.orderNumber,
    this.wOType,
    this.priority,
    this.woDescription,
    this.branch,
    this.woStatus,
    this.customerNumber,
    this.originatorNumber,
    this.assignedTo,
    this.requestDate,
    this.assetNumber,
    this.eqpDescription,
  });

  final String orTy;
  final int orderNumber;
  final String wOType;
  final String priority;
  final String woDescription;
  final String branch;
  final String woStatus;
  final int customerNumber;
  final int originatorNumber;
  final int assignedTo;
  final String requestDate;
  final String assetNumber;
  final String eqpDescription;

  factory WOList.fromJson(Map<String, dynamic> json) => WOList(
        orTy: json["Or Ty"],
        orderNumber: json["Order Number"],
        wOType: json["W.O. Type"],
        priority: json["Priority"],
        woDescription: json["WO Description"],
        branch: json["Branch"],
        woStatus: json["WO Status"],
        customerNumber: json["Customer Number"],
        originatorNumber: json["Originator Number"],
        assignedTo: json["Assigned To"],
        requestDate: json["Request Date"],
        assetNumber: json["Asset Number"],
        eqpDescription: json["Eqp Description"],
      );

  Map<String, dynamic> toJson() => {
        "Or Ty": orTy,
        "Order Number": orderNumber,
        "W.O. Type": wOType,
        "Priority": priority,
        "WO Description": woDescription,
        "Branch": branch,
        "WO Status": woStatus,
        "Customer Number": customerNumber,
        "Originator Number": originatorNumber,
        "Assigned To": assignedTo,
        "Request Date": requestDate,
        "Asset Number": assetNumber,
        "Eqp Description": eqpDescription,
      };
}
