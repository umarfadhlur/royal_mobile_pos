import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/create_so_kit_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/create_so_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/get_so_detail.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/get_so_history.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/item_branch_response.dart';
import 'package:royal_mobile_pos/feature/customer/data/model/get_customer_response.dart';
import 'package:royal_mobile_pos/feature/get_price/data/model/get_price_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_new_response.dart';
import 'package:http/http.dart' as http;

abstract class CreateSoRepository {
  Future<CreateSoResponseModel> soEntry(Map data);
  Future<CreateSoKitResponseModel> soKitEntry(Map data);
  Future<List<PriceList>> getPriceList(Map data);
  Future<List<RudGetpriceP4074Fr1Rowset>> getPriceHistory(Map data);
  Future<List<ArdF56CpfreRowset>> getFreeGoods(Map data);
  Future<List<ItemBranch>> getItemBranch(Map data);
  Future<FreeGoodsGetPriceResponse> getFreeGoodsPriceHistory(Map data);
  Future<FreeGoodsGetPriceResponseNew> getFreeGoodsPriceHistoryNew(Map data);
  Future<List<GetSoDetail>> getSoDetail(int soHeaderId);
  Future<List<GetSoHistory>> getSoHistory();
  Future<String> postDataHistory(Map data);
  Future<String> postDataHistoryNew(Map data);
  Future<List<GetCustomerResponse>> getCustomer();
}

class CreateSoRepositoryImpl extends CreateSoRepository {
  @override
  Future<CreateSoResponseModel> soEntry(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.createSO,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final previousOrder = CreateSoResponseModel.fromJson(data);
      print('previousOrder: ${previousOrder.previousOrder}');
      return previousOrder;
    } else {
      throw Exception();
    }
  }

  @override
  Future<CreateSoKitResponseModel> soKitEntry(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.createSOKit,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final previousOrder = CreateSoKitResponseModel.fromJson(data);
      print('previousOrder: ${previousOrder.continuedOnError}');
      return previousOrder;
    } else {
      throw Exception();
    }
  }

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

  @override
  Future<List<ArdF56CpfreRowset>> getFreeGoods(Map data) async {
    var jsonParam = jsonEncode(data);

    var response = await http.post(EndPoint.freeGoodsPriceHistory,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<ArdF56CpfreRowset> rowset =
          FreeGoodsGetPriceResponse.fromJson(dataa).ardF56Cpfre.rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<RudGetpriceP4074Fr1Rowset>> getPriceHistory(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.freeGoodsPriceHistory,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<RudGetpriceP4074Fr1Rowset> rowset =
          FreeGoodsGetPriceResponse.fromJson(dataa).rudGetpriceP4074Fr1.rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<ItemBranch>> getItemBranch(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.itemBranch,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<ItemBranch> rowset = ItemBranchResponse.fromJson(dataa)
          .serviceRequest1
          .fsDatabrowseF4102
          .data
          .gridData
          .rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }

  @override
  Future<FreeGoodsGetPriceResponse> getFreeGoodsPriceHistory(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.freeGoodsPriceHistory,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      final freeGoodsResponse = FreeGoodsGetPriceResponse.fromJson(dataa);
      print('data $freeGoodsResponse');
      return freeGoodsResponse;
    } else {
      throw Exception();
    }
  }

  @override
  Future<FreeGoodsGetPriceResponseNew> getFreeGoodsPriceHistoryNew(
      Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.freeGoodsPriceHistoryNew,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    print('Status Code ${response.statusCode}');
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      print('dataa: $dataa');
      final freeGoodsResponse = FreeGoodsGetPriceResponseNew.fromJson(dataa);
      print(jsonEncode(freeGoodsResponse));
      print('data $freeGoodsResponse');
      return freeGoodsResponse;
    } else {
      print('Failed');
      throw Exception();
    }
  }

  @override
  Future<List<GetSoDetail>> getSoDetail(int soHeaderId) async {
    var response = await http.post(
        EndPoint.getSoDetail + '?so_header_id=$soHeaderId',
        headers: {"Content-Type": "application/json"});
    print('Status Code ${response.statusCode}');
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      List<GetSoDetail> getDetailResponse =
          jsonData.map((json) => GetSoDetail.fromJson(json)).toList();
      print(jsonEncode(getDetailResponse));
      print('data $getDetailResponse');
      return getDetailResponse;
    } else {
      print('Failed');
      throw Exception();
    }
  }

  @override
  Future<List<GetSoHistory>> getSoHistory() async {
    var response = await http.get(EndPoint.getSoHistory,
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<GetSoHistory> soHistoryData =
          jsonData.map((json) => GetSoHistory.fromJson(json)).toList();
      soHistoryData.sort((a, b) => b.doco.compareTo(a.doco));
      soHistoryData.sort((a, b) => b.soDate.compareTo(a.soDate));
      return soHistoryData;
    } else {
      throw Exception();
    }
  }

  @override
  Future<String> postDataHistory(Map data) async {
    String statusCode;
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.postSoHistory,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print('Previous Order');
      print(response.body);
      statusCode = response.statusCode.toString();
    } else {
      statusCode = response.statusCode.toString();
    }
    return statusCode;
  }

  @override
  Future<String> postDataHistoryNew(Map data) async {
    String statusCode;
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.postSoHistory,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print('Previous Order');
      print(response.body);
      statusCode = response.statusCode.toString();
    } else {
      statusCode = response.statusCode.toString();
    }
    return statusCode;
  }

  @override
  Future<List<GetCustomerResponse>> getCustomer() async {
    var response = await http.get(EndPoint.getCustomer,
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<GetCustomerResponse> getCustomerResponse =
          jsonData.map((json) => GetCustomerResponse.fromJson(json)).toList();
      return getCustomerResponse;
    } else {
      throw Exception();
    }
  }
}
