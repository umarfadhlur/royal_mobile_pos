import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/feature/customer/data/model/get_customer_response.dart';

abstract class GetCustomerRepository {
  Future<List<GetCustomerResponse>> getCustomer();
  Future<String> postCustomerData(Map data);
}

class GetCustomerRepositoryImpl implements GetCustomerRepository {
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

  @override
  Future<String> postCustomerData(Map data) async {
    String statusCode;
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.addCustomer,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print('New Customer Data');
      print(response.body);
      statusCode = response.statusCode.toString();
    } else {
      statusCode = response.statusCode.toString();
    }
    return statusCode;
  }
}
