// To parse this JSON data, do
//
//     final workOrderListParams = workOrderListParamsFromJson(jsonString);

import 'dart:convert';

WorkOrderListParams workOrderListParamsFromJson(String str) =>
    WorkOrderListParams.fromJson(json.decode(str));

String workOrderListParamsToJson(WorkOrderListParams data) =>
    json.encode(data.toJson());

class WorkOrderListParams {
  WorkOrderListParams({
    this.token,
    this.inputs,
  });

  final String token;
  final List<InputList> inputs;

  factory WorkOrderListParams.fromJson(Map<String, dynamic> json) =>
      WorkOrderListParams(
        token: json["token"],
        inputs: List<InputList>.from(
            json["inputs"].map((x) => InputList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "inputs": List<dynamic>.from(inputs.map((x) => x.toJson())),
      };
}

class InputList {
  InputList({
    this.name,
    this.value,
  });

  final String name;
  final String value;

  factory InputList.fromJson(Map<String, dynamic> json) => InputList(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
