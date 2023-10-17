// To parse this JSON data, do
//
//     final paramListDataUp = paramListDataUpFromJson(jsonString);

import 'dart:convert';

ParamListDataUp paramListDataUpFromJson(String str) =>
    ParamListDataUp.fromJson(json.decode(str));

String paramListDataUpToJson(ParamListDataUp data) =>
    json.encode(data.toJson());

class ParamListDataUp {
  ParamListDataUp({
    this.username,
    this.password,
    this.inputs,
  });

  final String username;
  final String password;
  final List<Input> inputs;

  factory ParamListDataUp.fromJson(Map<String, dynamic> json) =>
      ParamListDataUp(
        username: json["username"],
        password: json["password"],
        inputs: List<Input>.from(json["inputs"].map((x) => Input.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
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
