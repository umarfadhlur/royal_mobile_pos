// To parse this JSON data, do
//
//     final createSoResponseModel = createSoResponseModelFromJson(jsonString);

import 'dart:convert';

CreateSoResponseModel createSoResponseModelFromJson(String str) => CreateSoResponseModel.fromJson(json.decode(str));

String createSoResponseModelToJson(CreateSoResponseModel data) => json.encode(data.toJson());

class CreateSoResponseModel {
    final int previousOrder;

    CreateSoResponseModel({
        this.previousOrder,
    });

    factory CreateSoResponseModel.fromJson(Map<String, dynamic> json) => CreateSoResponseModel(
        previousOrder: json["Previous Order"],
    );

    Map<String, dynamic> toJson() => {
        "Previous Order": previousOrder,
    };
}
