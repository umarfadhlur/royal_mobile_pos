// To parse this JSON data, do
//
//     final getPriceParamModel = getPriceParamModelFromJson(jsonString);

import 'dart:convert';

GetPriceParamModel getPriceParamModelFromJson(String str) => GetPriceParamModel.fromJson(json.decode(str));

String getPriceParamModelToJson(GetPriceParamModel data) => json.encode(data.toJson());

class GetPriceParamModel {
    String token;
    String username;
    String password;
    String businessUnit;
    String itemNumber;
    String addressNumber;

    GetPriceParamModel({
        this.token,
        this.username,
        this.password,
        this.businessUnit,
        this.itemNumber,
        this.addressNumber,
    });

    factory GetPriceParamModel.fromJson(Map<String, dynamic> json) => GetPriceParamModel(
        token: json["token"],
        username: json["username"],
        password: json["password"],
        businessUnit: json["Business_Unit"],
        itemNumber: json["Item_Number"],
        addressNumber: json["Address_Number"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "username": username,
        "password": password,
        "Business_Unit": businessUnit,
        "Item_Number": itemNumber,
        "Address_Number": addressNumber,
    };
}
