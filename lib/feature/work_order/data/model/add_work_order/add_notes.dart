// To parse this JSON data, do
//
//     final addNotes = addNotesFromJson(jsonString);

import 'dart:convert';

AddNotes addNotesFromJson(String str) => AddNotes.fromJson(json.decode(str));

String addNotesToJson(AddNotes data) => json.encode(data.toJson());

class AddNotes {
  AddNotes({
    this.connectorRequest1,
  });

  final ConnectorRequest1 connectorRequest1;

  factory AddNotes.fromJson(Map<String, dynamic> json) => AddNotes(
        connectorRequest1:
            ConnectorRequest1.fromJson(json["ConnectorRequest1"]),
      );

  Map<String, dynamic> toJson() => {
        "ConnectorRequest1": connectorRequest1.toJson(),
      };
}

class ConnectorRequest1 {
  ConnectorRequest1({
    this.addTextStatus,
    this.sequence,
  });

  final String addTextStatus;
  final int sequence;

  factory ConnectorRequest1.fromJson(Map<String, dynamic> json) =>
      ConnectorRequest1(
        addTextStatus: json["addTextStatus"],
        sequence: json["sequence"],
      );

  Map<String, dynamic> toJson() => {
        "addTextStatus": addTextStatus,
        "sequence": sequence,
      };
}
