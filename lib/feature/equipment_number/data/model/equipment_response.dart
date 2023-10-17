// To parse this JSON data, do
//
//     final responseEquipment = responseEquipmentFromJson(jsonString);

import 'dart:convert';

ResponseEquipment responseEquipmentFromJson(String str) => ResponseEquipment.fromJson(json.decode(str));

String responseEquipmentToJson(ResponseEquipment data) => json.encode(data.toJson());

class ResponseEquipment {
    ResponseEquipment({
        this.latitude,
        this.longitude,
    });

    String latitude;
    String longitude;

    factory ResponseEquipment.fromJson(Map<String, dynamic> json) => ResponseEquipment(
        latitude: json["Latitude"],
        longitude: json["Longitude"],
    );

    Map<String, dynamic> toJson() => {
        "Latitude": latitude,
        "Longitude": longitude,
    };
}
