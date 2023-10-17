// To parse this JSON data, do
//
//     final addUserParams = addUserParamsFromJson(jsonString);

import 'dart:convert';

AddUserParams addUserParamsFromJson(String str) => AddUserParams.fromJson(json.decode(str));

String addUserParamsToJson(AddUserParams data) => json.encode(data.toJson());

class AddUserParams {
    final String userId;
    final String password;
    final String name;
    final String branchPlant;
    final String shopId;

    AddUserParams({
        this.userId,
        this.password,
        this.name,
        this.branchPlant,
        this.shopId,
    });

    factory AddUserParams.fromJson(Map<String, dynamic> json) => AddUserParams(
        userId: json["userId"],
        password: json["password"],
        name: json["name"],
        branchPlant: json["branchPlant"],
        shopId: json["shopId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "password": password,
        "name": name,
        "branchPlant": branchPlant,
        "shopId": shopId,
    };
}
