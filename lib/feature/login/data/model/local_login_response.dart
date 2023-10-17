// To parse this JSON data, do
//
//     final localLoginResponse = localLoginResponseFromJson(jsonString);

import 'dart:convert';

LocalLoginResponse localLoginResponseFromJson(String str) => LocalLoginResponse.fromJson(json.decode(str));

String localLoginResponseToJson(LocalLoginResponse data) => json.encode(data.toJson());

class LocalLoginResponse {
    bool success;
    String message;
    String userId;
    String name;
    String branchPlant;
    String shopId;

    LocalLoginResponse({
        this.success,
        this.message,
        this.userId,
        this.name,
        this.branchPlant,
        this.shopId,
    });

    factory LocalLoginResponse.fromJson(Map<String, dynamic> json) => LocalLoginResponse(
        success: json["success"],
        message: json["message"],
        userId: json["userID"],
        name: json["name"],
        branchPlant: json["branchPlant"],
        shopId: json["shopID"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "userID": userId,
        "name": name,
        "branchPlant": branchPlant,
        "shopID": shopId,
    };
}
