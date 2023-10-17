import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState(event);
    }

    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }

    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState(event);
    }
  }

  @override
  AuthState get initialState => throw UnimplementedError();
}

Stream<AuthState> _mapAppLoadedToState(AppLoaded event) async* {
  yield AuthenticationLoading();
  final sharedPreferences = await SharedPreferences.getInstance();
  String token, co, address;
  token = sharedPreferences.getString(SharedPref.token);
  co = sharedPreferences.getString(SharedPref.token);
  address = sharedPreferences.getString(SharedPref.token);

  if (token == null && co == null && address == null) {
    yield AuthenticationNotAuthenticated();
  } else {
    yield AuthenticationAuthenticated(token: token, co: co, address: address);
  }
}

Stream<AuthState> _mapUserLoggedInToState(UserLoggedIn event) async* {
  yield AuthenticationLoading();
  final sharedPreferences = await SharedPreferences.getInstance();
  String token, co, address;
  co = sharedPreferences.getString(SharedPref.token);
  address = sharedPreferences.getString(SharedPref.token);

  if (token == null && co != null && address != null) {
    yield AuthenticationAuthenticated(token: token, co: co, address: address);
  } else {
    yield AuthenticationNotAuthenticated();
  }
}

Stream<AuthState> _mapUserLoggedOutToState(UserLoggedOut event) async* {
  //await _authenticationService.signOut();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs?.clear();
  yield AuthenticationNotAuthenticated();
}
