// To parse this JSON data, do
//
//     final bomParams = bomParamsFromJson(jsonString);

import 'dart:convert';

BomParams bomParamsFromJson(String str) => BomParams.fromJson(json.decode(str));

String bomParamsToJson(BomParams data) => json.encode(data.toJson());

class BomParams {
    final String username;
    final String password;
    final String the2NdItemNumber1;
    final String branch1;
    final String typBom1;

    BomParams({
        this.username,
        this.password,
        this.the2NdItemNumber1,
        this.branch1,
        this.typBom1,
    });

    factory BomParams.fromJson(Map<String, dynamic> json) => BomParams(
        username: json["username"],
        password: json["password"],
        the2NdItemNumber1: json["2nd Item Number 1"],
        branch1: json["Branch 1"],
        typBom1: json["Typ BOM 1"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "2nd Item Number 1": the2NdItemNumber1,
        "Branch 1": branch1,
        "Typ BOM 1": typBom1,
    };
}
