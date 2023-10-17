import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/equipment_number/data/model/equipment_response.dart';
import 'package:royal_mobile_pos/feature/equipment_number/data/model/find_equipment_response.dart';
import 'package:royal_mobile_pos/feature/equipment_number/data/model/get_equipment_params.dart';
import 'package:royal_mobile_pos/feature/equipment_number/data/repository/equipment_number_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'equipment_number_event.dart';
part 'equipment_number_state.dart';

class EquipmentNumberBloc
    extends Bloc<EquipmentNumberEvent, EquipmentNumberState> {
  final EquipmentNumberRepository _equipmentNumberRepository;

  EquipmentNumberBloc({EquipmentNumberRepository equipmentNumberRepository})
      : _equipmentNumberRepository = equipmentNumberRepository;

  @override
  EquipmentNumberState get initialState => EquipmentNumberInitial();

  @override
  Stream<EquipmentNumberState> mapEventToState(
      EquipmentNumberEvent event) async* {
    if (event is FindEquipment) {
      print("bloc menu");
      yield* _getEquipment(event);
    } else if (event is UpdateEquipment) {
      print("update");
      yield* _updateEquipment(event);
    }
  }

  Stream<EquipmentNumberState> _getEquipment(FindEquipment event) async* {
    final sharedPreferences = await SharedPreferences.getInstance();
    print("get count wo");

    String token = sharedPreferences.getString(SharedPref.token);
    List<Input> inputGetEquipment = [
      Input(name: "Equipment Number", value: event.equipmentNumber)
    ];
    print("try");
    //final an8Param = ParamsAn8(token: event.token, inputs: inputAN8);
    final getEquipment =
        ParamsGetEquipment(token: token, inputs: inputGetEquipment);
    print("get eqeuip : ${getEquipment.toJson()}");
    try {
      final ResponseFindEquipment responseFindEquipment =
          await _equipmentNumberRepository.findEquipment(getEquipment.toJson());
      print("respone = $responseFindEquipment");
      if (responseFindEquipment.rudFindeqpF1201Dr1.rowset.first.countEquipment <
          1) {
        yield AddError(error: 'Equipment Number Not Found');
      } else {
        final ResponseEquipment responseEquipment =
            await _equipmentNumberRepository.getLongLat(getEquipment.toJson());
        print("responeget = $responseEquipment");
        yield EquipmentFound(equipment: responseEquipment);
      }
    } catch (e) {}
  }

  Stream<EquipmentNumberState> _updateEquipment(UpdateEquipment event) async* {
    final sharedPreferences = await SharedPreferences.getInstance();
    print("update location");

    String token = sharedPreferences.getString(SharedPref.token);
    List<Input> inputGetEquipment = [
      Input(name: "Equipment Number", value: event.equipmentNumber)
    ];
    print("try");
    final getEquipment =
        ParamsGetEquipment(token: token, inputs: inputGetEquipment);
    print("get eqeuip : ${getEquipment.toJson()}");

    List<Input> inputUpdateEquipment = [
      Input(name: "Equipment Number", value: event.equipmentNumber),
      Input(name: "Latitude", value: event.latitude),
      Input(name: "Longitude", value: event.longitude)
    ];
    final updateEquipment =
        ParamsGetEquipment(token: token, inputs: inputUpdateEquipment);
    print("update equip : ${updateEquipment.toJson()}");
    try {
      final ResponseFindEquipment responseFindEquipment =
          await _equipmentNumberRepository.findEquipment(getEquipment.toJson());
      print("respone = $responseFindEquipment");
      if (responseFindEquipment.rudFindeqpF1201Dr1.rowset.first.countEquipment <
          1) {
        yield AddError(error: 'Equipment Number Not Found');
      } else {
        final ResponseEquipment responseEquipment =
            await _equipmentNumberRepository
                .updateLongLat(updateEquipment.toJson());
        print("responupdate = $responseEquipment");
        yield EquipmentFound(equipment: responseEquipment);
        yield AddSuccess(success: 'Equipment Location Updated');
      }
    } catch (e) {}
  }
}
