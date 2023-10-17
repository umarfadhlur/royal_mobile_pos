import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/feature/user/data/model/get_user_response.dart';

abstract class GetUserRepository {
  Future<List<GetUserResponse>> getUser();
  Future<String> postUserData(Map data);
}

class GetUserRepositoryImpl implements GetUserRepository {
  @override
  Future<List<GetUserResponse>> getUser() async {
    var response = await http.get(EndPoint.getUser,
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<GetUserResponse> getUserResponse =
          jsonData.map((json) => GetUserResponse.fromJson(json)).toList();
      return getUserResponse;
    } else {
      throw Exception();
    }
  }

  @override
  Future<String> postUserData(Map data) async {
    String statusCode;
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.addUser,
        body: jsonParam, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print('New User Data');
      print(response.body);
      statusCode = response.statusCode.toString();
    } else {
      statusCode = response.statusCode.toString();
    }
    return statusCode;
  }
}
