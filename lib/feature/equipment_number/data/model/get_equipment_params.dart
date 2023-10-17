// To parse this JSON data, do
//
//     final paramsGetEquipment = paramsGetEquipmentFromJson(jsonString);

import 'dart:convert';

ParamsGetEquipment paramsGetEquipmentFromJson(String str) => ParamsGetEquipment.fromJson(json.decode(str));

String paramsGetEquipmentToJson(ParamsGetEquipment data) => json.encode(data.toJson());

class ParamsGetEquipment {
    ParamsGetEquipment({
        this.token,
        this.inputs,
    });

    String token;
    List<Input> inputs;

    factory ParamsGetEquipment.fromJson(Map<String, dynamic> json) => ParamsGetEquipment(
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
