// To parse this JSON data, do
//
//     final WorkOrderParamModel = workOrderParamModelFromJson(jsonString);

import 'dart:convert';

WorkOrderParamModel workOrderParamModelFromJson(String str) =>
    WorkOrderParamModel.fromJson(json.decode(str));

String workOrderParamModelToJson(WorkOrderParamModel data) =>
    json.encode(data.toJson());

class WorkOrderParamModel {
  WorkOrderParamModel({
    this.token,
    this.inputs,
  });

  String token;
  List<Input> inputs;

  factory WorkOrderParamModel.fromJson(Map<String, dynamic> json) =>
      WorkOrderParamModel(
        token: json["token"],
        inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "inputs": List<dynamic>.from(inputs.map((x) => x.toJson())),
      };
}

class Input {
  Input({
    this.name,
    this.value,
  });

  String name;
  String value;

  factory Input.fromJson(Map<String, dynamic> json) => Input(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
