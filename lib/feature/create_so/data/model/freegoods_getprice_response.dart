// To parse this JSON data, do
//
//     final freeGoodsGetPriceResponse = freeGoodsGetPriceResponseFromJson(jsonString);

import 'dart:convert';

FreeGoodsGetPriceResponse freeGoodsGetPriceResponseFromJson(String str) => FreeGoodsGetPriceResponse.fromJson(json.decode(str));

String freeGoodsGetPriceResponseToJson(FreeGoodsGetPriceResponse data) => json.encode(data.toJson());

class FreeGoodsGetPriceResponse {
    int mnNextNumber001;
    ArdP55Cpm42RawSo1 ardP55Cpm42RawSo1;
    String reportName;
    String reportVersion;
    int jobNumber;
    String executionServer;
    int port;
    String jobStatus;
    String objectType;
    String user;
    String environment;
    DateTime submitDate;
    DateTime lastDate;
    int submitTime;
    int lastTime;
    String oid;
    String queue;
    ArdF56Cpfre ardF56Cpfre;
    ArdF56Cpsim ardF56Cpsim;
    int unitPrice;
    RudGetpriceP4074Fr1 rudGetpriceP4074Fr1;
    String jdeStatus;
    String jdeStartTimestamp;
    String jdeEndTimestamp;
    double jdeServerExecutionSeconds;

    FreeGoodsGetPriceResponse({
        this.mnNextNumber001,
        this.ardP55Cpm42RawSo1,
        this.reportName,
        this.reportVersion,
        this.jobNumber,
        this.executionServer,
        this.port,
        this.jobStatus,
        this.objectType,
        this.user,
        this.environment,
        this.submitDate,
        this.lastDate,
        this.submitTime,
        this.lastTime,
        this.oid,
        this.queue,
        this.ardF56Cpfre,
        this.ardF56Cpsim,
        this.unitPrice,
        this.rudGetpriceP4074Fr1,
        this.jdeStatus,
        this.jdeStartTimestamp,
        this.jdeEndTimestamp,
        this.jdeServerExecutionSeconds,
    });

    factory FreeGoodsGetPriceResponse.fromJson(Map<String, dynamic> json) => FreeGoodsGetPriceResponse(
        mnNextNumber001: json["mnNextNumber001"],
        ardP55Cpm42RawSo1: ArdP55Cpm42RawSo1.fromJson(json["ARD_P55CPM42_RawSO_1"]),
        reportName: json["Report Name"],
        reportVersion: json["Report Version"],
        jobNumber: json["Job Number"],
        executionServer: json["Execution Server"],
        port: json["Port"],
        jobStatus: json["Job Status"],
        objectType: json["Object Type"],
        user: json["User"],
        environment: json["Environment"],
        submitDate: DateTime.parse(json["Submit Date"]),
        lastDate: DateTime.parse(json["Last Date"]),
        submitTime: json["Submit Time"],
        lastTime: json["Last Time"],
        oid: json["OID"],
        queue: json["Queue"],
        ardF56Cpfre: ArdF56Cpfre.fromJson(json["ARD_F56CPFRE"]),
        ardF56Cpsim: ArdF56Cpsim.fromJson(json["ARD_F56CPSIM"]),
        unitPrice: json["Unit Price"],
        rudGetpriceP4074Fr1: RudGetpriceP4074Fr1.fromJson(json["RUD_GETPRICE_P4074_FR_1"]),
        jdeStatus: json["jde__status"],
        jdeStartTimestamp: json["jde__startTimestamp"],
        jdeEndTimestamp: json["jde__endTimestamp"],
        jdeServerExecutionSeconds: json["jde__serverExecutionSeconds"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "mnNextNumber001": mnNextNumber001,
        "ARD_P55CPM42_RawSO_1": ardP55Cpm42RawSo1.toJson(),
        "Report Name": reportName,
        "Report Version": reportVersion,
        "Job Number": jobNumber,
        "Execution Server": executionServer,
        "Port": port,
        "Job Status": jobStatus,
        "Object Type": objectType,
        "User": user,
        "Environment": environment,
        "Submit Date": "${submitDate.year.toString().padLeft(4, '0')}-${submitDate.month.toString().padLeft(2, '0')}-${submitDate.day.toString().padLeft(2, '0')}",
        "Last Date": "${lastDate.year.toString().padLeft(4, '0')}-${lastDate.month.toString().padLeft(2, '0')}-${lastDate.day.toString().padLeft(2, '0')}",
        "Submit Time": submitTime,
        "Last Time": lastTime,
        "OID": oid,
        "Queue": queue,
        "ARD_F56CPFRE": ardF56Cpfre.toJson(),
        "ARD_F56CPSIM": ardF56Cpsim.toJson(),
        "Unit Price": unitPrice,
        "RUD_GETPRICE_P4074_FR_1": rudGetpriceP4074Fr1.toJson(),
        "jde__status": jdeStatus,
        "jde__startTimestamp": jdeStartTimestamp,
        "jde__endTimestamp": jdeEndTimestamp,
        "jde__serverExecutionSeconds": jdeServerExecutionSeconds,
    };
}

class ArdF56Cpfre {
    String tableId;
    List<ArdF56CpfreRowset> rowset;
    int records;
    bool moreRecords;

