// To parse this JSON data, do
//
//     final responseFindEquipment = responseFindEquipmentFromJson(jsonString);

import 'dart:convert';

ResponseFindEquipment responseFindEquipmentFromJson(String str) => ResponseFindEquipment.fromJson(json.decode(str));

String responseFindEquipmentToJson(ResponseFindEquipment data) => json.encode(data.toJson());

class ResponseFindEquipment {
    ResponseFindEquipment({
        this.rudFindeqpF1201Dr1,
    });

    RudFindeqpF1201Dr1 rudFindeqpF1201Dr1;

    factory ResponseFindEquipment.fromJson(Map<String, dynamic> json) => ResponseFindEquipment(
        rudFindeqpF1201Dr1: RudFindeqpF1201Dr1.fromJson(json["RUD_FINDEQP_F1201_DR1"]),
    );

    Map<String, dynamic> toJson() => {
        "RUD_FINDEQP_F1201_DR1": rudFindeqpF1201Dr1.toJson(),
    };
}

class RudFindeqpF1201Dr1 {
    RudFindeqpF1201Dr1({
        this.tableId,
        this.rowset,
        this.records,
        this.moreRecords,
    });

    String tableId;
    List<Rowset> rowset;
    int records;
    bool moreRecords;

    factory RudFindeqpF1201Dr1.fromJson(Map<String, dynamic> json) => RudFindeqpF1201Dr1(
        tableId: json["tableId"],
        rowset: List<Rowset>.from(json["rowset"].map((x) => Rowset.fromJson(x))),
        records: json["records"],
        moreRecords: json["moreRecords"],
    );

    Map<String, dynamic> toJson() => {
        "tableId": tableId,
        "rowset": List<dynamic>.from(rowset.map((x) => x.toJson())),
        "records": records,
        "moreRecords": moreRecords,
    };
}

class Rowset {
    Rowset({
        this.countEquipment,
    });

    int countEquipment;

    factory Rowset.fromJson(Map<String, dynamic> json) => Rowset(
        countEquipment: json["Count Equipment"],
    );

    Map<String, dynamic> toJson() => {
        "Count Equipment": countEquipment,
    };
}
