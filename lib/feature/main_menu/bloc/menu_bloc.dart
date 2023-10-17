import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/count_wo_params.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/count_wo_response.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/get_an8_params.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/get_an8_response.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/watchlist_count_wo_response.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/repository/menu_repo.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuRepository _menuRepository;
  final _logger = Logger();

  MenuBloc({MenuRepository menuRepository}) : _menuRepository = menuRepository;

  @override
  // TODO: implement initialState
  MenuState get initialState => MenuInitial();

  @override
  Stream<MenuState> mapEventToState(MenuEvent event) async* {
    if (event is GetAN8Input) {
      print("bloc menu");
      yield* _getCountWO(event);
      // yield* _getWatchList(event);
    }
  }

  Stream<MenuState> _getCountWO(GetAN8Input event) async* {
    final sharedPreferences = await SharedPreferences.getInstance();
    print("get count wo");

    String token = sharedPreferences.getString(SharedPref.token);
    String userID = sharedPreferences.getString(SharedPref.username);
    List<Input> inputAN8 = [
      //Input(name: "User ID", value: event.val)
      Input(name: "User ID", value: userID)
    ];
    print("try");
    //final an8Param = ParamsAn8(token: event.token, inputs: inputAN8);
    final an8Param = ParamsAn8(token: token, inputs: inputAN8);
    print("token : $token, inputs : $inputAN8");
    print("token : ${event.token}, value : ${event.val}");
    try {
      final String an8 = await _menuRepository.getValueAN8(an8Param.toJson());
      print("an8 = $an8");
      if (an8 != null) {
        List<InputCountWO> repeatInput1 = [
          InputCountWO(name: Name.values[0], value: an8),
          InputCountWO(name: Name.values[1], value: "1")
        ];
        List<InputCountWO> repeatInput2 = [
          InputCountWO(name: Name.values[0], value: an8),
          InputCountWO(name: Name.values[1], value: "2")
        ];
        List<InputCountWO> repeatInput3 = [
          InputCountWO(name: Name.values[0], value: an8),
          InputCountWO(name: Name.values[1], value: "3")
        ];
        List<InputCountWO> repeatInput4 = [
          InputCountWO(name: Name.values[0], value: an8),
          InputCountWO(name: Name.values[1], value: "4")
        ];
        List<InputCountWO> repeatInput5 = [
          InputCountWO(name: Name.values[0], value: an8),
          InputCountWO(name: Name.values[1], value: "5")
        ];

        List<RepeatingInput> repeatInput = [
          RepeatingInput(inputs: repeatInput1),
          RepeatingInput(inputs: repeatInput2),
          RepeatingInput(inputs: repeatInput3),
          RepeatingInput(inputs: repeatInput4),
          RepeatingInput(inputs: repeatInput5)
        ];

        List<DetailInput> inputCountWO = [
          DetailInput(name: "Count WO Type", repeatingInputs: repeatInput)
        ];

        final countWoParam =
            ParamsCountWo(token: token, detailInputs: inputCountWO);
        print("count WOParam : ${countWoParam.toJson()}");
        final ResponseCountWo countWo =
            await _menuRepository.getCountWO(countWoParam.toJson());
        print(
            "count WO : ${countWo.rudCountwopertypeF4801DrRepeating.first.rudCountwopertypeF4801Dr.rowset.first.woType}");
        final watchListParams = ParamsAn8(token: token, inputs: inputAN8);
        final ResponseWatchlistCountWo watchlistCountWo =
            await _menuRepository.getWatchList(watchListParams.toJson());
        print(watchlistCountWo.rudCountwoF4801Dr.rowset.first.countWo);

        yield GetCountWOSuccess(countWo: countWo, watchList: watchlistCountWo);
      }
    } catch (e) {
      yield MenuErrorState(message: e.toString());
      _logger.d("LoginError $e");
    }
  }
}
