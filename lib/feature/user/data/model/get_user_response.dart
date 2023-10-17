// To parse this JSON data, do
//
//     final getUserResponse = getUserResponseFromJson(jsonString);

import 'dart:convert';

List<GetUserResponse> getUserResponseFromJson(String str) => List<GetUserResponse>.from(json.decode(str).map((x) => GetUserResponse.fromJson(x)));

String getUserResponseToJson(List<GetUserResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUserResponse {
    final String userId;
    final String name;
    final String branchPlant;
    final String shopId;

    GetUserResponse({
        this.userId,
        this.name,
        this.branchPlant,
        this.shopId,
    });

    factory GetUserResponse.fromJson(Map<String, dynamic> json) => GetUserResponse(
        userId: json["userId"],
        name: json["name"],
        branchPlant: json["branchPlant"],
        shopId: json["shopId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "branchPlant": branchPlant,
        "shopId": shopId,
    };
}
