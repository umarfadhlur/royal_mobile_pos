import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/login/data/model/local_login_response.dart';
import 'package:royal_mobile_pos/feature/login/data/model/login_param.dart';
import 'package:royal_mobile_pos/feature/login/data/model/logout_param.dart';
import 'package:royal_mobile_pos/feature/login/data/model/logout_response.dart';
import 'package:royal_mobile_pos/feature/login/data/repository/login_repo.dart';
import 'package:royal_mobile_pos/feature/login/data/model/login_response.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  final _logger = Logger();
  //LoginResponse user;
  LoginBloc({@required LoginRepository loginRepository})
      : _loginRepository = loginRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginSubmit) {
      yield* _mapAppLoginToState(event);
    } else if (event is LogoutSubmit) {
      yield* _mapAppLogoutToState(event);
    } else if (event is LocalLoginSubmit) {
      yield* _mapAppLocalLoginToState(event);
    }
  }

  Stream<LoginState> _mapAppLoginToState(LoginSubmit event) async* {
    yield LoginLoadingState();
    final sharedPreferences = await SharedPreferences.getInstance();
    final loginParam =
        LoginParam(username: event.username, password: event.password);

    _logger.d("PASS ${event.password}");
    if (event.username == null || event.password == null) {
      yield LoginErrorState(message: 'Cek Kembali Username dan Password!');
    } else {
      _logger.d("Cek");
      try {
        LoginResponse user =
            await _loginRepository.getLogin(loginParam.toJson());
        _logger.d("user $user");
        if (user.userInfo.token.isEmpty) {
          _logger.d("gagal");
          yield LoginErrorState(message: 'Cek Kembali Username dan Password!');
        } else {
          sharedPreferences.setString(SharedPref.token, user.userInfo.token);
          sharedPreferences.setString(SharedPref.username, user.username);
          sharedPreferences.setString(SharedPref.password, event.password);
          sharedPreferences.setString(
              SharedPref.environtment, user.environment);
          yield LoginSuccessState(
              username: user.username,
              environment: user.environment,
              token: user.userInfo.token);
          _logger.d("LoginSucces token ${user.userInfo.token}");
        }
      } on DioError catch (e) {
        yield LoginErrorState(message: 'Server Error');
        _logger.d("LoginError $e");
      } catch (e) {
        yield LoginErrorState(message: 'Cek username dan password');
        _logger.d("LoginError $e");
      }
    }
  }

  Stream<LoginState> _mapAppLocalLoginToState(LocalLoginSubmit event) async* {
    yield LoginLoadingState();
    final sharedPreferences = await SharedPreferences.getInstance();
    final loginParam =
        LoginParam(username: event.username, password: event.password);

    _logger.d("PASS ${event.password}");
    if (event.username == null || event.password == null) {
      yield LoginErrorState(message: 'Cek Kembali Username dan Password!');
    } else {
      _logger.d("Cek");
      try {
        LocalLoginResponse user =
            await _loginRepository.getLocalLogin(loginParam.toJson());
        _logger.d("user $user");
        if (user.success != true) {
          _logger.d("gagal");
          yield LoginErrorState(message: 'Cek Kembali Username dan Password!');
        } else {
          sharedPreferences.setString(SharedPref.userID, user.userId);
          sharedPreferences.setString(SharedPref.loginName, user.name);
          sharedPreferences.setString(SharedPref.loginBp, user.branchPlant);
          sharedPreferences.setString(SharedPref.shopID, user.shopId);
          yield LoginLocalState(
            userID: user.userId,
            name: user.name,
            branchPlant: user.branchPlant,
            shopID: user.shopId,
          );
          _logger.d("LocalLoginSuccess ${user.branchPlant}");
        }
      } on DioError catch (e) {
        yield LoginErrorState(message: 'Server Error');
        _logger.d("LoginError $e");
      } catch (e) {
        yield LoginErrorState(message: 'Cek username dan password');
        _logger.d("LoginError $e");
      }
    }
  }

  Stream<LoginState> _mapAppLogoutToState(LogoutSubmit event) async* {
    final sharedPreferences = await SharedPreferences.getInstance();
    final _token = sharedPreferences.get(SharedPref.token);
    final logoutParam = LogoutParam(token: _token);

    try {
      print("logout");
      LogoutResponse user =
          await _loginRepository.getLogout(logoutParam.toJson());
      if (user.status == "Sukses") {
        yield LogoutSuccess();
      }
    } catch (e) {
      yield LogoutErrorState(message: 'Logout Error');
    }
  }

  @override
  LoginState get initialState => LoginInitial();
}

// if (event is LoginSubmit){
//       yield LoginLoadingState();
//       _logger.d("LoginLoad");
//       final loginParam = LoginParam(username: event.username, password: event.password);
//       final sharedPreferences = await SharedPreferences.getInstance();
//       try {
//         LoginResponse user = await _loginRepository.getLogin(loginParam.toJson());
//         if (user != null){
//             sharedPreferences.setString(SharedPref.token, user.userInfo.token);
//             sharedPreferences.setString(SharedPref.username, user.username);
//             sharedPreferences.setString(SharedPref.environtment, user.environment);
//             yield LoginSuccessState(username: user.username, environment: user.environment, token: user.userInfo.token);
//             _logger.d("LoginSucces token ${user.userInfo.token}");
//         }else {
//             yield LoginErrorState(message: 'Cek Kembali Username dan Password!');
//         }

//       }catch(e){
//         yield LoginErrorState(message: e);
//         _logger.d("LoginError");
//       }
//     }
