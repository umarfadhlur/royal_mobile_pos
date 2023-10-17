import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/bom/data/model/bom_response.dart';
import 'package:http/http.dart' as http;

abstract class BomRepository {
  Future<List<Rowset>> bomList(Map data);
}

class BomRepositoryImpl extends BomRepository {
  @override
  Future<List<Rowset>> bomList(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.bom,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<Rowset> rowset =
          BomResponse.fromJson(dataa).serviceRequest1.fsDatabrowseF3002.data.gridData.rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }
}