    ArdF56Cpfre({
        this.tableId,
        this.rowset,
        this.records,
        this.moreRecords,
    });

    factory ArdF56Cpfre.fromJson(Map<String, dynamic> json) => ArdF56Cpfre(
        tableId: json["tableId"],
        rowset: List<ArdF56CpfreRowset>.from(json["rowset"].map((x) => ArdF56CpfreRowset.fromJson(x))),
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

class ArdF56CpfreRowset {
    int orderNumber;
    String the2NdItemNumber;
    int shortItemNo;
    String businessUnit;
    int parentNumber;
    DateTime priceEffectiveDate;
    int fromLevel;
    int quantityFrom;
    String um;
    String adjSchedule;
    String cam2NdItemNumber1;
    int transQty;
    int quantityOrdered;
    int unitCost;
    int extendedPrice;
    String enterpriseOneEventPoint01;
    String userId;
    DateTime dateUpdated;
    String programId;
    String userReference;
    String userCode;
    int userNumber;
    int userAmount;
    String userDate;

    ArdF56CpfreRowset({
        this.orderNumber,
        this.the2NdItemNumber,
        this.shortItemNo,
        this.businessUnit,
        this.parentNumber,
        this.priceEffectiveDate,
        this.fromLevel,
        this.quantityFrom,
        this.um,
        this.adjSchedule,
        this.cam2NdItemNumber1,
        this.transQty,
        this.quantityOrdered,
        this.unitCost,
        this.extendedPrice,
        this.enterpriseOneEventPoint01,
        this.userId,
        this.dateUpdated,
        this.programId,
        this.userReference,
        this.userCode,
        this.userNumber,
        this.userAmount,
        this.userDate,
    });

    factory ArdF56CpfreRowset.fromJson(Map<String, dynamic> json) => ArdF56CpfreRowset(
        orderNumber: json["Order Number"],
        the2NdItemNumber: json["2nd Item Number"],
        shortItemNo: json["Short Item No"],
        businessUnit: json["Business Unit"],
        parentNumber: json["Parent Number"],
        priceEffectiveDate: DateTime.parse(json["Price Effective Date"]),
        fromLevel: json["From Level"],
        quantityFrom: json["Quantity From"],
        um: json["UM"],
        adjSchedule: json["Adj. Schedule"],
        cam2NdItemNumber1: json["CAM 2nd Item Number 1"],
        transQty: json["Trans QTY"],
        quantityOrdered: json["Quantity Ordered"],
        unitCost: json["Unit Cost"],
        extendedPrice: json["Extended Price"],
        enterpriseOneEventPoint01: json["EnterpriseOne Event Point 01"],
        userId: json["User ID"],
        dateUpdated: DateTime.parse(json["Date Updated"]),
        programId: json["Program ID"],
        userReference: json["User Reference"],
        userCode: json["User Code"],
        userNumber: json["User Number"],
        userAmount: json["User Amount"],
        userDate: json["User Date"],
    );

    Map<String, dynamic> toJson() => {
        "Order Number": orderNumber,
        "2nd Item Number": the2NdItemNumber,
        "Short Item No": shortItemNo,
        "Business Unit": businessUnit,
        "Parent Number": parentNumber,
        "Price Effective Date": "${priceEffectiveDate.year.toString().padLeft(4, '0')}-${priceEffectiveDate.month.toString().padLeft(2, '0')}-${priceEffectiveDate.day.toString().padLeft(2, '0')}",
        "From Level": fromLevel,
        "Quantity From": quantityFrom,
        "UM": um,
        "Adj. Schedule": adjSchedule,
        "CAM 2nd Item Number 1": cam2NdItemNumber1,
        "Trans QTY": transQty,
        "Quantity Ordered": quantityOrdered,
        "Unit Cost": unitCost,
        "Extended Price": extendedPrice,
        "EnterpriseOne Event Point 01": enterpriseOneEventPoint01,
        "User ID": userId,
        "Date Updated": "${dateUpdated.year.toString().padLeft(4, '0')}-${dateUpdated.month.toString().padLeft(2, '0')}-${dateUpdated.day.toString().padLeft(2, '0')}",
        "Program ID": programId,
        "User Reference": userReference,
        "User Code": userCode,
        "User Number": userNumber,
        "User Amount": userAmount,
        "User Date": userDate,
    };
}

class ArdF56Cpsim {
    String tableId;
    List<ArdF56CpsimRowset> rowset;
    int records;
    bool moreRecords;

    ArdF56Cpsim({
        this.tableId,
        this.rowset,
        this.records,
        this.moreRecords,
    });

    factory ArdF56Cpsim.fromJson(Map<String, dynamic> json) => ArdF56Cpsim(
        tableId: json["tableId"],
        rowset: List<ArdF56CpsimRowset>.from(json["rowset"].map((x) => ArdF56CpsimRowset.fromJson(x))),
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

class ArdF56CpsimRowset {
    int orderNumber;
    String the2NdItemNumber;
    String businessUnit;
    int parentNumber;
    int sequenceNo;
    String adjName;
    DateTime priceEffectiveDate;
    int fromLevel;
    int quantityFrom;
    String um;
    String curCod;
    String enterpriseOneEventPoint01;
    int shortItemNo;
    int unitPrice;
    int extendedPrice;
    String rptCd1;
    String rptCd2;
    String rptCd3;
    String rptCd4;
    String rptCd5;
    String adjSchedule;
    int factorValueNumeric;
    String bC;
    String userReference;
    String userCode;
    int userNumber;
    int userAmount;
    String userId;
    DateTime dateUpdated;
    String programId;

    ArdF56CpsimRowset({
        this.orderNumber,
        this.the2NdItemNumber,
        this.businessUnit,
        this.parentNumber,
        this.sequenceNo,
        this.adjName,
        this.priceEffectiveDate,
        this.fromLevel,
        this.quantityFrom,
        this.um,
        this.curCod,
        this.enterpriseOneEventPoint01,
        this.shortItemNo,
        this.unitPrice,
        this.extendedPrice,
        this.rptCd1,
        this.rptCd2,
        this.rptCd3,
        this.rptCd4,
        this.rptCd5,
        this.adjSchedule,
        this.factorValueNumeric,
        this.bC,
        this.userReference,
        this.userCode,
        this.userNumber,
        this.userAmount,
        this.userId,
        this.dateUpdated,
        this.programId,
    });

    factory ArdF56CpsimRowset.fromJson(Map<String, dynamic> json) => ArdF56CpsimRowset(
        orderNumber: json["Order Number"],
        the2NdItemNumber: json["2nd Item Number"],
        businessUnit: json["Business Unit"],
        parentNumber: json["Parent Number"],
        sequenceNo: json["Sequence No."],
        adjName: json["Adj Name"],
        priceEffectiveDate: DateTime.parse(json["Price Effective Date"]),
        fromLevel: json["From Level"],
        quantityFrom: json["Quantity From"],
        um: json["UM"],
        curCod: json["Cur Cod"],
        enterpriseOneEventPoint01: json["EnterpriseOne Event Point 01"],
        shortItemNo: json["Short Item No"],
        unitPrice: json["Unit Price"],
        extendedPrice: json["Extended Price"],
        rptCd1: json["Rpt Cd 1"],
        rptCd2: json["Rpt Cd 2"],
        rptCd3: json["Rpt Cd 3"],
        rptCd4: json["Rpt Cd 4"],
        rptCd5: json["Rpt Cd 5"],
        adjSchedule: json["Adj. Schedule"],
        factorValueNumeric: json["Factor Value Numeric"],
        bC: json["B C"],
        userReference: json["User Reference"],
        userCode: json["User Code"],
        userNumber: json["User Number"],
        userAmount: json["User Amount"],
        userId: json["User ID"],
        dateUpdated: DateTime.parse(json["Date Updated"]),
        programId: json["Program ID"],
    );

    Map<String, dynamic> toJson() => {
        "Order Number": orderNumber,
        "2nd Item Number": the2NdItemNumber,
        "Business Unit": businessUnit,
        "Parent Number": parentNumber,
        "Sequence No.": sequenceNo,
        "Adj Name": adjName,
        "Price Effective Date": "${priceEffectiveDate.year.toString().padLeft(4, '0')}-${priceEffectiveDate.month.toString().padLeft(2, '0')}-${priceEffectiveDate.day.toString().padLeft(2, '0')}",
        "From Level": fromLevel,
        "Quantity From": quantityFrom,
        "UM": um,
        "Cur Cod": curCod,
        "EnterpriseOne Event Point 01": enterpriseOneEventPoint01,
        "Short Item No": shortItemNo,
        "Unit Price": unitPrice,
        "Extended Price": extendedPrice,
        "Rpt Cd 1": rptCd1,
        "Rpt Cd 2": rptCd2,
        "Rpt Cd 3": rptCd3,
        "Rpt Cd 4": rptCd4,
        "Rpt Cd 5": rptCd5,
        "Adj. Schedule": adjSchedule,
        "Factor Value Numeric": factorValueNumeric,
        "B C": bC,
        "User Reference": userReference,
        "User Code": userCode,
        "User Number": userNumber,
        "User Amount": userAmount,
        "User ID": userId,
        "Date Updated": "${dateUpdated.year.toString().padLeft(4, '0')}-${dateUpdated.month.toString().padLeft(2, '0')}-${dateUpdated.day.toString().padLeft(2, '0')}",
        "Program ID": programId,
    };
}

class ArdP55Cpm42RawSo1 {
    String formId;
    String gridId;
    String title;
    List<ArdP55Cpm42RawSo1Rowset> rowset;
    int records;
    bool moreRecords;

    ArdP55Cpm42RawSo1({
        this.formId,
        this.gridId,
        this.title,
        this.rowset,
        this.records,
        this.moreRecords,
    });

    factory ArdP55Cpm42RawSo1.fromJson(Map<String, dynamic> json) => ArdP55Cpm42RawSo1(
        formId: json["formId"],
        gridId: json["gridId"],
        title: json["title"],
        rowset: List<ArdP55Cpm42RawSo1Rowset>.from(json["rowset"].map((x) => ArdP55Cpm42RawSo1Rowset.fromJson(x))),
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

class ArdP55Cpm42RawSo1Rowset {
    int orderNumber;
    String orderCo;
    String orTy;

    ArdP55Cpm42RawSo1Rowset({
        this.orderNumber,
        this.orderCo,
        this.orTy,
    });

    factory ArdP55Cpm42RawSo1Rowset.fromJson(Map<String, dynamic> json) => ArdP55Cpm42RawSo1Rowset(
        orderNumber: json["Order Number"],
        orderCo: json["Order Co"],
        orTy: json["Or Ty"],
    );

    Map<String, dynamic> toJson() => {
        "Order Number": orderNumber,
        "Order Co": orderCo,
        "Or Ty": orTy,
    };
}

class RudGetpriceP4074Fr1 {
    String formId;
    String gridId;
    String title;
    List<RudGetpriceP4074Fr1Rowset> rowset;
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
        rowset: List<RudGetpriceP4074Fr1Rowset>.from(json["rowset"].map((x) => RudGetpriceP4074Fr1Rowset.fromJson(x))),
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

class RudGetpriceP4074Fr1Rowset {
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

    RudGetpriceP4074Fr1Rowset({
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

    factory RudGetpriceP4074Fr1Rowset.fromJson(Map<String, dynamic> json) => RudGetpriceP4074Fr1Rowset(
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
