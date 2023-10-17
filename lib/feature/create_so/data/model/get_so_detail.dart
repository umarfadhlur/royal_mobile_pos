// To parse this JSON data, do
//
//     final getSoDetail = getSoDetailFromJson(jsonString);

import 'dart:convert';

List<GetSoDetail> getSoDetailFromJson(String str) => List<GetSoDetail>.from(json.decode(str).map((x) => GetSoDetail.fromJson(x)));

String getSoDetailToJson(List<GetSoDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSoDetail {
    String litm;
    String uprc;
    int qty;
    String priceHistory;

    GetSoDetail({
        this.litm,
        this.uprc,
        this.qty,
        this.priceHistory,
    });

    factory GetSoDetail.fromJson(Map<String, dynamic> json) => GetSoDetail(
        litm: json["litm"],
        uprc: json["uprc"],
        qty: json["qty"],
        priceHistory: json["price_history"],
    );

    Map<String, dynamic> toJson() => {
        "litm": litm,
        "uprc": uprc,
        "qty": qty,
        "price_history": priceHistory,
    };
}
