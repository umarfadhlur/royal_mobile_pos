// To parse this JSON data, do
//
//     final getPriceResponseModel = getPriceResponseModelFromJson(jsonString);

import 'dart:convert';

GetPriceResponseModel getPriceResponseModelFromJson(String str) => GetPriceResponseModel.fromJson(json.decode(str));

String getPriceResponseModelToJson(GetPriceResponseModel data) => json.encode(data.toJson());

class GetPriceResponseModel {
    String businessUnit;
    String itemNumber;
    String addressNumber;
    int unitPrice;
    RudGetpriceP4074Fr1 rudGetpriceP4074Fr1;

    GetPriceResponseModel({
        this.businessUnit,
        this.itemNumber,
        this.addressNumber,
        this.unitPrice,
        this.rudGetpriceP4074Fr1,
    });

    factory GetPriceResponseModel.fromJson(Map<String, dynamic> json) => GetPriceResponseModel(
        businessUnit: json["Business_Unit"],
        itemNumber: json["Item_Number"],
        addressNumber: json["Address_Number"],
        unitPrice: json["Unit Price"],
        rudGetpriceP4074Fr1: RudGetpriceP4074Fr1.fromJson(json["RUD_GETPRICE_P4074_FR_1"]),
    );

    Map<String, dynamic> toJson() => {
        "Business_Unit": businessUnit,
        "Item_Number": itemNumber,
        "Address_Number": addressNumber,
        "Unit Price": unitPrice,
        "RUD_GETPRICE_P4074_FR_1": rudGetpriceP4074Fr1.toJson(),
    };
}

class RudGetpriceP4074Fr1 {
    String formId;
    String gridId;
    String title;
    List<PriceList> rowset;
    int records;
    bool moreRecords;

    RudGetpriceP4074Fr1({
        this.formId,
        this.gridId,
        this.title,
        this.rowset,
        this.records,
        this.moreRecords,
    });

    factory RudGetpriceP4074Fr1.fromJson(Map<String, dynamic> json) => RudGetpriceP4074Fr1(
        formId: json["formId"],
        gridId: json["gridId"],
        title: json["title"],
        rowset: List<PriceList>.from(json["rowset"].map((x) => PriceList.fromJson(x))),
        records: json["records"],
        moreRecords: json["moreRecords"],
    );

    Map<String, dynamic> toJson() => {
        "formId": formId,
        "gridId": gridId,
        "title": title,
        "rowset": List<dynamic>.from(rowset.map((x) => x.toJson())),
        "records": records,
        "moreRecords": moreRecords,
    };
}

class PriceList {
    String adjName;
    String descAdjName;
    int seqNo;
    int factorValueNumeric;
    int unitPrice;
    String bC;
    String adjSchedule;
    String adjustQtyToPay;
    String adjustmentCalculation;
    int basedOnValue;
    String chargeReference;
    String costMeth;
    String descBc;
    String descCostMethod;
    String descReasonCode;
    String exclusiveGroup;
    String factorValueUm;
    String flatRate;
    int foreignUnitPrice;
    String mC;
    String minMaxAdj;
    String minMaxAdjDesc;
    String mutuallyExclusive;
    String newBasePriceFlag;
    String oP;
    String promotionId;
    String promotionIdDescription;
    String reasonCode;
    int quantityToPay;

    PriceList({
        this.adjName,
        this.descAdjName,
        this.seqNo,
        this.factorValueNumeric,
        this.unitPrice,
        this.bC,
        this.adjSchedule,
        this.adjustQtyToPay,
        this.adjustmentCalculation,
        this.basedOnValue,
        this.chargeReference,
        this.costMeth,
        this.descBc,
        this.descCostMethod,
        this.descReasonCode,
        this.exclusiveGroup,
        this.factorValueUm,
        this.flatRate,
        this.foreignUnitPrice,
        this.mC,
        this.minMaxAdj,
        this.minMaxAdjDesc,
        this.mutuallyExclusive,
        this.newBasePriceFlag,
        this.oP,
        this.promotionId,
        this.promotionIdDescription,
        this.reasonCode,
        this.quantityToPay,
    });

    factory PriceList.fromJson(Map<String, dynamic> json) => PriceList(
        adjName: json["Adj Name"],
        descAdjName: json["Desc Adj Name"],
        seqNo: json["Seq No."],
        factorValueNumeric: json["Factor Value Numeric"],
        unitPrice: json["Unit Price"],
        bC: json["B C"],
        adjSchedule: json["Adj. Schedule"],
        adjustQtyToPay: json["Adjust Qty To Pay"],
        adjustmentCalculation: json["Adjustment Calculation"],
        basedOnValue: json["Based on Value"],
        chargeReference: json["Charge Reference"],
        costMeth: json["Cost Meth"],
        descBc: json["Desc BC"],
        descCostMethod: json["Desc Cost Method"],
        descReasonCode: json["Desc Reason Code"],
        exclusiveGroup: json["Exclusive Group"],
        factorValueUm: json["Factor Value UM"],
        flatRate: json["Flat Rate"],
        foreignUnitPrice: json["Foreign Unit Price"],
        mC: json["M C"],
        minMaxAdj: json["Min/Max Adj"],
        minMaxAdjDesc: json["Min/Max Adj Desc"],
        mutuallyExclusive: json["Mutually Exclusive"],
        newBasePriceFlag: json["New Base Price Flag"],
        oP: json["O P"],
        promotionId: json["Promotion ID"],
        promotionIdDescription: json["Promotion ID Description"],
        reasonCode: json["Reason Code"],
        quantityToPay: json["Quantity To Pay"],
    );

    Map<String, dynamic> toJson() => {
        "Adj Name": adjName,
        "Desc Adj Name": descAdjName,
        "Seq No.": seqNo,
        "Factor Value Numeric": factorValueNumeric,
        "Unit Price": unitPrice,
        "B C": bC,
        "Adj. Schedule": adjSchedule,
        "Adjust Qty To Pay": adjustQtyToPay,
        "Adjustment Calculation": adjustmentCalculation,
        "Based on Value": basedOnValue,
        "Charge Reference": chargeReference,
        "Cost Meth": costMeth,
        "Desc BC": descBc,
        "Desc Cost Method": descCostMethod,
        "Desc Reason Code": descReasonCode,
        "Exclusive Group": exclusiveGroup,
        "Factor Value UM": factorValueUm,
        "Flat Rate": flatRate,
        "Foreign Unit Price": foreignUnitPrice,
        "M C": mC,
        "Min/Max Adj": minMaxAdj,
        "Min/Max Adj Desc": minMaxAdjDesc,
        "Mutually Exclusive": mutuallyExclusive,
        "New Base Price Flag": newBasePriceFlag,
        "O P": oP,
        "Promotion ID": promotionId,
        "Promotion ID Description": promotionIdDescription,
        "Reason Code": reasonCode,
        "Quantity To Pay": quantityToPay,
    };
}
