// To parse this JSON data, do
//
//     final paramsCountWo = paramsCountWoFromJson(jsonString);

import 'dart:convert';

ParamsCountWo paramsCountWoFromJson(String str) => ParamsCountWo.fromJson(json.decode(str));

String paramsCountWoToJson(ParamsCountWo data) => json.encode(data.toJson());

class ParamsCountWo {
    ParamsCountWo({
        this.token,
        this.detailInputs,
    });

    String token;
    List<DetailInput> detailInputs;

    factory ParamsCountWo.fromJson(Map<String, dynamic> json) => ParamsCountWo(
        token: json["token"],
        detailInputs: List<DetailInput>.from(json["detailInputs"].map((x) => DetailInput.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "detailInputs": List<dynamic>.from(detailInputs.map((x) => x.toJson())),
    };
}

class DetailInput {
    DetailInput({
        this.name,
        this.repeatingInputs,
    });

    String name;
    List<RepeatingInput> repeatingInputs;

    factory DetailInput.fromJson(Map<String, dynamic> json) => DetailInput(
        name: json["name"],
        repeatingInputs: List<RepeatingInput>.from(json["repeatingInputs"].map((x) => RepeatingInput.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "repeatingInputs": List<dynamic>.from(repeatingInputs.map((x) => x.toJson())),
    };
}

class RepeatingInput {
    RepeatingInput({
        this.inputs,
    });

    List<InputCountWO> inputs;

    factory RepeatingInput.fromJson(Map<String, dynamic> json) => RepeatingInput(
        inputs: List<InputCountWO>.from(json["inputs"].map((x) => InputCountWO.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "inputs": List<dynamic>.from(inputs.map((x) => x.toJson())),
    };
}

class InputCountWO {
    InputCountWO({
        this.name,
        this.value,
    });

    Name name;
    String value;

    factory InputCountWO.fromJson(Map<String, dynamic> json) => InputCountWO(
        name: nameValues.map[json["name"]],
        value: json["value"],
    );

    Map<String, dynamic> toJson() => {
        "name": nameValues.reverse[name],
        "value": value,
    };
}

enum Name { CUSTOMER_NUMBER, WO_TYPE }

final nameValues = EnumValues({
    "Customer Number": Name.CUSTOMER_NUMBER,
    "WO Type": Name.WO_TYPE
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
