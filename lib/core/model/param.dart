// To parse this JSON data, do
//
//     final paramTokenMdl = paramTokenMdlFromJson(jsonString);

import 'dart:convert';

ParamTokenMdl paramTokenMdlFromJson(String str) => ParamTokenMdl.fromJson(json.decode(str));

String paramTokenMdlToJson(ParamTokenMdl data) => json.encode(data.toJson());

class ParamTokenMdl {
  ParamTokenMdl({
    this.token,
  });

  String token;

  factory ParamTokenMdl.fromJson(Map<String, dynamic> json) => ParamTokenMdl(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}
