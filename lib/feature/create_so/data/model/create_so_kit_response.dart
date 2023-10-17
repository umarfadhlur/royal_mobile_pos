// To parse this JSON data, do
//
//     final createSoKitResponseModel = createSoKitResponseModelFromJson(jsonString);

import 'dart:convert';

CreateSoKitResponseModel createSoKitResponseModelFromJson(String str) => CreateSoKitResponseModel.fromJson(json.decode(str));

String createSoKitResponseModelToJson(CreateSoKitResponseModel data) => json.encode(data.toJson());

class CreateSoKitResponseModel {
    final ServiceRequest1 serviceRequest1;
    final ServiceRequest2 serviceRequest2;
    final List<ErrorsWarning> errorsWarnings;
    final List<ContinuedOnError> continuedOnError;
    final String jdeSimpleMessage;
    final String jdeStatus;
    final String jdeStartTimestamp;
    final String jdeEndTimestamp;
    final double jdeServerExecutionSeconds;

    CreateSoKitResponseModel({
        this.serviceRequest1,
        this.serviceRequest2,
        this.errorsWarnings,
        this.continuedOnError,
        this.jdeSimpleMessage,
        this.jdeStatus,
        this.jdeStartTimestamp,
        this.jdeEndTimestamp,
        this.jdeServerExecutionSeconds,
    });

    factory CreateSoKitResponseModel.fromJson(Map<String, dynamic> json) => CreateSoKitResponseModel(
        serviceRequest1: ServiceRequest1.fromJson(json["ServiceRequest1"]),
        serviceRequest2: ServiceRequest2.fromJson(json["ServiceRequest2"]),
        errorsWarnings: List<ErrorsWarning>.from(json["Errors/Warnings"].map((x) => ErrorsWarning.fromJson(x))),
        continuedOnError: List<ContinuedOnError>.from(json["continuedOnError"].map((x) => ContinuedOnError.fromJson(x))),
        jdeSimpleMessage: json["jde__simpleMessage"],
        jdeStatus: json["jde__status"],
        jdeStartTimestamp: json["jde__startTimestamp"],
        jdeEndTimestamp: json["jde__endTimestamp"],
        jdeServerExecutionSeconds: json["jde__serverExecutionSeconds"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ServiceRequest1": serviceRequest1.toJson(),
        "ServiceRequest2": serviceRequest2.toJson(),
        "Errors/Warnings": List<dynamic>.from(errorsWarnings.map((x) => x.toJson())),
        "continuedOnError": List<dynamic>.from(continuedOnError.map((x) => x.toJson())),
        "jde__simpleMessage": jdeSimpleMessage,
        "jde__status": jdeStatus,
        "jde__startTimestamp": jdeStartTimestamp,
        "jde__endTimestamp": jdeEndTimestamp,
        "jde__serverExecutionSeconds": jdeServerExecutionSeconds,
    };
}

class ContinuedOnError {
    final String step;
    final String message;
    final String timeStamp;
    final String userDefinedErrorText;
    final String type;

    ContinuedOnError({
        this.step,
        this.message,
        this.timeStamp,
        this.userDefinedErrorText,
        this.type,
    });

    factory ContinuedOnError.fromJson(Map<String, dynamic> json) => ContinuedOnError(
        step: json["step"],
        message: json["message"],
        timeStamp: json["timeStamp"],
        userDefinedErrorText: json["userDefinedErrorText"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "step": step,
        "message": message,
        "timeStamp": timeStamp,
        "userDefinedErrorText": userDefinedErrorText,
        "type": type,
    };
}

class ErrorsWarning {
    final String applicationId;
    final String title;
    final List<dynamic> errors;
    final List<Warning> warnings;

    ErrorsWarning({
        this.applicationId,
        this.title,
        this.errors,
        this.warnings,
    });

