// To parse this JSON data, do
//
//     final findCustomerResponseModel = findCustomerResponseModelFromJson(jsonString);

import 'dart:convert';

FindCustomerResponseModel findCustomerResponseModelFromJson(String str) =>
    FindCustomerResponseModel.fromJson(json.decode(str));

String findCustomerResponseModelToJson(FindCustomerResponseModel data) =>
    json.encode(data.toJson());

class FindCustomerResponseModel {
  FindCustomerResponseModel({
    this.rudFindcustomerF03012Dr1,
  });

  final RudFindcustomerF03012Dr1 rudFindcustomerF03012Dr1;

  factory FindCustomerResponseModel.fromJson(Map<String, dynamic> json) =>
      FindCustomerResponseModel(
        rudFindcustomerF03012Dr1: RudFindcustomerF03012Dr1.fromJson(
            json["RUD_FINDCUSTOMER_F03012_DR1"]),
      );

  Map<String, dynamic> toJson() => {
        "RUD_FINDCUSTOMER_F03012_DR1": rudFindcustomerF03012Dr1.toJson(),
      };
}

class RudFindcustomerF03012Dr1 {
  RudFindcustomerF03012Dr1({
    this.tableId,
    this.rowset,
    this.records,
    this.moreRecords,
  });

  final String tableId;
  final List<Customer> rowset;
  final int records;
  final bool moreRecords;

  factory RudFindcustomerF03012Dr1.fromJson(Map<String, dynamic> json) =>
      RudFindcustomerF03012Dr1(
        tableId: json["tableId"],
        rowset: List<Customer>.from(
            json["rowset"].map((x) => Customer.fromJson(x))),
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

class Customer {
  Customer({
    this.countCustomer,
  });

  final int countCustomer;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        countCustomer: json["Count Customer"],
      );

  Map<String, dynamic> toJson() => {
        "Count Customer": countCustomer,
      };
}
