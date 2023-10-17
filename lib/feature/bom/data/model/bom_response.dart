// To parse this JSON data, do
//
//     final bomResponse = bomResponseFromJson(jsonString);

import 'dart:convert';

BomResponse bomResponseFromJson(String str) => BomResponse.fromJson(json.decode(str));

String bomResponseToJson(BomResponse data) => json.encode(data.toJson());

class BomResponse {
    final ServiceRequest1 serviceRequest1;
    final ServiceRequest2 serviceRequest2;
    final ServiceRequest3 serviceRequest3;

    BomResponse({
        this.serviceRequest1,
        this.serviceRequest2,
        this.serviceRequest3,
    });

    factory BomResponse.fromJson(Map<String, dynamic> json) => BomResponse(
        serviceRequest1: ServiceRequest1.fromJson(json["ServiceRequest1"]),
        serviceRequest2: ServiceRequest2.fromJson(json["ServiceRequest2"]),
        serviceRequest3: ServiceRequest3.fromJson(json["ServiceRequest3"]),
    );

    Map<String, dynamic> toJson() => {
        "ServiceRequest1": serviceRequest1.toJson(),
        "ServiceRequest2": serviceRequest2.toJson(),
        "ServiceRequest3": serviceRequest3.toJson(),
    };
}

class ServiceRequest1 {
    final FsDatabrowseF3002 fsDatabrowseF3002;
    final String currentApp;
    final String timeStamp;
    final List<dynamic> sysErrors;

    ServiceRequest1({
        this.fsDatabrowseF3002,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
    });

