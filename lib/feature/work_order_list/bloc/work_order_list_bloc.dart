import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/work_order_list/data/model/get_an8_params.dart';
import 'package:royal_mobile_pos/feature/work_order_list/data/model/work_order_list_param.dart';
import 'package:royal_mobile_pos/feature/work_order_list/data/model/work_order_list_response.dart';
import 'package:royal_mobile_pos/feature/work_order_list/data/repository/work_order_list_repository.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'work_order_list_event.dart';
part 'work_order_list_state.dart';

class WorkOrderListBloc extends Bloc<WorkOrderListEvent, WorkOrderListState> {
  final WorkOrderListRepository workOrderListRepository;

  WorkOrderListBloc({@required this.workOrderListRepository});
  @override
  Stream<WorkOrderListState> mapEventToState(WorkOrderListEvent event) async* {
    // TODO: implement mapEventToState
    if (event is SearchListSelectEvent) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      final _user = sharedPreferences.get(SharedPref.username);
      List<Input> inputAN8 = [Input(name: "User ID", value: _user)];
      final an8Param = GetAn8Params(token: _token, inputs: inputAN8);
      String an8 = await workOrderListRepository.getValueAN8(an8Param.toJson());
      List<InputList> paramList = [
        InputList(name: "Customer Number", value: an8),
        InputList(name: "Order Type", value: "*"),
        InputList(name: "Request Date", value: "16/07/21"),
        InputList(name: "Asset Number", value: "*"),
        InputList(name: "WO Status", value: "*"),
        InputList(name: "Branch", value: "*")
      ];
      final listParam = WorkOrderListParams(token: _token, inputs: paramList);
      print("an8 = $an8");
      List<WOList> rowset1 = [];
      List<WOList> rowset2 = [];
      if (event.orderNumber != null) {
        try {
          print('No data ${event.orderNumber}');
          rowset2.clear();
          rowset1 = await workOrderListRepository.getList(listParam.toJson());
          rowset1.forEach((element) {
            if (element.orderNumber
                .toString()
                .contains(event.orderNumber.toString())) rowset2.add(element);
          });
          print('No data1 $rowset2');
          yield ArticleLoadedState(articles: rowset2);
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await workOrderListRepository.getList(listParam.toJson());
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
      yield WorkOrderListInitial();
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      final _user = sharedPreferences.get(SharedPref.username);
      List<Input> inputAN8 = [Input(name: "User ID", value: _user)];
      final an8Param = GetAn8Params(token: _token, inputs: inputAN8);
      String an8 = await workOrderListRepository.getValueAN8(an8Param.toJson());
      List<InputList> paramList = [
        InputList(name: "Customer Number", value: an8),
        InputList(name: "Order Type", value: event.orTy),
        InputList(name: "Request Date", value: event.requestDate),
        InputList(name: "Asset Number", value: event.assetNumber),
        InputList(name: "WO Status", value: event.woStatus),
        InputList(name: "Branch", value: event.branch)
      ];
      print('Customer Number: $an8');
      print('Order Type: ${event.orTy}');
      print('Request Date: ${event.requestDate}');
      print('Asset Number: ${event.assetNumber}');
      print('WO Status: ${event.woStatus}');
      print('Branch: ${event.branch}');

      final listParam = WorkOrderListParams(token: _token, inputs: paramList);
      print("an8 = $an8");
      List<WOList> rowset1 = [];
      List<WOList> rowset2 = [];
      if (event.orderNumber != null) {
        try {
          print('No data ${event.orderNumber}');
          rowset2.clear();
          rowset1 = await workOrderListRepository.getList(listParam.toJson());
          rowset1.forEach((element) {
            if (element.orderNumber
                .toString()
                .contains(event.orderNumber.toString())) rowset2.add(element);
          });
          print('No data1 $rowset2');
          yield ArticleLoadedState(articles: rowset2);
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await workOrderListRepository.getList(listParam.toJson());
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
  }

  @override
  // TODO: implement initialState
  WorkOrderListState get initialState => WorkOrderListInitial();
}
