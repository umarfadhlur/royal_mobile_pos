import 'dart:convert';

import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/login/data/model/local_login_response.dart';
import 'package:royal_mobile_pos/feature/login/data/model/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:royal_mobile_pos/feature/login/data/model/logout_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> getLogin(Map login);
  Future<LocalLoginResponse> getLocalLogin(Map login);
  Future<LogoutResponse> getLogout(Map data);
}

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<LoginResponse> getLogin(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.login,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final userInfo = LoginResponse.fromJson(data);
      print("data user ${userInfo.username.toString()}");
      return userInfo;
    } else {
      throw Exception();
    }
  }

  @override
  Future<LogoutResponse> getLogout(Map data) async {
    var jsonParam = jsonEncode(data);
    var response = await http.post(EndPoint.logout,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final success = LogoutResponse.fromJson(data);
      print("Status: ${success.status}");
      return success;
    } else {
      throw Exception();
    }
  }

  @override
  Future<LocalLoginResponse> getLocalLogin(Map login) async {
    var jsonParam = jsonEncode(login);
    var response = await http.post(EndPoint.loginLocal,
        body: jsonParam, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      final userInfo = LocalLoginResponse.fromJson(data);
      print("data user ${userInfo.name.toString()}");
      return userInfo;
    } else {
      throw Exception();
    }
  }
}
