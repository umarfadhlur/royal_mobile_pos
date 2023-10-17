// To parse this JSON data, do
//
//     final postSoHistoryNew = postSoHistoryNewFromJson(jsonString);

import 'dart:convert';

PostSoHistoryNew postSoHistoryNewFromJson(String str) => PostSoHistoryNew.fromJson(json.decode(str));

String postSoHistoryNewToJson(PostSoHistoryNew data) => json.encode(data.toJson());

class PostSoHistoryNew {
    String doco;
    String mcu;
    String an8;
    String vr01;
    DateTime soDate;
    List<Detail> details;

    PostSoHistoryNew({
        this.doco,
        this.mcu,
        this.an8,
        this.vr01,
        this.soDate,
        this.details,
    });

    factory PostSoHistoryNew.fromJson(Map<String, dynamic> json) => PostSoHistoryNew(
        doco: json["doco"],
        mcu: json["mcu"],
        an8: json["an8"],
        vr01: json["vr01"],
        soDate: DateTime.parse(json["so_date"]),
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "doco": doco,
        "mcu": mcu,
        "an8": an8,
        "vr01": vr01,
        "so_date": "${soDate.year.toString().padLeft(4, '0')}-${soDate.month.toString().padLeft(2, '0')}-${soDate.day.toString().padLeft(2, '0')}",
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
    };
}

class Detail {
    String litm;
    String uprc;
    String qty;
    String priceHistory;

    Detail({
        this.litm,
        this.uprc,
        this.qty,
        this.priceHistory,
    });

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
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
