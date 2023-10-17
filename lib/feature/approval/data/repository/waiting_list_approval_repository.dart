import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/approval/data/model/approval_detail_response.dart';
import 'package:royal_mobile_pos/feature/approval/data/model/waiting_list_approval_response.dart';

abstract class WaitingListApprovalRepository {
  Future<List<ApvList>> getList(Map data);
  Future<List<Detail>> getDetail(Map data);
  Future<String> approvePO(Map data);
  Future<String> rejectPO(Map data);
}

class WaitingListApprovalRepositoryImpl extends WaitingListApprovalRepository {
  @override
  Future<List<ApvList>> getList(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.getApvList,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<ApvList> rowset =
          GetWaitingApprovalListResponse.fromJson(dataa).getDataF55Orch1.rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Detail>> getDetail(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.getApvDetail,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<Detail> rowset =
          GetApprovalDetailResponse.fromJson(dataa).getDataF55Orch2.rowset;
      print("data $rowset");
      return rowset;
    } else {
      throw Exception();
    }
  }

  @override
  Future<String> approvePO(Map data) async {
    String statusCode;
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.approvePO,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      statusCode = response.statusCode.toString();
    } else {
      statusCode = response.statusCode.toString();
    }
    return statusCode;
  }

  @override
  Future<String> rejectPO(Map data) async {
    String statusCode;
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.rejectPO,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      statusCode = response.statusCode.toString();
    } else {
      statusCode = response.statusCode.toString();
    }
    return statusCode;
  }
}
