import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/feature/work_order_list/data/model/get_an8_response.dart';
import 'package:royal_mobile_pos/feature/work_order_list/data/model/work_order_list_response.dart';

abstract class WorkOrderListRepository {
  Future<String> getValueAN8(Map data);
  Future<List<WOList>> getList(Map data);
}

class WorkOrderListRepositoryImpl implements WorkOrderListRepository {
  Future<String> getValueAN8(Map data) async {
    String an8;

    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.getAN8,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final userInfo = GetAn8Response.fromJson(data);
      an8 = userInfo.rudGetan8P0092Dr.rowset.first.addressNumber;
      print("data user ${userInfo.rudGetan8P0092Dr.rowset}");
      return an8;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<WOList>> getList(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.getWOList,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<WOList> rowset =
          WorkOrderListResponse.fromJson(dataa).rudListwoF4801Dr.rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }
}
