// To parse this JSON data, do
//
//     final itemBranchParams = itemBranchParamsFromJson(jsonString);

import 'dart:convert';

ItemBranchParams itemBranchParamsFromJson(String str) => ItemBranchParams.fromJson(json.decode(str));

String itemBranchParamsToJson(ItemBranchParams data) => json.encode(data.toJson());

class ItemBranchParams {
    final String username;
    final String password;
    final String the2NdItemNumber1;
    final String businessUnit1;

    ItemBranchParams({
        this.username,
        this.password,
        this.the2NdItemNumber1,
        this.businessUnit1,
    });

    factory ItemBranchParams.fromJson(Map<String, dynamic> json) => ItemBranchParams(
        username: json["username"],
        password: json["password"],
        the2NdItemNumber1: json["2nd Item Number 1"],
        businessUnit1: json["Business Unit 1"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "2nd Item Number 1": the2NdItemNumber1,
        "Business Unit 1": businessUnit1,
    };
}
