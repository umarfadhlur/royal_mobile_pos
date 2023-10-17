// To parse this JSON data, do
//
//     final paramsUpdateEquipment = paramsUpdateEquipmentFromJson(jsonString);

import 'dart:convert';

ParamsUpdateEquipment paramsUpdateEquipmentFromJson(String str) => ParamsUpdateEquipment.fromJson(json.decode(str));

String paramsUpdateEquipmentToJson(ParamsUpdateEquipment data) => json.encode(data.toJson());

class ParamsUpdateEquipment {
    ParamsUpdateEquipment({
        this.token,
        this.inputs,
    });

    String token;
    List<Input> inputs;

    factory ParamsUpdateEquipment.fromJson(Map<String, dynamic> json) => ParamsUpdateEquipment(
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
