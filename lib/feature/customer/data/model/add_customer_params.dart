// To parse this JSON data, do
//
//     final addCustomerParams = addCustomerParamsFromJson(jsonString);

import 'dart:convert';

AddCustomerParams addCustomerParamsFromJson(String str) => AddCustomerParams.fromJson(json.decode(str));

String addCustomerParamsToJson(AddCustomerParams data) => json.encode(data.toJson());

class AddCustomerParams {
    final String nama;
    final String alamat;
    final String noHp;
    final String idNumber;

    AddCustomerParams({
        this.nama,
        this.alamat,
        this.noHp,
        this.idNumber,
    });

    factory AddCustomerParams.fromJson(Map<String, dynamic> json) => AddCustomerParams(
        nama: json["nama"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        idNumber: json["id_number"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "alamat": alamat,
        "no_hp": noHp,
        "id_number": idNumber,
    };
}
