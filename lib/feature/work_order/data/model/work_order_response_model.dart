// To parse this JSON data, do
//
//     final workOrderResponseModel = workOrderResponseModelFromJson(jsonString);

import 'dart:convert';

WorkOrderResponseModel workOrderResponseModelFromJson(String str) =>
    WorkOrderResponseModel.fromJson(json.decode(str));

String workOrderResponseModelToJson(WorkOrderResponseModel data) =>
    json.encode(data.toJson());

class WorkOrderResponseModel {
  WorkOrderResponseModel({
    this.woCreated,
  });

  final int woCreated;

  factory WorkOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      WorkOrderResponseModel(
        woCreated: json["WO Created"],
      );

  Map<String, dynamic> toJson() => {
        "WO Created": woCreated,
      };
}
