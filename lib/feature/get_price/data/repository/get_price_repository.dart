import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/get_price/data/model/get_price_response.dart';
import 'package:http/http.dart' as http;

abstract class GetPriceRepository {
  Future<List<PriceList>> getPriceList(Map data);
}

class GetPriceRepositoryImpl extends GetPriceRepository {
  @override
  Future<List<PriceList>> getPriceList(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.getPriceList,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<PriceList> rowset =
          GetPriceResponseModel.fromJson(dataa).rudGetpriceP4074Fr1.rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }
}
