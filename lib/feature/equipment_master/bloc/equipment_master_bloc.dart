import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/model/equip_master_detail_response.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/model/equip_master_params.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/model/equip_master_response.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/repository/equip_master_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'equipment_master_state.dart';
part 'equipment_master_event.dart';

class EquipMasterBloc extends Bloc<EquipMasterEvent, EquipMasterState> {
  final EquipMasterRepository equipMasterRepository;

  EquipMasterBloc({@required this.equipMasterRepository});
  @override
  EquipMasterState get initialState => EquipMasterInitial();

  @override
  Stream<EquipMasterState> mapEventToState(EquipMasterEvent event) async* {
    if (event is SearchListSelectEvent) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Description", value: "*"),
        Input(name: "Unit Number", value: "*"),
      ];
      final listParam = EquipMasterParamModel(token: _token, inputs: paramList);
      List<EMList> rowset1 = [];
      List<EMList> rowset2 = [];
      if (event.descriptionF1201 != null) {
        try {
          print('No data ${event.descriptionF1201}');
          rowset2.clear();
          rowset1 = await equipMasterRepository.getList(listParam.toJson());
          rowset1.forEach((element) {
            if (element.descriptionF1201
                .toString()
                .contains(event.descriptionF1201.toString()))
              rowset2.add(element);
          });
          print('No data1 $rowset2');
          yield ArticleLoadedState(articles: rowset2);
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await equipMasterRepository.getList(listParam.toJson());
          if (rowset1 != null) {
            yield ArticleLoadedState(articles: rowset1);
            print('data1');
          } else {
            yield ArticleErrorState(message: 'Data Kosong');
          }
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      }
    }

    if (event is FilterListSelectEvent) {
      yield EquipMasterInitial();
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Description", value: event.descriptionF1201),
        Input(name: "Unit Number", value: event.unitNumberF1201),
      ];
      print('Description: ${event.descriptionF1201}');
      print('Unit Number: ${event.unitNumberF1201}');

      final listParam = EquipMasterParamModel(token: _token, inputs: paramList);
      List<EMList> rowset1 = [];
      List<EMList> rowset2 = [];
      if (event.descriptionF1201 != null) {
        try {
          print('No data ${event.descriptionF1201}');
          rowset2.clear();
          rowset1 = await equipMasterRepository.getList(listParam.toJson());
          print(rowset1.first.assetNumberF1201);
          rowset1.forEach((element) {
            if (element.descriptionF1201
                .toString()
                .contains(event.descriptionF1201.toString()))
              rowset2.add(element);
          });
          print('No data1 $rowset2');
          yield ArticleLoadedState(articles: rowset1);
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await equipMasterRepository.getList(listParam.toJson());
          if (rowset1 != null) {
            yield ArticleLoadedState(articles: rowset1);
            print('data1');
          } else {
            yield ArticleErrorState(message: 'Data Kosong');
          }
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      }
    }

    if (event is FindEquipment) {
      yield EquipMasterInitial();
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Asset Number", value: event.assetNumberF1217),
      ];
      print('Asset Number: ${event.assetNumberF1217}');

      final listParam = EquipMasterParamModel(token: _token, inputs: paramList);
      List<DetailList> rowset1 = [];
      List<DetailList> rowset2 = [];
      if (event.assetNumberF1217 != null) {
        try {
          print('No data ${event.assetNumberF1217}');
          rowset2.clear();
          rowset1 = await equipMasterRepository.getDetail(listParam.toJson());
          print(rowset1.first.assetNumberF1217);
          rowset1.forEach((element) {
            if (element.descriptionF1201
                .toString()
                .contains(event.assetNumberF1217.toString()))
              rowset2.add(element);
          });
          print('No data1 $rowset2');
          yield DetailLoadedState(articles: rowset1);
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await equipMasterRepository.getDetail(listParam.toJson());
          if (rowset1 != null) {
            yield DetailLoadedState(articles: rowset1);
            print('data1');
          } else {
            yield ArticleErrorState(message: 'Data Kosong');
          }
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      }
    }
  }
}
