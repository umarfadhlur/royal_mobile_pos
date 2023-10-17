// To parse this JSON data, do
//
//     final getAn8Response = getAn8ResponseFromJson(jsonString);

import 'dart:convert';

GetAn8Response getAn8ResponseFromJson(String str) =>
    GetAn8Response.fromJson(json.decode(str));

String getAn8ResponseToJson(GetAn8Response data) => json.encode(data.toJson());

class GetAn8Response {
  GetAn8Response({
    this.rudGetan8P0092Dr,
  });

  final RudGetan8P0092Dr rudGetan8P0092Dr;

  factory GetAn8Response.fromJson(Map<String, dynamic> json) => GetAn8Response(
        rudGetan8P0092Dr:
            RudGetan8P0092Dr.fromJson(json["RUD_GETAN8_P0092_DR"]),
      );

  Map<String, dynamic> toJson() => {
        "RUD_GETAN8_P0092_DR": rudGetan8P0092Dr.toJson(),
      };
}

class RudGetan8P0092Dr {
  RudGetan8P0092Dr({
    this.tableId,
    this.rowset,
    this.records,
    this.moreRecords,
  });

  final String tableId;
  final List<Rowset> rowset;
  final int records;
  final bool moreRecords;

  factory RudGetan8P0092Dr.fromJson(Map<String, dynamic> json) =>
      RudGetan8P0092Dr(
        tableId: json["tableId"],
        rowset:
            List<Rowset>.from(json["rowset"].map((x) => Rowset.fromJson(x))),
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
    this.addressNumber,
  });

  final String addressNumber;

  factory Rowset.fromJson(Map<String, dynamic> json) => Rowset(
        addressNumber: json["Address Number"],
      );

  Map<String, dynamic> toJson() => {
        "Address Number": addressNumber,
      };
}
