// To parse this JSON data, do
//
//     final itemBranchResponse = itemBranchResponseFromJson(jsonString);

import 'dart:convert';

ItemBranchResponse itemBranchResponseFromJson(String str) => ItemBranchResponse.fromJson(json.decode(str));

String itemBranchResponseToJson(ItemBranchResponse data) => json.encode(data.toJson());

class ItemBranchResponse {
    final ServiceRequest1 serviceRequest1;
    final ServiceRequest2 serviceRequest2;

    ItemBranchResponse({
        this.serviceRequest1,
        this.serviceRequest2,
    });

    factory ItemBranchResponse.fromJson(Map<String, dynamic> json) => ItemBranchResponse(
        serviceRequest1: ServiceRequest1.fromJson(json["ServiceRequest1"]),
        serviceRequest2: ServiceRequest2.fromJson(json["ServiceRequest2"]),
    );

    Map<String, dynamic> toJson() => {
        "ServiceRequest1": serviceRequest1.toJson(),
        "ServiceRequest2": serviceRequest2.toJson(),
    };
}

class ServiceRequest1 {
    final FsDatabrowseF4102 fsDatabrowseF4102;
    final String currentApp;
    final String timeStamp;
    final List<dynamic> sysErrors;

    ServiceRequest1({
        this.fsDatabrowseF4102,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
    });

