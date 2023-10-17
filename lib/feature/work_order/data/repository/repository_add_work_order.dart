import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/work_order/data/model/add_work_order/add_notes.dart';
import 'package:royal_mobile_pos/feature/work_order/data/model/add_work_order/find_customer.dart';
import 'package:royal_mobile_pos/feature/work_order/data/model/add_work_order/find_eqp.dart';
import 'package:royal_mobile_pos/feature/work_order/data/model/add_work_order/find_item.dart';
import 'package:royal_mobile_pos/feature/work_order/data/model/work_order_response_model.dart';

abstract class AddWorkOrderRepository {
  Future<String> getAddWorkOrder(Map data);
  Future<List<Customer>> getCustomer(Map data);
  Future<List<Item>> getItem(Map data);
  Future<List<Equipment>> getEqp(Map data);
  Future<String> getError(Map data);
  Future<WorkOrderResponseModel> getWOCreated(Map data);
  Future<AddNotes> getAddNotes(Map data);
}

class AddWorkOrderRepositoryImpl extends AddWorkOrderRepository {
  @override
  Future<String> getAddWorkOrder(Map data) async {
    var jsonParam = jsonEncode(data);
    print(jsonParam);
    var response = await http.post(EndPoint.addWO,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    print("status code ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final woCreated = WorkOrderResponseModel.fromJson(data);
      print(woCreated.woCreated);
      final statusCode = "Sukses";
      return statusCode;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Customer>> getCustomer(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.findCustomer,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    print("status ${response.statusCode}");
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<Customer> customer = FindCustomerResponseModel.fromJson(dataa)
          .rudFindcustomerF03012Dr1
          .rowset;
      final tab = FindCustomerResponseModel.fromJson(dataa)
          .rudFindcustomerF03012Dr1
          .tableId;
      print("tab $tab");
      print("customer $customer");
      return customer;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Item>> getItem(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.findItem,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    print("status ${response.statusCode}");
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<Item> item =
          FindItemResponseModel.fromJson(dataa).rudFinditemF4101Dr1.rowset;
      final tab =
          FindItemResponseModel.fromJson(dataa).rudFinditemF4101Dr1.tableId;
      print("tab $tab");
      print("item $item");
      return item;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<Equipment>> getEqp(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.findEquipment,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    print("status ${response.statusCode}");
    if (response.statusCode == 200) {
      var dataa = json.decode(response.body);
      List<Equipment> equipment =
          FindEqpResponseModel.fromJson(dataa).rudFindeqpF1201Dr1.rowset;
      final tab =
          FindEqpResponseModel.fromJson(dataa).rudFindeqpF1201Dr1.tableId;
      print("tab $tab");
      print("equipment $equipment");
      return equipment;
    } else {
      throw Exception();
    }
  }

  @override
  Future<String> getError(Map data) async {
    var jsonParamExpense = jsonEncode(data);
    print('jsonParamExpense: $jsonParamExpense');
    var response = await http.post(EndPoint.addWO,
        body: jsonParamExpense, headers: {"Content-Type": "application/json"});
    print("status ${response.statusCode}");
    if (response.statusCode == 500) {
      var data1 = json.decode(response.body);
      final errorList = 'ResponseError.fromJson(data1).message';
      print("error $data1");
      return errorList;
    } else {
      throw Exception();
    }
  }

  @override
  Future<WorkOrderResponseModel> getWOCreated(Map data) async {
    var jsonParam = jsonEncode(data);
    print(jsonParam);
    var response = await http.post(EndPoint.addWO,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    print("status code ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final woCreated = WorkOrderResponseModel.fromJson(data);
      print(woCreated.woCreated);
      return woCreated;
    } else {
      throw Exception();
    }
  }

  @override
  Future<AddNotes> getAddNotes(Map data) async {
    var jsonParam = jsonEncode(data);
    print(jsonParam);
    var response = await http.post(EndPoint.addNotes,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    print("status code ${response.statusCode}");
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final addNotes = AddNotes.fromJson(data);
      return addNotes;
    } else {
      throw Exception();
    }
  }
}
