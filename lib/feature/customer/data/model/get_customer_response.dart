// To parse this JSON data, do
//
//     final getCustomerResponse = getCustomerResponseFromJson(jsonString);

import 'dart:convert';

List<GetCustomerResponse> getCustomerResponseFromJson(String str) => List<GetCustomerResponse>.from(json.decode(str).map((x) => GetCustomerResponse.fromJson(x)));

String getCustomerResponseToJson(List<GetCustomerResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetCustomerResponse {
    final String nama;
    final String alamat;
    final String noHp;
    final String idNumber;

    GetCustomerResponse({
        this.nama,
        this.alamat,
        this.noHp,
        this.idNumber,
    });

    factory GetCustomerResponse.fromJson(Map<String, dynamic> json) => GetCustomerResponse(
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
