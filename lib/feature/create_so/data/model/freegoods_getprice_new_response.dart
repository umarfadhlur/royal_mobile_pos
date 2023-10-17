// To parse this JSON data, do
//
//     final freeGoodsGetPriceResponseNew = freeGoodsGetPriceResponseNewFromJson(jsonString);

import 'dart:convert';

FreeGoodsGetPriceResponseNew freeGoodsGetPriceResponseNewFromJson(String str) => FreeGoodsGetPriceResponseNew.fromJson(json.decode(str));

String freeGoodsGetPriceResponseNewToJson(FreeGoodsGetPriceResponseNew data) => json.encode(data.toJson());

class FreeGoodsGetPriceResponseNew {
    ServiceRequest1 serviceRequest1;
    ServiceRequest2 serviceRequest2;
    ServiceRequest3 serviceRequest3;
    ServiceRequest4 serviceRequest4;
    ServiceRequest5 serviceRequest5;
    ServiceRequest6 serviceRequest6;
    String jdeStatus;
    String jdeStartTimestamp;
    String jdeEndTimestamp;
    double jdeServerExecutionSeconds;

    FreeGoodsGetPriceResponseNew({
        this.serviceRequest1,
        this.serviceRequest2,
        this.serviceRequest3,
        this.serviceRequest4,
        this.serviceRequest5,
        this.serviceRequest6,
        this.jdeStatus,
        this.jdeStartTimestamp,
        this.jdeEndTimestamp,
        this.jdeServerExecutionSeconds,
    });

    factory FreeGoodsGetPriceResponseNew.fromJson(Map<String, dynamic> json) => FreeGoodsGetPriceResponseNew(
        serviceRequest1: ServiceRequest1.fromJson(json["ServiceRequest1"]),
        serviceRequest2: ServiceRequest2.fromJson(json["ServiceRequest2"]),
        serviceRequest3: ServiceRequest3.fromJson(json["ServiceRequest3"]),
        serviceRequest4: ServiceRequest4.fromJson(json["ServiceRequest4"]),
        serviceRequest5: ServiceRequest5.fromJson(json["ServiceRequest5"]),
        serviceRequest6: ServiceRequest6.fromJson(json["ServiceRequest6"]),
        jdeStatus: json["jde__status"],
        jdeStartTimestamp: json["jde__startTimestamp"],
        jdeEndTimestamp: json["jde__endTimestamp"],
        jdeServerExecutionSeconds: json["jde__serverExecutionSeconds"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ServiceRequest1": serviceRequest1.toJson(),
        "ServiceRequest2": serviceRequest2.toJson(),
        "ServiceRequest3": serviceRequest3.toJson(),
        "ServiceRequest4": serviceRequest4.toJson(),
        "ServiceRequest5": serviceRequest5.toJson(),
        "ServiceRequest6": serviceRequest6.toJson(),
        "jde__status": jdeStatus,
        "jde__startTimestamp": jdeStartTimestamp,
        "jde__endTimestamp": jdeEndTimestamp,
        "jde__serverExecutionSeconds": jdeServerExecutionSeconds,
    };
}

class ServiceRequest1 {
    String name;
    String template;
    bool submitted;
    Result result;

    ServiceRequest1({
        this.name,
        this.template,
        this.submitted,
        this.result,
    });

    factory ServiceRequest1.fromJson(Map<String, dynamic> json) => ServiceRequest1(
        name: json["name"],
        template: json["template"],
        submitted: json["submitted"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "template": template,
        "submitted": submitted,
        "result": result.toJson(),
    };
}

class Result {
    List<Output> output;

