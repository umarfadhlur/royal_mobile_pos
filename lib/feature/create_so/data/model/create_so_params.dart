// To parse this JSON data, do
//
//     final createSoParamModel = createSoParamModelFromJson(jsonString);

import 'dart:convert';

CreateSoParamModel createSoParamModelFromJson(String str) => CreateSoParamModel.fromJson(json.decode(str));

String createSoParamModelToJson(CreateSoParamModel data) => json.encode(data.toJson());

class CreateSoParamModel {
    final String username;
    final String password;
    final String branchPlant;
    final String customer;
    final String customerPo;
    final List<GridIn13> gridIn13;
    final String transactionOriginator;

    CreateSoParamModel({
        this.username,
        this.password,
        this.branchPlant,
        this.customer,
        this.customerPo,
        this.gridIn13,
        this.transactionOriginator,
    });

    factory CreateSoParamModel.fromJson(Map<String, dynamic> json) => CreateSoParamModel(
        username: json["username"],
        password: json["password"],
        branchPlant: json["Branch_Plant"],
        customer: json["Customer"],
        customerPo: json["Customer_PO"],
        gridIn13: List<GridIn13>.from(json["GridIn_1_3"].map((x) => GridIn13.fromJson(x))),
        transactionOriginator: json["TransactionOriginator"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "Branch_Plant": branchPlant,
        "Customer": customer,
        "Customer_PO": customerPo,
        "GridIn_1_3": List<dynamic>.from(gridIn13.map((x) => x.toJson())),
        "TransactionOriginator": transactionOriginator,
    };
}

class GridIn13 {
    final String quantityOrdered;
    final String itemNumber;

    GridIn13({
        this.quantityOrdered,
        this.itemNumber,
    });

    factory GridIn13.fromJson(Map<String, dynamic> json) => GridIn13(
        quantityOrdered: json["Quantity_Ordered"],
        itemNumber: json["Item_Number"],
    );

    Map<String, dynamic> toJson() => {
        "Quantity_Ordered": quantityOrdered,
        "Item_Number": itemNumber,
    };
}
