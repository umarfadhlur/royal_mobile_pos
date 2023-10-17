import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/feature/user/data/model/add_user_params.dart';
import 'package:royal_mobile_pos/feature/user/data/model/get_user_response.dart';
import 'package:royal_mobile_pos/feature/user/data/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final GetUserRepository getUserRepository;

  GetUserBloc({this.getUserRepository});

  @override
  Stream<GetUserState> mapEventToState(
    GetUserEvent event,
  ) async* {
    if (event is GetUserEntry) {
      try {
        List<GetUserResponse> data = await getUserRepository.getUser();
        print(data);
        yield UserLoaded(articles: data);
      } catch (e) {
        yield UserFailed(message: 'Failed');
      }
    } else if (event is AddUserEvent) {
      final listParam = AddUserParams(
          userId: event.userId,
          password: event.password,
          name: event.name,
          branchPlant: event.branchPlant,
          shopId: event.shopId,
          );
      try {
        String statusCode =
            await getUserRepository.postUserData(listParam.toJson());
        print(statusCode);
        if (statusCode == "200") {
          print('Success');
          print(listParam);
          yield AddUserSuccess(message: 'User Saved');
        } else {
          print('Failed');
          yield AddUserFailed(message: 'User Failed');
        }
      } catch (e) {
        yield AddUserFailed(message: 'User Failed');
      }
    }
  }

  @override
  GetUserState get initialState => GetUserInitial();
}