    factory ServiceRequest1.fromJson(Map<String, dynamic> json) => ServiceRequest1(
        fsDatabrowseF4102: FsDatabrowseF4102.fromJson(json["fs_DATABROWSE_F4102"]),
        currentApp: json["currentApp"],
        timeStamp: json["timeStamp"],
        sysErrors: List<dynamic>.from(json["sysErrors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fs_DATABROWSE_F4102": fsDatabrowseF4102.toJson(),
        "currentApp": currentApp,
        "timeStamp": timeStamp,
        "sysErrors": List<dynamic>.from(sysErrors.map((x) => x)),
    };
}

class FsDatabrowseF4102 {
    final String title;
    final FsDatabrowseF4102Data data;
    final List<dynamic> errors;
    final List<dynamic> warnings;

    FsDatabrowseF4102({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsDatabrowseF4102.fromJson(Map<String, dynamic> json) => FsDatabrowseF4102(
        title: json["title"],
        data: FsDatabrowseF4102Data.fromJson(json["data"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "data": data.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}

class FsDatabrowseF4102Data {
    final PurpleGridData gridData;

    FsDatabrowseF4102Data({
        this.gridData,
    });

    factory FsDatabrowseF4102Data.fromJson(Map<String, dynamic> json) => FsDatabrowseF4102Data(
        gridData: PurpleGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "gridData": gridData.toJson(),
    };
}

class PurpleGridData {
    final int id;
    final String fullGridId;
    final ItemBranch columns;
    final List<ItemBranch> rowset;
    final Summary summary;

    PurpleGridData({
        this.id,
        this.fullGridId,
        this.columns,
        this.rowset,
        this.summary,
    });

    factory PurpleGridData.fromJson(Map<String, dynamic> json) => PurpleGridData(
        id: json["id"],
        fullGridId: json["fullGridId"],
        columns: ItemBranch.fromJson(json["columns"]),
        rowset: List<ItemBranch>.from(json["rowset"].map((x) => ItemBranch.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullGridId": fullGridId,
        "columns": columns.toJson(),
        "rowset": List<dynamic>.from(rowset.map((x) => x.toJson())),
        "summary": summary.toJson(),
    };
}

class ItemBranch {
    final String f4102Litm;
    final String f4102Mcu;
    final String f4102Stkt;

    ItemBranch({
        this.f4102Litm,
        this.f4102Mcu,
        this.f4102Stkt,
    });

    factory ItemBranch.fromJson(Map<String, dynamic> json) => ItemBranch(
        f4102Litm: json["F4102_LITM"],
        f4102Mcu: json["F4102_MCU"],
        f4102Stkt: json["F4102_STKT"],
    );

    Map<String, dynamic> toJson() => {
        "F4102_LITM": f4102Litm,
        "F4102_MCU": f4102Mcu,
        "F4102_STKT": f4102Stkt,
    };
}

class Summary {
    final int records;
    final bool moreRecords;

    Summary({
        this.records,
        this.moreRecords,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        records: json["records"],
        moreRecords: json["moreRecords"],
    );

    Map<String, dynamic> toJson() => {
        "records": records,
        "moreRecords": moreRecords,
    };
}

class ServiceRequest2 {
    final FsDatabrowseF4101 fsDatabrowseF4101;
    final String currentApp;
    final String timeStamp;
    final List<dynamic> sysErrors;

    ServiceRequest2({
        this.fsDatabrowseF4101,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
    });

    factory ServiceRequest2.fromJson(Map<String, dynamic> json) => ServiceRequest2(
        fsDatabrowseF4101: FsDatabrowseF4101.fromJson(json["fs_DATABROWSE_F4101"]),
        currentApp: json["currentApp"],
        timeStamp: json["timeStamp"],
        sysErrors: List<dynamic>.from(json["sysErrors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fs_DATABROWSE_F4101": fsDatabrowseF4101.toJson(),
        "currentApp": currentApp,
        "timeStamp": timeStamp,
        "sysErrors": List<dynamic>.from(sysErrors.map((x) => x)),
    };
}

class FsDatabrowseF4101 {
    final String title;
    final FsDatabrowseF4101Data data;
    final List<dynamic> errors;
    final List<dynamic> warnings;

    FsDatabrowseF4101({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsDatabrowseF4101.fromJson(Map<String, dynamic> json) => FsDatabrowseF4101(
        title: json["title"],
        data: FsDatabrowseF4101Data.fromJson(json["data"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        warnings: List<dynamic>.from(json["warnings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "data": data.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "warnings": List<dynamic>.from(warnings.map((x) => x)),
    };
}

class FsDatabrowseF4101Data {
    final FluffyGridData gridData;

    FsDatabrowseF4101Data({
        this.gridData,
    });

    factory FsDatabrowseF4101Data.fromJson(Map<String, dynamic> json) => FsDatabrowseF4101Data(
        gridData: FluffyGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "gridData": gridData.toJson(),
    };
}

class FluffyGridData {
    final int id;
    final String fullGridId;
    final FluffyColumns columns;
    final List<FluffyColumns> rowset;
    final Summary summary;

    FluffyGridData({
        this.id,
        this.fullGridId,
        this.columns,
        this.rowset,
        this.summary,
    });

    factory FluffyGridData.fromJson(Map<String, dynamic> json) => FluffyGridData(
        id: json["id"],
        fullGridId: json["fullGridId"],
        columns: FluffyColumns.fromJson(json["columns"]),
        rowset: List<FluffyColumns>.from(json["rowset"].map((x) => FluffyColumns.fromJson(x))),
        summary: Summary.fromJson(json["summary"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullGridId": fullGridId,
        "columns": columns.toJson(),
        "rowset": List<dynamic>.from(rowset.map((x) => x.toJson())),
        "summary": summary.toJson(),
    };
}

class FluffyColumns {
    final String f4101Litm;
    final String f4101Dsc1;
    final String f4101Dsc2;

    FluffyColumns({
        this.f4101Litm,
        this.f4101Dsc1,
        this.f4101Dsc2,
    });

    factory FluffyColumns.fromJson(Map<String, dynamic> json) => FluffyColumns(
        f4101Litm: json["F4101_LITM"],
        f4101Dsc1: json["F4101_DSC1"],
        f4101Dsc2: json["F4101_DSC2"],
    );

    Map<String, dynamic> toJson() => {
        "F4101_LITM": f4101Litm,
        "F4101_DSC1": f4101Dsc1,
        "F4101_DSC2": f4101Dsc2,
    };
}