    Result({
        this.output,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        output: List<Output>.from(json["output"].map((x) => Output.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "output": List<dynamic>.from(output.map((x) => x.toJson())),
    };
}

class Output {
    int id;
    int value;
    String name;

    Output({
        this.id,
        this.value,
        this.name,
    });

    factory Output.fromJson(Map<String, dynamic> json) => Output(
        id: json["id"],
        value: json["value"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
        "name": name,
    };
}

class ServiceRequest2 {
    FsP55Cpm42W55Cpm42A fsP55Cpm42W55Cpm42A;
    int stackId;
    int stateId;
    String rid;
    String currentApp;
    String timeStamp;
    List<dynamic> sysErrors;

    ServiceRequest2({
        this.fsP55Cpm42W55Cpm42A,
        this.stackId,
        this.stateId,
        this.rid,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
    });

    factory ServiceRequest2.fromJson(Map<String, dynamic> json) => ServiceRequest2(
        fsP55Cpm42W55Cpm42A: FsP55Cpm42W55Cpm42A.fromJson(json["fs_P55CPM42_W55CPM42A"]),
        stackId: json["stackId"],
        stateId: json["stateId"],
        rid: json["rid"],
        currentApp: json["currentApp"],
        timeStamp: json["timeStamp"],
        sysErrors: List<dynamic>.from(json["sysErrors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fs_P55CPM42_W55CPM42A": fsP55Cpm42W55Cpm42A.toJson(),
        "stackId": stackId,
        "stateId": stateId,
        "rid": rid,
        "currentApp": currentApp,
        "timeStamp": timeStamp,
        "sysErrors": List<dynamic>.from(sysErrors.map((x) => x)),
    };
}

class FsP55Cpm42W55Cpm42A {
    String title;
    FsP55Cpm42W55Cpm42AData data;
    List<dynamic> errors;
    List<dynamic> warnings;

    FsP55Cpm42W55Cpm42A({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsP55Cpm42W55Cpm42A.fromJson(Map<String, dynamic> json) => FsP55Cpm42W55Cpm42A(
        title: json["title"],
        data: FsP55Cpm42W55Cpm42AData.fromJson(json["data"]),
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

class FsP55Cpm42W55Cpm42AData {
    PurpleGridData gridData;

    FsP55Cpm42W55Cpm42AData({
        this.gridData,
    });

    factory FsP55Cpm42W55Cpm42AData.fromJson(Map<String, dynamic> json) => FsP55Cpm42W55Cpm42AData(
        gridData: PurpleGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "gridData": gridData.toJson(),
    };
}

class PurpleGridData {
    int id;
    String fullGridId;
    PurpleColumns columns;
    List<PurpleRowset> rowset;
    Summary summary;

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
        rowset: List<PurpleRowset>.from(json["rowset"].map((x) => PurpleRowset.fromJson(x))),
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
    String zDoco18;
    String zKcoo22;
    String zDcto17;

    PurpleColumns({
        this.zDoco18,
        this.zKcoo22,
        this.zDcto17,
    });

    factory PurpleColumns.fromJson(Map<String, dynamic> json) => PurpleColumns(
        zDoco18: json["z_DOCO_18"],
        zKcoo22: json["z_KCOO_22"],
        zDcto17: json["z_DCTO_17"],
    );

    Map<String, dynamic> toJson() => {
        "z_DOCO_18": zDoco18,
        "z_KCOO_22": zKcoo22,
        "z_DCTO_17": zDcto17,
    };
}

class PurpleRowset {
    int zDoco18;
    String zKcoo22;
    String zDcto17;

    PurpleRowset({
        this.zDoco18,
        this.zKcoo22,
        this.zDcto17,
    });

    factory PurpleRowset.fromJson(Map<String, dynamic> json) => PurpleRowset(
        zDoco18: json["z_DOCO_18"],
        zKcoo22: json["z_KCOO_22"],
        zDcto17: json["z_DCTO_17"],
    );

    Map<String, dynamic> toJson() => {
        "z_DOCO_18": zDoco18,
        "z_KCOO_22": zKcoo22,
        "z_DCTO_17": zDcto17,
    };
}

class Summary {
    int records;
    bool moreRecords;

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

class ServiceRequest3 {
    String reportName;
    String reportVersion;
    int jobNumber;
    String executionServer;
    String actualServer;
    String port;
    String jobStatus;
    String objectType;
    String user;
    String environment;
    String submitDate;
    String lastDate;
    int submitTime;
    int lastTime;
    String oid;
    String queueName;

    ServiceRequest3({
        this.reportName,
        this.reportVersion,
        this.jobNumber,
        this.executionServer,
        this.actualServer,
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
        this.queueName,
    });

    factory ServiceRequest3.fromJson(Map<String, dynamic> json) => ServiceRequest3(
        reportName: json["reportName"],
        reportVersion: json["reportVersion"],
        jobNumber: json["jobNumber"],
        executionServer: json["executionServer"],
        actualServer: json["actualServer"],
        port: json["port"],
        jobStatus: json["jobStatus"],
        objectType: json["objectType"],
        user: json["user"],
        environment: json["environment"],
        submitDate: json["submitDate"],
        lastDate: json["lastDate"],
        submitTime: json["submitTime"],
        lastTime: json["lastTime"],
        oid: json["oid"],
        queueName: json["queueName"],
    );

    Map<String, dynamic> toJson() => {
        "reportName": reportName,
        "reportVersion": reportVersion,
        "jobNumber": jobNumber,
        "executionServer": executionServer,
        "actualServer": actualServer,
        "port": port,
        "jobStatus": jobStatus,
        "objectType": objectType,
        "user": user,
        "environment": environment,
        "submitDate": submitDate,
        "lastDate": lastDate,
        "submitTime": submitTime,
        "lastTime": lastTime,
        "oid": oid,
        "queueName": queueName,
    };
}

class ServiceRequest4 {
    FsDatabrowseF56Cpfre fsDatabrowseF56Cpfre;
    String currentApp;
    String timeStamp;
    List<dynamic> sysErrors;

    ServiceRequest4({
        this.fsDatabrowseF56Cpfre,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
    });

    factory ServiceRequest4.fromJson(Map<String, dynamic> json) => ServiceRequest4(
        fsDatabrowseF56Cpfre: FsDatabrowseF56Cpfre.fromJson(json["fs_DATABROWSE_F56CPFRE"]),
        currentApp: json["currentApp"],
        timeStamp: json["timeStamp"],
        sysErrors: List<dynamic>.from(json["sysErrors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fs_DATABROWSE_F56CPFRE": fsDatabrowseF56Cpfre.toJson(),
        "currentApp": currentApp,
        "timeStamp": timeStamp,
        "sysErrors": List<dynamic>.from(sysErrors.map((x) => x)),
    };
}

class FsDatabrowseF56Cpfre {
    String title;
    FsDatabrowseF56CpfreData data;
    List<dynamic> errors;
    List<dynamic> warnings;

    FsDatabrowseF56Cpfre({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsDatabrowseF56Cpfre.fromJson(Map<String, dynamic> json) => FsDatabrowseF56Cpfre(
        title: json["title"],
        data: FsDatabrowseF56CpfreData.fromJson(json["data"]),
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

class FsDatabrowseF56CpfreData {
    FluffyGridData gridData;

    FsDatabrowseF56CpfreData({
        this.gridData,
    });

    factory FsDatabrowseF56CpfreData.fromJson(Map<String, dynamic> json) => FsDatabrowseF56CpfreData(
        gridData: FluffyGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "gridData": gridData.toJson(),
    };
}

class FluffyGridData {
    int id;
    String fullGridId;
    FluffyColumns columns;
    List<FluffyRowset> rowset;
    Summary summary;

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
        rowset: List<FluffyRowset>.from(json["rowset"].map((x) => FluffyRowset.fromJson(x))),
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
    String f56CpfreDoco;
    String f56CpfreLitm;
    String f56CpfreItm;
    String f56CpfreMcu;
    String f56CpfrePa8;
    String f56CpfrePefj;
    String f56CpfreDmnq;
    String f56CpfreMnq;
    String f56CpfreUom;
    String f56CpfreAsn;
    String f56CpfreCa1Litm;
    String f56CpfreTrqt;
    String f56CpfreUorg;
    String f56CpfreUncs;
    String f56CpfreAexp;
    String f56CpfreEv01;
    String f56CpfreUser;
    String f56CpfreUpmj;
    String f56CpfrePid;
    String f56CpfreUrrf;
    String f56CpfreUrcd;
    String f56CpfreUrab;
    String f56CpfreUrat;
    String f56CpfreUrdt;

    FluffyColumns({
        this.f56CpfreDoco,
        this.f56CpfreLitm,
        this.f56CpfreItm,
        this.f56CpfreMcu,
        this.f56CpfrePa8,
        this.f56CpfrePefj,
        this.f56CpfreDmnq,
        this.f56CpfreMnq,
        this.f56CpfreUom,
        this.f56CpfreAsn,
        this.f56CpfreCa1Litm,
        this.f56CpfreTrqt,
        this.f56CpfreUorg,
        this.f56CpfreUncs,
        this.f56CpfreAexp,
        this.f56CpfreEv01,
        this.f56CpfreUser,
        this.f56CpfreUpmj,
        this.f56CpfrePid,
        this.f56CpfreUrrf,
        this.f56CpfreUrcd,
        this.f56CpfreUrab,
        this.f56CpfreUrat,
        this.f56CpfreUrdt,
    });

    factory FluffyColumns.fromJson(Map<String, dynamic> json) => FluffyColumns(
        f56CpfreDoco: json["F56CPFRE_DOCO"],
        f56CpfreLitm: json["F56CPFRE_LITM"],
        f56CpfreItm: json["F56CPFRE_ITM"],
        f56CpfreMcu: json["F56CPFRE_MCU"],
        f56CpfrePa8: json["F56CPFRE_PA8"],
        f56CpfrePefj: json["F56CPFRE_PEFJ"],
        f56CpfreDmnq: json["F56CPFRE_DMNQ"],
        f56CpfreMnq: json["F56CPFRE_MNQ"],
        f56CpfreUom: json["F56CPFRE_UOM"],
        f56CpfreAsn: json["F56CPFRE_ASN"],
        f56CpfreCa1Litm: json["F56CPFRE_CA1LITM"],
        f56CpfreTrqt: json["F56CPFRE_TRQT"],
        f56CpfreUorg: json["F56CPFRE_UORG"],
        f56CpfreUncs: json["F56CPFRE_UNCS"],
        f56CpfreAexp: json["F56CPFRE_AEXP"],
        f56CpfreEv01: json["F56CPFRE_EV01"],
        f56CpfreUser: json["F56CPFRE_USER"],
        f56CpfreUpmj: json["F56CPFRE_UPMJ"],
        f56CpfrePid: json["F56CPFRE_PID"],
        f56CpfreUrrf: json["F56CPFRE_URRF"],
        f56CpfreUrcd: json["F56CPFRE_URCD"],
        f56CpfreUrab: json["F56CPFRE_URAB"],
        f56CpfreUrat: json["F56CPFRE_URAT"],
        f56CpfreUrdt: json["F56CPFRE_URDT"],
    );

    Map<String, dynamic> toJson() => {
        "F56CPFRE_DOCO": f56CpfreDoco,
        "F56CPFRE_LITM": f56CpfreLitm,
        "F56CPFRE_ITM": f56CpfreItm,
        "F56CPFRE_MCU": f56CpfreMcu,
        "F56CPFRE_PA8": f56CpfrePa8,
        "F56CPFRE_PEFJ": f56CpfrePefj,
        "F56CPFRE_DMNQ": f56CpfreDmnq,
        "F56CPFRE_MNQ": f56CpfreMnq,
        "F56CPFRE_UOM": f56CpfreUom,
        "F56CPFRE_ASN": f56CpfreAsn,
        "F56CPFRE_CA1LITM": f56CpfreCa1Litm,
        "F56CPFRE_TRQT": f56CpfreTrqt,
        "F56CPFRE_UORG": f56CpfreUorg,
        "F56CPFRE_UNCS": f56CpfreUncs,
        "F56CPFRE_AEXP": f56CpfreAexp,
        "F56CPFRE_EV01": f56CpfreEv01,
        "F56CPFRE_USER": f56CpfreUser,
        "F56CPFRE_UPMJ": f56CpfreUpmj,
        "F56CPFRE_PID": f56CpfrePid,
        "F56CPFRE_URRF": f56CpfreUrrf,
        "F56CPFRE_URCD": f56CpfreUrcd,
        "F56CPFRE_URAB": f56CpfreUrab,
        "F56CPFRE_URAT": f56CpfreUrat,
        "F56CPFRE_URDT": f56CpfreUrdt,
    };
}

class FluffyRowset {
    int f56CpfreDoco;
    String f56CpfreLitm;
    int f56CpfreItm;
    String f56CpfreMcu;
    int f56CpfrePa8;
    String f56CpfrePefj;
    int f56CpfreDmnq;
    int f56CpfreMnq;
    String f56CpfreUom;
    String f56CpfreAsn;
    String f56CpfreCa1Litm;
    int f56CpfreTrqt;
    int f56CpfreUorg;
    int f56CpfreUncs;
    int f56CpfreAexp;
    String f56CpfreEv01;
    String f56CpfreUser;
    String f56CpfreUpmj;
    String f56CpfrePid;
    String f56CpfreUrrf;
    String f56CpfreUrcd;
    int f56CpfreUrab;
    int f56CpfreUrat;
    dynamic f56CpfreUrdt;

    FluffyRowset({
        this.f56CpfreDoco,
        this.f56CpfreLitm,
        this.f56CpfreItm,
        this.f56CpfreMcu,
        this.f56CpfrePa8,
        this.f56CpfrePefj,
        this.f56CpfreDmnq,
        this.f56CpfreMnq,
        this.f56CpfreUom,
        this.f56CpfreAsn,
        this.f56CpfreCa1Litm,
        this.f56CpfreTrqt,
        this.f56CpfreUorg,
        this.f56CpfreUncs,
        this.f56CpfreAexp,
        this.f56CpfreEv01,
        this.f56CpfreUser,
        this.f56CpfreUpmj,
        this.f56CpfrePid,
        this.f56CpfreUrrf,
        this.f56CpfreUrcd,
        this.f56CpfreUrab,
        this.f56CpfreUrat,
        this.f56CpfreUrdt,
    });

    factory FluffyRowset.fromJson(Map<String, dynamic> json) => FluffyRowset(
        f56CpfreDoco: json["F56CPFRE_DOCO"],
        f56CpfreLitm: json["F56CPFRE_LITM"],
        f56CpfreItm: json["F56CPFRE_ITM"],
        f56CpfreMcu: json["F56CPFRE_MCU"],
        f56CpfrePa8: json["F56CPFRE_PA8"],
        f56CpfrePefj: json["F56CPFRE_PEFJ"],
        f56CpfreDmnq: json["F56CPFRE_DMNQ"],
        f56CpfreMnq: json["F56CPFRE_MNQ"],
        f56CpfreUom: json["F56CPFRE_UOM"],
        f56CpfreAsn: json["F56CPFRE_ASN"],
        f56CpfreCa1Litm: json["F56CPFRE_CA1LITM"],
        f56CpfreTrqt: json["F56CPFRE_TRQT"],
        f56CpfreUorg: json["F56CPFRE_UORG"],
        f56CpfreUncs: json["F56CPFRE_UNCS"],
        f56CpfreAexp: json["F56CPFRE_AEXP"],
        f56CpfreEv01: json["F56CPFRE_EV01"],
        f56CpfreUser: json["F56CPFRE_USER"],
        f56CpfreUpmj: json["F56CPFRE_UPMJ"],
        f56CpfrePid: json["F56CPFRE_PID"],
        f56CpfreUrrf: json["F56CPFRE_URRF"],
        f56CpfreUrcd: json["F56CPFRE_URCD"],
        f56CpfreUrab: json["F56CPFRE_URAB"],
        f56CpfreUrat: json["F56CPFRE_URAT"],
        f56CpfreUrdt: json["F56CPFRE_URDT"],
    );

    Map<String, dynamic> toJson() => {
        "F56CPFRE_DOCO": f56CpfreDoco,
        "F56CPFRE_LITM": f56CpfreLitm,
        "F56CPFRE_ITM": f56CpfreItm,
        "F56CPFRE_MCU": f56CpfreMcu,
        "F56CPFRE_PA8": f56CpfrePa8,
        "F56CPFRE_PEFJ": f56CpfrePefj,
        "F56CPFRE_DMNQ": f56CpfreDmnq,
        "F56CPFRE_MNQ": f56CpfreMnq,
        "F56CPFRE_UOM": f56CpfreUom,
        "F56CPFRE_ASN": f56CpfreAsn,
        "F56CPFRE_CA1LITM": f56CpfreCa1Litm,
        "F56CPFRE_TRQT": f56CpfreTrqt,
        "F56CPFRE_UORG": f56CpfreUorg,
        "F56CPFRE_UNCS": f56CpfreUncs,
        "F56CPFRE_AEXP": f56CpfreAexp,
        "F56CPFRE_EV01": f56CpfreEv01,
        "F56CPFRE_USER": f56CpfreUser,
        "F56CPFRE_UPMJ": f56CpfreUpmj,
        "F56CPFRE_PID": f56CpfrePid,
        "F56CPFRE_URRF": f56CpfreUrrf,
        "F56CPFRE_URCD": f56CpfreUrcd,
        "F56CPFRE_URAB": f56CpfreUrab,
        "F56CPFRE_URAT": f56CpfreUrat,
        "F56CPFRE_URDT": f56CpfreUrdt,
    };
}

class ServiceRequest5 {
    FsDatabrowseF56Cpsim fsDatabrowseF56Cpsim;
    String currentApp;
    String timeStamp;
    List<dynamic> sysErrors;

    ServiceRequest5({
        this.fsDatabrowseF56Cpsim,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
    });

    factory ServiceRequest5.fromJson(Map<String, dynamic> json) => ServiceRequest5(
        fsDatabrowseF56Cpsim: FsDatabrowseF56Cpsim.fromJson(json["fs_DATABROWSE_F56CPSIM"]),
        currentApp: json["currentApp"],
        timeStamp: json["timeStamp"],
        sysErrors: List<dynamic>.from(json["sysErrors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fs_DATABROWSE_F56CPSIM": fsDatabrowseF56Cpsim.toJson(),
        "currentApp": currentApp,
        "timeStamp": timeStamp,
        "sysErrors": List<dynamic>.from(sysErrors.map((x) => x)),
    };
}

class FsDatabrowseF56Cpsim {
    String title;
    FsDatabrowseF56CpsimData data;
    List<dynamic> errors;
    List<dynamic> warnings;

    FsDatabrowseF56Cpsim({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsDatabrowseF56Cpsim.fromJson(Map<String, dynamic> json) => FsDatabrowseF56Cpsim(
        title: json["title"],
        data: FsDatabrowseF56CpsimData.fromJson(json["data"]),
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

class FsDatabrowseF56CpsimData {
    TentacledGridData gridData;

    FsDatabrowseF56CpsimData({
        this.gridData,
    });

    factory FsDatabrowseF56CpsimData.fromJson(Map<String, dynamic> json) => FsDatabrowseF56CpsimData(
        gridData: TentacledGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "gridData": gridData.toJson(),
    };
}

class TentacledGridData {
    int id;
    String fullGridId;
    TentacledColumns columns;
    List<TentacledRowset> rowset;
    Summary summary;

    TentacledGridData({
        this.id,
        this.fullGridId,
        this.columns,
        this.rowset,
        this.summary,
    });

    factory TentacledGridData.fromJson(Map<String, dynamic> json) => TentacledGridData(
        id: json["id"],
        fullGridId: json["fullGridId"],
        columns: TentacledColumns.fromJson(json["columns"]),
        rowset: List<TentacledRowset>.from(json["rowset"].map((x) => TentacledRowset.fromJson(x))),
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

class TentacledColumns {
    String f56CpsimDoco;
    String f56CpsimLitm;
    String f56CpsimMcu;
    String f56CpsimPa8;
    String f56CpsimOseq;
    String f56CpsimAst;
    String f56CpsimPefj;
    String f56CpsimDmnq;
    String f56CpsimMnq;
    String f56CpsimUom;
    String f56CpsimCrcd;
    String f56CpsimEv01;
    String f56CpsimItm;
    String f56CpsimUprc;
    String f56CpsimAexp;
    String f56CpsimAprp1;
    String f56CpsimAprp2;
    String f56CpsimAprp3;
    String f56CpsimAprp4;
    String f56CpsimAprp5;
    String f56CpsimAsn;
    String f56CpsimFvtr;
    String f56CpsimBscd;
    String f56CpsimUrrf;
    String f56CpsimUrcd;
    String f56CpsimUrab;
    String f56CpsimUrat;
    String f56CpsimUser;
    String f56CpsimUpmj;
    String f56CpsimPid;

    TentacledColumns({
        this.f56CpsimDoco,
        this.f56CpsimLitm,
        this.f56CpsimMcu,
        this.f56CpsimPa8,
        this.f56CpsimOseq,
        this.f56CpsimAst,
        this.f56CpsimPefj,
        this.f56CpsimDmnq,
        this.f56CpsimMnq,
        this.f56CpsimUom,
        this.f56CpsimCrcd,
        this.f56CpsimEv01,
        this.f56CpsimItm,
        this.f56CpsimUprc,
        this.f56CpsimAexp,
        this.f56CpsimAprp1,
        this.f56CpsimAprp2,
        this.f56CpsimAprp3,
        this.f56CpsimAprp4,
        this.f56CpsimAprp5,
        this.f56CpsimAsn,
        this.f56CpsimFvtr,
        this.f56CpsimBscd,
        this.f56CpsimUrrf,
        this.f56CpsimUrcd,
        this.f56CpsimUrab,
        this.f56CpsimUrat,
        this.f56CpsimUser,
        this.f56CpsimUpmj,
        this.f56CpsimPid,
    });

    factory TentacledColumns.fromJson(Map<String, dynamic> json) => TentacledColumns(
        f56CpsimDoco: json["F56CPSIM_DOCO"],
        f56CpsimLitm: json["F56CPSIM_LITM"],
        f56CpsimMcu: json["F56CPSIM_MCU"],
        f56CpsimPa8: json["F56CPSIM_PA8"],
        f56CpsimOseq: json["F56CPSIM_OSEQ"],
        f56CpsimAst: json["F56CPSIM_AST"],
        f56CpsimPefj: json["F56CPSIM_PEFJ"],
        f56CpsimDmnq: json["F56CPSIM_DMNQ"],
        f56CpsimMnq: json["F56CPSIM_MNQ"],
        f56CpsimUom: json["F56CPSIM_UOM"],
        f56CpsimCrcd: json["F56CPSIM_CRCD"],
        f56CpsimEv01: json["F56CPSIM_EV01"],
        f56CpsimItm: json["F56CPSIM_ITM"],
        f56CpsimUprc: json["F56CPSIM_UPRC"],
        f56CpsimAexp: json["F56CPSIM_AEXP"],
        f56CpsimAprp1: json["F56CPSIM_APRP1"],
        f56CpsimAprp2: json["F56CPSIM_APRP2"],
        f56CpsimAprp3: json["F56CPSIM_APRP3"],
        f56CpsimAprp4: json["F56CPSIM_APRP4"],
        f56CpsimAprp5: json["F56CPSIM_APRP5"],
        f56CpsimAsn: json["F56CPSIM_ASN"],
        f56CpsimFvtr: json["F56CPSIM_FVTR"],
        f56CpsimBscd: json["F56CPSIM_BSCD"],
        f56CpsimUrrf: json["F56CPSIM_URRF"],
        f56CpsimUrcd: json["F56CPSIM_URCD"],
        f56CpsimUrab: json["F56CPSIM_URAB"],
        f56CpsimUrat: json["F56CPSIM_URAT"],
        f56CpsimUser: json["F56CPSIM_USER"],
        f56CpsimUpmj: json["F56CPSIM_UPMJ"],
        f56CpsimPid: json["F56CPSIM_PID"],
    );

    Map<String, dynamic> toJson() => {
        "F56CPSIM_DOCO": f56CpsimDoco,
        "F56CPSIM_LITM": f56CpsimLitm,
        "F56CPSIM_MCU": f56CpsimMcu,
        "F56CPSIM_PA8": f56CpsimPa8,
        "F56CPSIM_OSEQ": f56CpsimOseq,
        "F56CPSIM_AST": f56CpsimAst,
        "F56CPSIM_PEFJ": f56CpsimPefj,
        "F56CPSIM_DMNQ": f56CpsimDmnq,
        "F56CPSIM_MNQ": f56CpsimMnq,
        "F56CPSIM_UOM": f56CpsimUom,
        "F56CPSIM_CRCD": f56CpsimCrcd,
        "F56CPSIM_EV01": f56CpsimEv01,
        "F56CPSIM_ITM": f56CpsimItm,
        "F56CPSIM_UPRC": f56CpsimUprc,
        "F56CPSIM_AEXP": f56CpsimAexp,
        "F56CPSIM_APRP1": f56CpsimAprp1,
        "F56CPSIM_APRP2": f56CpsimAprp2,
        "F56CPSIM_APRP3": f56CpsimAprp3,
        "F56CPSIM_APRP4": f56CpsimAprp4,
        "F56CPSIM_APRP5": f56CpsimAprp5,
        "F56CPSIM_ASN": f56CpsimAsn,
        "F56CPSIM_FVTR": f56CpsimFvtr,
        "F56CPSIM_BSCD": f56CpsimBscd,
        "F56CPSIM_URRF": f56CpsimUrrf,
        "F56CPSIM_URCD": f56CpsimUrcd,
        "F56CPSIM_URAB": f56CpsimUrab,
        "F56CPSIM_URAT": f56CpsimUrat,
        "F56CPSIM_USER": f56CpsimUser,
        "F56CPSIM_UPMJ": f56CpsimUpmj,
        "F56CPSIM_PID": f56CpsimPid,
    };
}

class TentacledRowset {
    int f56CpsimDoco;
    String f56CpsimLitm;
    String f56CpsimMcu;
    int f56CpsimPa8;
    int f56CpsimOseq;
    String f56CpsimAst;
    String f56CpsimPefj;
    int f56CpsimDmnq;
    int f56CpsimMnq;
    String f56CpsimUom;
    String f56CpsimCrcd;
    String f56CpsimEv01;
    int f56CpsimItm;
    int f56CpsimUprc;
    int f56CpsimAexp;
    String f56CpsimAprp1;
    String f56CpsimAprp2;
    String f56CpsimAprp3;
    String f56CpsimAprp4;
    String f56CpsimAprp5;
    String f56CpsimAsn;
    int f56CpsimFvtr;
    String f56CpsimBscd;
    String f56CpsimUrrf;
    String f56CpsimUrcd;
    int f56CpsimUrab;
    int f56CpsimUrat;
    String f56CpsimUser;
    String f56CpsimUpmj;
    String f56CpsimPid;

    TentacledRowset({
        this.f56CpsimDoco,
        this.f56CpsimLitm,
        this.f56CpsimMcu,
        this.f56CpsimPa8,
        this.f56CpsimOseq,
        this.f56CpsimAst,
        this.f56CpsimPefj,
        this.f56CpsimDmnq,
        this.f56CpsimMnq,
        this.f56CpsimUom,
        this.f56CpsimCrcd,
        this.f56CpsimEv01,
        this.f56CpsimItm,
        this.f56CpsimUprc,
        this.f56CpsimAexp,
        this.f56CpsimAprp1,
        this.f56CpsimAprp2,
        this.f56CpsimAprp3,
        this.f56CpsimAprp4,
        this.f56CpsimAprp5,
        this.f56CpsimAsn,
        this.f56CpsimFvtr,
        this.f56CpsimBscd,
        this.f56CpsimUrrf,
        this.f56CpsimUrcd,
        this.f56CpsimUrab,
        this.f56CpsimUrat,
        this.f56CpsimUser,
        this.f56CpsimUpmj,
        this.f56CpsimPid,
    });

    factory TentacledRowset.fromJson(Map<String, dynamic> json) => TentacledRowset(
        f56CpsimDoco: json["F56CPSIM_DOCO"],
        f56CpsimLitm: json["F56CPSIM_LITM"],
        f56CpsimMcu: json["F56CPSIM_MCU"],
        f56CpsimPa8: json["F56CPSIM_PA8"],
        f56CpsimOseq: json["F56CPSIM_OSEQ"],
        f56CpsimAst: json["F56CPSIM_AST"],
        f56CpsimPefj: json["F56CPSIM_PEFJ"],
        f56CpsimDmnq: json["F56CPSIM_DMNQ"],
        f56CpsimMnq: json["F56CPSIM_MNQ"],
        f56CpsimUom: json["F56CPSIM_UOM"],
        f56CpsimCrcd: json["F56CPSIM_CRCD"],
        f56CpsimEv01: json["F56CPSIM_EV01"],
        f56CpsimItm: json["F56CPSIM_ITM"],
        f56CpsimUprc: json["F56CPSIM_UPRC"],
        f56CpsimAexp: json["F56CPSIM_AEXP"],
        f56CpsimAprp1: json["F56CPSIM_APRP1"],
        f56CpsimAprp2: json["F56CPSIM_APRP2"],
        f56CpsimAprp3: json["F56CPSIM_APRP3"],
        f56CpsimAprp4: json["F56CPSIM_APRP4"],
        f56CpsimAprp5: json["F56CPSIM_APRP5"],
        f56CpsimAsn: json["F56CPSIM_ASN"],
        f56CpsimFvtr: json["F56CPSIM_FVTR"],
        f56CpsimBscd: json["F56CPSIM_BSCD"],
        f56CpsimUrrf: json["F56CPSIM_URRF"],
        f56CpsimUrcd: json["F56CPSIM_URCD"],
        f56CpsimUrab: json["F56CPSIM_URAB"],
        f56CpsimUrat: json["F56CPSIM_URAT"],
        f56CpsimUser: json["F56CPSIM_USER"],
        f56CpsimUpmj: json["F56CPSIM_UPMJ"],
        f56CpsimPid: json["F56CPSIM_PID"],
    );

    Map<String, dynamic> toJson() => {
        "F56CPSIM_DOCO": f56CpsimDoco,
        "F56CPSIM_LITM": f56CpsimLitm,
        "F56CPSIM_MCU": f56CpsimMcu,
        "F56CPSIM_PA8": f56CpsimPa8,
        "F56CPSIM_OSEQ": f56CpsimOseq,
        "F56CPSIM_AST": f56CpsimAst,
        "F56CPSIM_PEFJ": f56CpsimPefj,
        "F56CPSIM_DMNQ": f56CpsimDmnq,
        "F56CPSIM_MNQ": f56CpsimMnq,
        "F56CPSIM_UOM": f56CpsimUom,
        "F56CPSIM_CRCD": f56CpsimCrcd,
        "F56CPSIM_EV01": f56CpsimEv01,
        "F56CPSIM_ITM": f56CpsimItm,
        "F56CPSIM_UPRC": f56CpsimUprc,
        "F56CPSIM_AEXP": f56CpsimAexp,
        "F56CPSIM_APRP1": f56CpsimAprp1,
        "F56CPSIM_APRP2": f56CpsimAprp2,
        "F56CPSIM_APRP3": f56CpsimAprp3,
        "F56CPSIM_APRP4": f56CpsimAprp4,
        "F56CPSIM_APRP5": f56CpsimAprp5,
        "F56CPSIM_ASN": f56CpsimAsn,
        "F56CPSIM_FVTR": f56CpsimFvtr,
        "F56CPSIM_BSCD": f56CpsimBscd,
        "F56CPSIM_URRF": f56CpsimUrrf,
        "F56CPSIM_URCD": f56CpsimUrcd,
        "F56CPSIM_URAB": f56CpsimUrab,
        "F56CPSIM_URAT": f56CpsimUrat,
        "F56CPSIM_USER": f56CpsimUser,
        "F56CPSIM_UPMJ": f56CpsimUpmj,
        "F56CPSIM_PID": f56CpsimPid,
    };
}

class ServiceRequest6 {
    FsP4074W4074D fsP4074W4074D;
    int stackId;
    int stateId;
    String rid;
    String currentApp;
    String timeStamp;
    List<dynamic> sysErrors;

    ServiceRequest6({
        this.fsP4074W4074D,
        this.stackId,
        this.stateId,
        this.rid,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
    });

    factory ServiceRequest6.fromJson(Map<String, dynamic> json) => ServiceRequest6(
        fsP4074W4074D: FsP4074W4074D.fromJson(json["fs_P4074_W4074D"]),
        stackId: json["stackId"],
        stateId: json["stateId"],
        rid: json["rid"],
        currentApp: json["currentApp"],
        timeStamp: json["timeStamp"],
        sysErrors: List<dynamic>.from(json["sysErrors"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "fs_P4074_W4074D": fsP4074W4074D.toJson(),
        "stackId": stackId,
        "stateId": stateId,
        "rid": rid,
        "currentApp": currentApp,
        "timeStamp": timeStamp,
        "sysErrors": List<dynamic>.from(sysErrors.map((x) => x)),
    };
}

class FsP4074W4074D {
    String title;
    FsP4074W4074DData data;
    List<dynamic> errors;
    List<dynamic> warnings;

    FsP4074W4074D({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsP4074W4074D.fromJson(Map<String, dynamic> json) => FsP4074W4074D(
        title: json["title"],
        data: FsP4074W4074DData.fromJson(json["data"]),
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

class FsP4074W4074DData {
    ZUprc44 zUprc44;
    StickyGridData gridData;

    FsP4074W4074DData({
        this.zUprc44,
        this.gridData,
    });

    factory FsP4074W4074DData.fromJson(Map<String, dynamic> json) => FsP4074W4074DData(
        zUprc44: ZUprc44.fromJson(json["z_UPRC_44"]),
        gridData: StickyGridData.fromJson(json["gridData"]),
    );

    Map<String, dynamic> toJson() => {
        "z_UPRC_44": zUprc44.toJson(),
        "gridData": gridData.toJson(),
    };
}

class StickyGridData {
    int id;
    String fullGridId;
    StickyColumns columns;
    List<StickyRowset> rowset;
    Summary summary;

    StickyGridData({
        this.id,
        this.fullGridId,
        this.columns,
        this.rowset,
        this.summary,
    });

    factory StickyGridData.fromJson(Map<String, dynamic> json) => StickyGridData(
        id: json["id"],
        fullGridId: json["fullGridId"],
        columns: StickyColumns.fromJson(json["columns"]),
        rowset: List<StickyRowset>.from(json["rowset"].map((x) => StickyRowset.fromJson(x))),
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

class StickyColumns {
    String zAst88;
    String zDl01108;
    String zOseq87;
    String zFvtr93;
    String zUprc95;
    String zBscd97;
    String zAsn86;
    String zAdjqty213;
    String zAdjcal155;
    String zBsdval154;
    String zAdjref175;
    String zLedg113;
    String zDl02109;
    String zDl03114;
    String zAlph112;
    String zAdjgrp163;
    String zFvum110;
    String zPa08176;
    String zFup96;
    String zMded123;
    String zMnmxaj221;
    String zDl01222;
    String zMeadj162;
    String zStprcf210;
    String zAbas117;
    String zPmtn165;
    String zDl01167;
    String zArsn111;
    String zQtypy212;

    StickyColumns({
        this.zAst88,
        this.zDl01108,
        this.zOseq87,
        this.zFvtr93,
        this.zUprc95,
        this.zBscd97,
        this.zAsn86,
        this.zAdjqty213,
        this.zAdjcal155,
        this.zBsdval154,
        this.zAdjref175,
        this.zLedg113,
        this.zDl02109,
        this.zDl03114,
        this.zAlph112,
        this.zAdjgrp163,
        this.zFvum110,
        this.zPa08176,
        this.zFup96,
        this.zMded123,
        this.zMnmxaj221,
        this.zDl01222,
        this.zMeadj162,
        this.zStprcf210,
        this.zAbas117,
        this.zPmtn165,
        this.zDl01167,
        this.zArsn111,
        this.zQtypy212,
    });

    factory StickyColumns.fromJson(Map<String, dynamic> json) => StickyColumns(
        zAst88: json["z_AST_88"],
        zDl01108: json["z_DL01_108"],
        zOseq87: json["z_OSEQ_87"],
        zFvtr93: json["z_FVTR_93"],
        zUprc95: json["z_UPRC_95"],
        zBscd97: json["z_BSCD_97"],
        zAsn86: json["z_ASN_86"],
        zAdjqty213: json["z_ADJQTY_213"],
        zAdjcal155: json["z_ADJCAL_155"],
        zBsdval154: json["z_BSDVAL_154"],
        zAdjref175: json["z_ADJREF_175"],
        zLedg113: json["z_LEDG_113"],
        zDl02109: json["z_DL02_109"],
        zDl03114: json["z_DL03_114"],
        zAlph112: json["z_ALPH_112"],
        zAdjgrp163: json["z_ADJGRP_163"],
        zFvum110: json["z_FVUM_110"],
        zPa08176: json["z_PA08_176"],
        zFup96: json["z_FUP_96"],
        zMded123: json["z_MDED_123"],
        zMnmxaj221: json["z_MNMXAJ_221"],
        zDl01222: json["z_DL01_222"],
        zMeadj162: json["z_MEADJ_162"],
        zStprcf210: json["z_STPRCF_210"],
        zAbas117: json["z_ABAS_117"],
        zPmtn165: json["z_PMTN_165"],
        zDl01167: json["z_DL01_167"],
        zArsn111: json["z_ARSN_111"],
        zQtypy212: json["z_QTYPY_212"],
    );

    Map<String, dynamic> toJson() => {
        "z_AST_88": zAst88,
        "z_DL01_108": zDl01108,
        "z_OSEQ_87": zOseq87,
        "z_FVTR_93": zFvtr93,
        "z_UPRC_95": zUprc95,
        "z_BSCD_97": zBscd97,
        "z_ASN_86": zAsn86,
        "z_ADJQTY_213": zAdjqty213,
        "z_ADJCAL_155": zAdjcal155,
        "z_BSDVAL_154": zBsdval154,
        "z_ADJREF_175": zAdjref175,
        "z_LEDG_113": zLedg113,
        "z_DL02_109": zDl02109,
        "z_DL03_114": zDl03114,
        "z_ALPH_112": zAlph112,
        "z_ADJGRP_163": zAdjgrp163,
        "z_FVUM_110": zFvum110,
        "z_PA08_176": zPa08176,
        "z_FUP_96": zFup96,
        "z_MDED_123": zMded123,
        "z_MNMXAJ_221": zMnmxaj221,
        "z_DL01_222": zDl01222,
        "z_MEADJ_162": zMeadj162,
        "z_STPRCF_210": zStprcf210,
        "z_ABAS_117": zAbas117,
        "z_PMTN_165": zPmtn165,
        "z_DL01_167": zDl01167,
        "z_ARSN_111": zArsn111,
        "z_QTYPY_212": zQtypy212,
    };
}

class StickyRowset {
    String zAst88;
    String zDl01108;
    int zOseq87;
    int zFvtr93;
    int zUprc95;
    String zBscd97;
    String zAsn86;
    String zAdjqty213;
    String zAdjcal155;
    int zBsdval154;
    String zAdjref175;
    String zLedg113;
    String zDl02109;
    String zDl03114;
    String zAlph112;
    String zAdjgrp163;
    String zFvum110;
    String zPa08176;
    int zFup96;
    String zMded123;
    String zMnmxaj221;
    String zDl01222;
    String zMeadj162;
    String zStprcf210;
    String zAbas117;
    String zPmtn165;
    String zDl01167;
    String zArsn111;
    int zQtypy212;

    StickyRowset({
        this.zAst88,
        this.zDl01108,
        this.zOseq87,
        this.zFvtr93,
        this.zUprc95,
        this.zBscd97,
        this.zAsn86,
        this.zAdjqty213,
        this.zAdjcal155,
        this.zBsdval154,
        this.zAdjref175,
        this.zLedg113,
        this.zDl02109,
        this.zDl03114,
        this.zAlph112,
        this.zAdjgrp163,
        this.zFvum110,
        this.zPa08176,
        this.zFup96,
        this.zMded123,
        this.zMnmxaj221,
        this.zDl01222,
        this.zMeadj162,
        this.zStprcf210,
        this.zAbas117,
        this.zPmtn165,
        this.zDl01167,
        this.zArsn111,
        this.zQtypy212,
    });

    factory StickyRowset.fromJson(Map<String, dynamic> json) => StickyRowset(
        zAst88: json["z_AST_88"],
        zDl01108: json["z_DL01_108"],
        zOseq87: json["z_OSEQ_87"],
        zFvtr93: json["z_FVTR_93"],
        zUprc95: json["z_UPRC_95"],
        zBscd97: json["z_BSCD_97"],
        zAsn86: json["z_ASN_86"],
        zAdjqty213: json["z_ADJQTY_213"],
        zAdjcal155: json["z_ADJCAL_155"],
        zBsdval154: json["z_BSDVAL_154"],
        zAdjref175: json["z_ADJREF_175"],
        zLedg113: json["z_LEDG_113"],
        zDl02109: json["z_DL02_109"],
        zDl03114: json["z_DL03_114"],
        zAlph112: json["z_ALPH_112"],
        zAdjgrp163: json["z_ADJGRP_163"],
        zFvum110: json["z_FVUM_110"],
        zPa08176: json["z_PA08_176"],
        zFup96: json["z_FUP_96"],
        zMded123: json["z_MDED_123"],
        zMnmxaj221: json["z_MNMXAJ_221"],
        zDl01222: json["z_DL01_222"],
        zMeadj162: json["z_MEADJ_162"],
        zStprcf210: json["z_STPRCF_210"],
        zAbas117: json["z_ABAS_117"],
        zPmtn165: json["z_PMTN_165"],
        zDl01167: json["z_DL01_167"],
        zArsn111: json["z_ARSN_111"],
        zQtypy212: json["z_QTYPY_212"],
    );

    Map<String, dynamic> toJson() => {
        "z_AST_88": zAst88,
        "z_DL01_108": zDl01108,
        "z_OSEQ_87": zOseq87,
        "z_FVTR_93": zFvtr93,
        "z_UPRC_95": zUprc95,
        "z_BSCD_97": zBscd97,
        "z_ASN_86": zAsn86,
        "z_ADJQTY_213": zAdjqty213,
        "z_ADJCAL_155": zAdjcal155,
        "z_BSDVAL_154": zBsdval154,
        "z_ADJREF_175": zAdjref175,
        "z_LEDG_113": zLedg113,
        "z_DL02_109": zDl02109,
        "z_DL03_114": zDl03114,
        "z_ALPH_112": zAlph112,
        "z_ADJGRP_163": zAdjgrp163,
        "z_FVUM_110": zFvum110,
        "z_PA08_176": zPa08176,
        "z_FUP_96": zFup96,
        "z_MDED_123": zMded123,
        "z_MNMXAJ_221": zMnmxaj221,
        "z_DL01_222": zDl01222,
        "z_MEADJ_162": zMeadj162,
        "z_STPRCF_210": zStprcf210,
        "z_ABAS_117": zAbas117,
        "z_PMTN_165": zPmtn165,
        "z_DL01_167": zDl01167,
        "z_ARSN_111": zArsn111,
        "z_QTYPY_212": zQtypy212,
    };
}

class ZUprc44 {
    String title;
    int value;

    ZUprc44({
        this.title,
        this.value,
    });

    factory ZUprc44.fromJson(Map<String, dynamic> json) => ZUprc44(
        title: json["title"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
    };
}
