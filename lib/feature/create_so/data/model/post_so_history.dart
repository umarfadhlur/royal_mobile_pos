// To parse this JSON data, do
//
//     final postSoHistory = postSoHistoryFromJson(jsonString);

import 'dart:convert';

List<PostSoHistory> postSoHistoryFromJson(String str) => List<PostSoHistory>.from(json.decode(str).map((x) => PostSoHistory.fromJson(x)));

String postSoHistoryToJson(List<PostSoHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostSoHistory {
    String doco;
    String mcu;
    String an8;
    String vr01;
    DateTime soDate;

    PostSoHistory({
        this.doco,
        this.mcu,
        this.an8,
        this.vr01,
        this.soDate,
    });

    factory PostSoHistory.fromJson(Map<String, dynamic> json) => PostSoHistory(
        doco: json["doco"],
        mcu: json["mcu"],
        an8: json["an8"],
        vr01: json["vr01"],
        soDate: DateTime.parse(json["so_date"]),
    );

    Map<String, dynamic> toJson() => {
        "doco": doco,
        "mcu": mcu,
        "an8": an8,
        "vr01": vr01,
        "so_date": "${soDate.year.toString().padLeft(4, '0')}-${soDate.month.toString().padLeft(2, '0')}-${soDate.day.toString().padLeft(2, '0')}",
    };
}
