import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/feature/equipment_number/data/model/equipment_response.dart';
import 'package:royal_mobile_pos/feature/equipment_number/data/model/find_equipment_response.dart';

abstract class EquipmentNumberRepository {
  Future<ResponseFindEquipment> findEquipment(Map paramsFindEquipment);
  Future<ResponseEquipment> getLongLat(Map paramsGetEquipment);
  Future<ResponseEquipment> updateLongLat(Map paramsUpdateEquipment);
}

class EquipmentNumberRepositoryIml implements EquipmentNumberRepository {
  @override
  Future<ResponseFindEquipment> findEquipment(Map paramsFindEquipment) async {
    ResponseFindEquipment responseFindEquipment;
    var jsonParam = jsonEncode(paramsFindEquipment);
    var response = await http.post(EndPoint.findEquipment,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      responseFindEquipment = ResponseFindEquipment.fromJson(data);
      return responseFindEquipment;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseEquipment> getLongLat(Map paramsGetEquipment) async {
    ResponseEquipment responseEquipment;
    var jsonParam = jsonEncode(paramsGetEquipment);
    var response = await http.post(EndPoint.getLongLatEquipment,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      responseEquipment = ResponseEquipment.fromJson(data);
      return responseEquipment;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseEquipment> updateLongLat(Map paramsUpdateEquipment) async {
    ResponseEquipment responseEquipment;
    var jsonParam = jsonEncode(paramsUpdateEquipment);
    var response = await http.post(EndPoint.updateEquipment,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      responseEquipment = ResponseEquipment.fromJson(data);
      return responseEquipment;
    } else {
      throw Exception();
    }
  }
}
