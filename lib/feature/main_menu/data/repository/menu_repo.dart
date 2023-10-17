import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/feature/main_menu/data/model/count_wo_response.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/get_an8_response.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/watchlist_count_wo_response.dart';

abstract class MenuRepository {
  Future<String> getValueAN8(Map inputAn8);
  Future<ResponseCountWo> getCountWO(Map countWO);
  Future<ResponseWatchlistCountWo> getWatchList(Map watchList);
}

class MenuRepositoryImpl implements MenuRepository {
  @override
  Future<String> getValueAN8(Map inputAn8) async {
    String an8;

    var jsonParam = jsonEncode(inputAn8);
    var response = await http.post(EndPoint.getAN8,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final userInfo = GetAn8.fromJson(data);
      an8 = userInfo.rudGetan8P0092Dr.rowset.first.addressNumber;
      print("data user ${userInfo.rudGetan8P0092Dr.rowset}");
      return an8;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseCountWo> getCountWO(Map countWO) async {
    ResponseCountWo responseCountWo;

    var jsonParam = jsonEncode(countWO);
    var response = await http.post(EndPoint.getListChart,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final userInfo = ResponseCountWo.fromJson(data);
      return userInfo;
    } else {
      throw Exception();
    }
  }

  @override
  Future<ResponseWatchlistCountWo> getWatchList(Map watchList) async {
    ResponseWatchlistCountWo responseWatchlistCountWo;

    var jsonParam = jsonEncode(watchList);
    var response = await http.post(EndPoint.getWatch,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final userInfo = ResponseWatchlistCountWo.fromJson(data);
      print(userInfo.rudCountwoF4801Dr.rowset.first.countWo);
      return userInfo;
    } else {
      throw Exception();
    }
  }
}
