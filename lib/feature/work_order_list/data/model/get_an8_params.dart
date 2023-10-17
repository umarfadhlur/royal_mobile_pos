// To parse this JSON data, do
//
//     final getAn8Params = getAn8ParamsFromJson(jsonString);

import 'dart:convert';

GetAn8Params getAn8ParamsFromJson(String str) =>
    GetAn8Params.fromJson(json.decode(str));

String getAn8ParamsToJson(GetAn8Params data) => json.encode(data.toJson());

class GetAn8Params {
  GetAn8Params({
    this.token,
    this.inputs,
  });

  final String token;
  final List<Input> inputs;

  factory GetAn8Params.fromJson(Map<String, dynamic> json) => GetAn8Params(
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
