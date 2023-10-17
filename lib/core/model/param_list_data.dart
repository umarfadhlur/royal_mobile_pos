// To parse this JSON data, do
//
//     final paramListData = paramListDataFromJson(jsonString);

import 'dart:convert';

ParamListData paramListDataFromJson(String str) => ParamListData.fromJson(json.decode(str));

String paramListDataToJson(ParamListData data) => json.encode(data.toJson());

class ParamListData {
  ParamListData({
    this.token,
    this.inputs,
  });

  String token;
  List<Input> inputs;

  factory ParamListData.fromJson(Map<String, dynamic> json) => ParamListData(
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
