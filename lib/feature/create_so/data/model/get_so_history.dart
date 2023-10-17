import 'dart:convert';

List<GetSoHistory> getSoHistoryFromJson(String str) => List<GetSoHistory>.from(json.decode(str).map((x) => GetSoHistory.fromJson(x)));

String getSoHistoryToJson(List<GetSoHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSoHistory {
    String id;
    String doco;
    String mcu;
    String an8;
    String vr01;
    DateTime soDate;

    GetSoHistory({
        this.id,
        this.doco,
        this.mcu,
        this.an8,
        this.vr01,
        this.soDate,
    });

    factory GetSoHistory.fromJson(Map<String, dynamic> json) => GetSoHistory(
        id: json["id"],
        doco: json["DOCO"],
        mcu: json["MCU"],
        an8: json["AN8"],
        vr01: json["VR01"],
        soDate: DateTime.parse(json["so_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "DOCO": doco,
        "MCU": mcu,
        "AN8": an8,
        "VR01": vr01,
        "so_date": "${soDate.year.toString().padLeft(4, '0')}-${soDate.month.toString().padLeft(2, '0')}-${soDate.day.toString().padLeft(2, '0')}",
    };
}