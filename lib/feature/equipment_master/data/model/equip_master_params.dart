// To parse this JSON data, do
//
//     final equipMasterParamModel = equipMasterParamModelFromJson(jsonString);

import 'dart:convert';

EquipMasterParamModel equipMasterParamModelFromJson(String str) =>
    EquipMasterParamModel.fromJson(json.decode(str));

String equipMasterParamModelToJson(EquipMasterParamModel data) =>
    json.encode(data.toJson());

class EquipMasterParamModel {
  EquipMasterParamModel({
    this.token,
    this.inputs,
  });

  final String token;
  final List<Input> inputs;

  factory EquipMasterParamModel.fromJson(Map<String, dynamic> json) =>
      EquipMasterParamModel(
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

  final String name;
  final String value;

  factory Input.fromJson(Map<String, dynamic> json) => Input(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
