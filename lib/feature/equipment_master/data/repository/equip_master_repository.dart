import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/feature/equipment_master/data/model/equip_master_detail_response.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/model/equip_master_response.dart';

abstract class EquipMasterRepository {
  Future<List<EMList>> getList(Map data);
  Future<List<DetailList>> getDetail(Map data);
}

class EquipMasterRepositoryImpl extends EquipMasterRepository {
  @override
  Future<List<EMList>> getList(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.getEMList,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<EMList> rowset =
          EquipMasterResponseModel.fromJson(dataa).hdnEquipMasterSvr.rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<DetailList>> getDetail(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.getDetailList,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<DetailList> rowset = EquipMasterDetailResponseModel.fromJson(dataa)
          .equipMasterDetailHdn
          .rowset;
      print("data detail $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }
}