    factory ServiceRequest1.fromJson(Map<String, dynamic> json) => ServiceRequest1(
        fsDatabrowseF3002: FsDatabrowseF3002.fromJson(json["fs_DATABROWSE_F3002"]),
        currentApp: json["currentApp"],
        timeStamp: json["timeStamp"],
        sysErrors: List<dynamic>.from(json["sysErrors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fs_DATABROWSE_F3002": fsDatabrowseF3002.toJson(),
        "currentApp": currentApp,
        "timeStamp": timeStamp,
        "sysErrors": List<dynamic>.from(sysErrors.map((x) => x)),
    };
}

class FsDatabrowseF3002 {
    final String title;
    final FsDatabrowseF3002Data data;
    final List<dynamic> errors;
    final List<dynamic> warnings;

    FsDatabrowseF3002({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsDatabrowseF3002.fromJson(Map<String, dynamic> json) => FsDatabrowseF3002(
        title: json["title"],
        data: FsDatabrowseF3002Data.fromJson(json["data"]),
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

class FsDatabrowseF3002Data {
    final PurpleGridData gridData;

    FsDatabrowseF3002Data({
        this.gridData,
    });

    factory FsDatabrowseF3002Data.fromJson(Map<String, dynamic> json) => FsDatabrowseF3002Data(
        gridData: PurpleGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "gridData": gridData.toJson(),
    };
}

class PurpleGridData {
    final int id;
    final String fullGridId;
    final PurpleColumns columns;
    final List<Rowset> rowset;
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
        columns: PurpleColumns.fromJson(json["columns"]),
        rowset: List<Rowset>.from(json["rowset"].map((x) => Rowset.fromJson(x))),
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

class PurpleColumns {
    final String f3002Kitl;
    final String f3002Mmcu;
    final String f3002Litm;
    final String f3002Qnty;
    final String f3002Um;

    PurpleColumns({
        this.f3002Kitl,
        this.f3002Mmcu,
        this.f3002Litm,
        this.f3002Qnty,
        this.f3002Um,
    });

    factory PurpleColumns.fromJson(Map<String, dynamic> json) => PurpleColumns(
        f3002Kitl: json["F3002_KITL"],
        f3002Mmcu: json["F3002_MMCU"],
        f3002Litm: json["F3002_LITM"],
        f3002Qnty: json["F3002_QNTY"],
        f3002Um: json["F3002_UM"],
    );

    Map<String, dynamic> toJson() => {
        "F3002_KITL": f3002Kitl,
        "F3002_MMCU": f3002Mmcu,
        "F3002_LITM": f3002Litm,
        "F3002_QNTY": f3002Qnty,
        "F3002_UM": f3002Um,
    };
}

class Rowset {
    final String f3002Kitl;
    final String f3002Mmcu;
    final String f3002Litm;
    final int f3002Qnty;
    final String f3002Um;

    Rowset({
        this.f3002Kitl,
        this.f3002Mmcu,
        this.f3002Litm,
        this.f3002Qnty,
        this.f3002Um,
    });

    factory Rowset.fromJson(Map<String, dynamic> json) => Rowset(
        f3002Kitl: json["F3002_KITL"],
        f3002Mmcu: json["F3002_MMCU"],
        f3002Litm: json["F3002_LITM"],
        f3002Qnty: json["F3002_QNTY"],
        f3002Um: json["F3002_UM"],
    );

    Map<String, dynamic> toJson() => {
        "F3002_KITL": f3002Kitl,
        "F3002_MMCU": f3002Mmcu,
        "F3002_LITM": f3002Litm,
        "F3002_QNTY": f3002Qnty,
        "F3002_UM": f3002Um,
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
    final ServiceRequest2FsDatabrowseF4101 fsDatabrowseF4101;
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
        fsDatabrowseF4101: ServiceRequest2FsDatabrowseF4101.fromJson(json["fs_DATABROWSE_F4101"]),
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

class ServiceRequest2FsDatabrowseF4101 {
    final String title;
    final PurpleData data;
    final List<dynamic> errors;
    final List<dynamic> warnings;

    ServiceRequest2FsDatabrowseF4101({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory ServiceRequest2FsDatabrowseF4101.fromJson(Map<String, dynamic> json) => ServiceRequest2FsDatabrowseF4101(
        title: json["title"],
        data: PurpleData.fromJson(json["data"]),
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

class PurpleData {
    final FluffyGridData gridData;

    PurpleData({
        this.gridData,
    });

    factory PurpleData.fromJson(Map<String, dynamic> json) => PurpleData(
        gridData: FluffyGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "gridData": gridData.toJson(),
    };
}

class FluffyGridData {
    final int id;
    final String fullGridId;
    final RowsetClass columns;
    final List<RowsetClass> rowset;
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
        columns: RowsetClass.fromJson(json["columns"]),
        rowset: List<RowsetClass>.from(json["rowset"].map((x) => RowsetClass.fromJson(x))),
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

class RowsetClass {
    final String f4101Litm;
    final String f4101Dsc1;
    final String f4101Dsc2;

    RowsetClass({
        this.f4101Litm,
        this.f4101Dsc1,
        this.f4101Dsc2,
    });

    factory RowsetClass.fromJson(Map<String, dynamic> json) => RowsetClass(
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

class ServiceRequest3 {
    final ServiceRequest3FsDatabrowseF4101 fsDatabrowseF4101;
    final String currentApp;
    final String timeStamp;
    final List<dynamic> sysErrors;

    ServiceRequest3({
        this.fsDatabrowseF4101,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
    });

    factory ServiceRequest3.fromJson(Map<String, dynamic> json) => ServiceRequest3(
        fsDatabrowseF4101: ServiceRequest3FsDatabrowseF4101.fromJson(json["fs_DATABROWSE_F4101"]),
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

class ServiceRequest3FsDatabrowseF4101 {
    final String title;
    final FluffyData data;
    final List<dynamic> errors;
    final List<dynamic> warnings;

    ServiceRequest3FsDatabrowseF4101({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory ServiceRequest3FsDatabrowseF4101.fromJson(Map<String, dynamic> json) => ServiceRequest3FsDatabrowseF4101(
        title: json["title"],
        data: FluffyData.fromJson(json["data"]),
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

class FluffyData {
    final FluffyGridData gridData;

    FluffyData({
        this.gridData,
    });

    factory FluffyData.fromJson(Map<String, dynamic> json) => FluffyData(
        gridData: FluffyGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "gridData": gridData.toJson(),
    };
}