    factory ErrorsWarning.fromJson(Map<String, dynamic> json) => ErrorsWarning(
        applicationId: json["Application ID"],
        title: json["Title"],
        errors: List<dynamic>.from(json["Errors"].map((x) => x)),
        warnings: List<Warning>.from(json["Warnings"].map((x) => Warning.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Application ID": applicationId,
        "Title": title,
        "Errors": List<dynamic>.from(errors.map((x) => x)),
        "Warnings": List<dynamic>.from(warnings.map((x) => x.toJson())),
    };
}

class Warning {
    final String code;
    final String title;
    final String errorcontrol;
    final String desc;
    final String mobile;

    Warning({
        this.code,
        this.title,
        this.errorcontrol,
        this.desc,
        this.mobile,
    });

    factory Warning.fromJson(Map<String, dynamic> json) => Warning(
        code: json["CODE"],
        title: json["TITLE"],
        errorcontrol: json["ERRORCONTROL"],
        desc: json["DESC"],
        mobile: json["MOBILE"],
    );

    Map<String, dynamic> toJson() => {
        "CODE": code,
        "TITLE": title,
        "ERRORCONTROL": errorcontrol,
        "DESC": desc,
        "MOBILE": mobile,
    };
}

class ServiceRequest1 {
    final List<Form> forms;

    ServiceRequest1({
        this.forms,
    });

    factory ServiceRequest1.fromJson(Map<String, dynamic> json) => ServiceRequest1(
        forms: List<Form>.from(json["forms"].map((x) => Form.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
    };
}

class Form {
    final FsP4210W4210G fsP4210W4210G;
    final int stackId;
    final int stateId;
    final String rid;
    final String currentApp;
    final String timeStamp;
    final List<dynamic> sysErrors;
    final FsP fsP4210W4210A;
    final FsP41351W41351A fsP41351W41351A;
    final FsP fsP986162W986162B;

    Form({
        this.fsP4210W4210G,
        this.stackId,
        this.stateId,
        this.rid,
        this.currentApp,
        this.timeStamp,
        this.sysErrors,
        this.fsP4210W4210A,
        this.fsP41351W41351A,
        this.fsP986162W986162B,
    });

    factory Form.fromJson(Map<String, dynamic> json) => Form(
        fsP4210W4210G: FsP4210W4210G.fromJson(json["fs_P4210_W4210G"]),
        stackId: json["stackId"],
        stateId: json["stateId"],
        rid: json["rid"],
        currentApp: json["currentApp"],
        timeStamp: json["timeStamp"],
        sysErrors: List<dynamic>.from(json["sysErrors"].map((x) => x)),
        fsP4210W4210A: FsP.fromJson(json["fs_P4210_W4210A"]),
        fsP41351W41351A: FsP41351W41351A.fromJson(json["fs_P41351_W41351A"]),
        fsP986162W986162B: FsP.fromJson(json["fs_P986162_W986162B"]),
    );

    Map<String, dynamic> toJson() => {
        "fs_P4210_W4210G": fsP4210W4210G.toJson(),
        "stackId": stackId,
        "stateId": stateId,
        "rid": rid,
        "currentApp": currentApp,
        "timeStamp": timeStamp,
        "sysErrors": List<dynamic>.from(sysErrors.map((x) => x)),
        "fs_P4210_W4210A": fsP4210W4210A.toJson(),
        "fs_P41351_W41351A": fsP41351W41351A.toJson(),
        "fs_P986162_W986162B": fsP986162W986162B.toJson(),
    };
}

class FsP41351W41351A {
    final String title;
    final FsP41351W41351AData data;
    final List<dynamic> errors;
    final List<Warning> warnings;

    FsP41351W41351A({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsP41351W41351A.fromJson(Map<String, dynamic> json) => FsP41351W41351A(
        title: json["title"],
        data: FsP41351W41351AData.fromJson(json["data"]),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        warnings: List<Warning>.from(json["warnings"].map((x) => Warning.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "data": data.toJson(),
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "warnings": List<dynamic>.from(warnings.map((x) => x.toJson())),
    };
}

class FsP41351W41351AData {
    FsP41351W41351AData();

    factory FsP41351W41351AData.fromJson(Map<String, dynamic> json) => FsP41351W41351AData(
    );

    Map<String, dynamic> toJson() => {
    };
}

class FsP {
    final String title;
    final FsP41351W41351AData data;
    final List<dynamic> errors;
    final List<dynamic> warnings;

    FsP({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsP.fromJson(Map<String, dynamic> json) => FsP(
        title: json["title"],
        data: FsP41351W41351AData.fromJson(json["data"]),
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

class FsP4210W4210G {
    final String title;
    final FsP4210W4210GData data;
    final List<dynamic> errors;
    final List<dynamic> warnings;

    FsP4210W4210G({
        this.title,
        this.data,
        this.errors,
        this.warnings,
    });

    factory FsP4210W4210G.fromJson(Map<String, dynamic> json) => FsP4210W4210G(
        title: json["title"],
        data: FsP4210W4210GData.fromJson(json["data"]),
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

class FsP4210W4210GData {
    final ZDoco102 zDoco102;
    final ZDcto104 zEkco379;
    final ZDcto104 zDcto104;

    FsP4210W4210GData({
        this.zDoco102,
        this.zEkco379,
        this.zDcto104,
    });

    factory FsP4210W4210GData.fromJson(Map<String, dynamic> json) => FsP4210W4210GData(
        zDoco102: ZDoco102.fromJson(json["z_DOCO_102"]),
        zEkco379: ZDcto104.fromJson(json["z_EKCO_379"]),
        zDcto104: ZDcto104.fromJson(json["z_DCTO_104"]),
    );

    Map<String, dynamic> toJson() => {
        "z_DOCO_102": zDoco102.toJson(),
        "z_EKCO_379": zEkco379.toJson(),
        "z_DCTO_104": zDcto104.toJson(),
    };
}

class ZDcto104 {
    final String title;
    final String value;

    ZDcto104({
        this.title,
        this.value,
    });

    factory ZDcto104.fromJson(Map<String, dynamic> json) => ZDcto104(
        title: json["title"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
    };
}

class ZDoco102 {
    final String title;
    final int value;

    ZDoco102({
        this.title,
        this.value,
    });

    factory ZDoco102.fromJson(Map<String, dynamic> json) => ZDoco102(
        title: json["title"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
    };
}

class ServiceRequest2 {
    final bool submitted;
    final List<Output> output;
    final List<dynamic> error;
    final dynamic diagnostics;

    ServiceRequest2({
        this.submitted,
        this.output,
        this.error,
        this.diagnostics,
    });

    factory ServiceRequest2.fromJson(Map<String, dynamic> json) => ServiceRequest2(
        submitted: json["submitted"],
        output: List<Output>.from(json["output"].map((x) => Output.fromJson(x))),
        error: List<dynamic>.from(json["error"].map((x) => x)),
        diagnostics: json["diagnostics"],
    );

    Map<String, dynamic> toJson() => {
        "submitted": submitted,
        "output": List<dynamic>.from(output.map((x) => x.toJson())),
        "error": List<dynamic>.from(error.map((x) => x)),
        "diagnostics": diagnostics,
    };
}

class Output {
    final int id;
    final dynamic value;

    Output({
        this.id,
        this.value,
    });

    factory Output.fromJson(Map<String, dynamic> json) => Output(
        id: json["id"],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "value": value,
    };
}
