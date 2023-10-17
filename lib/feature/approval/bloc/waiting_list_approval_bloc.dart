import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/approval/data/model/approval_detail_response.dart';
import 'package:royal_mobile_pos/feature/approval/data/model/waiting_list_approval_param.dart';
import 'package:royal_mobile_pos/feature/approval/data/model/waiting_list_approval_response.dart';
import 'package:royal_mobile_pos/feature/approval/data/repository/waiting_list_approval_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'waiting_list_approval_state.dart';
part 'waiting_list_approval_event.dart';

class WaitingListApprovalBloc
    extends Bloc<WaitingListApprovalEvent, WaitingListApprovalState> {
  final WaitingListApprovalRepository waitingListApprovalRepository;

  WaitingListApprovalBloc({@required this.waitingListApprovalRepository});
  @override
  WaitingListApprovalState get initialState => WaitingListApprovalInitial();

  @override
  Stream<WaitingListApprovalState> mapEventToState(
      WaitingListApprovalEvent event) async* {
    if (event is SearchListSelectEvent) {
      print('yang search');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.getString(SharedPref.token);
      final _an8 = sharedPreferences.getString(SharedPref.addressnumber);
      List<Input> paramList = [
        Input(name: "Person Responsible 1", value: _an8),
        Input(name: "EnterpriseOne Event Point 01 1", value: "W"),
      ];
      final listParam =
          GetWaitingApprovalListParam(token: _token, inputs: paramList);
      List<ApvList> rowset1 = [];
      List<ApvList> rowset2 = [];
      if (event.descriptionF1201 != null) {
        try {
          print('No data ${event.descriptionF1201}');
          rowset2.clear();
          rowset1 =
              await waitingListApprovalRepository.getList(listParam.toJson());
          print('No data1 $rowset2');
          yield ArticleLoadedState(articles: rowset2);
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 =
              await waitingListApprovalRepository.getList(listParam.toJson());
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
    } else if (event is FilterListSelectEvent) {
      print('yang filter');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.getString(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Person Responsible 1", value: event.personResponsible),
        Input(name: "EnterpriseOne Event Point 01 1", value: event.eventPoint),
      ];
      final listParam =
          GetWaitingApprovalListParam(token: _token, inputs: paramList);
      List<ApvList> rowset1 = [];
      List<ApvList> rowset2 = [];
      if (event.personResponsible != null) {
        try {
          print('No data ${event.personResponsible}');
          rowset2.clear();
          rowset1 =
              await waitingListApprovalRepository.getList(listParam.toJson());
          print('No data1 $rowset2');
          yield ArticleLoadedState(articles: rowset1);
        } catch (e) {
          yield ArticleErrorState(message: "Data Tidak di temukan");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 =
              await waitingListApprovalRepository.getList(listParam.toJson());
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
    } else if (event is DetailListSelectEvent) {
      print('yang detail');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.getString(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Order Company", value: event.orderCompany),
        Input(name: "Order Number ", value: event.orderNumber),
        Input(name: "Order Type ", value: event.orderType),
      ];
      final listParam =
          GetWaitingApprovalListParam(token: _token, inputs: paramList);
      List<Detail> rowset1 = [];
      List<Detail> rowset2 = [];
      if (event.orderNumber != null) {
        try {
          print('No data ${event.orderNumber}');
          rowset2.clear();
          rowset1 =
              await waitingListApprovalRepository.getDetail(listParam.toJson());
          print('No data1 $rowset2');
          yield DetailLoadedState(details: rowset1);
        } catch (e) {
          yield DetailErrorState(message: "Data Tidak di temukan");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 =
              await waitingListApprovalRepository.getDetail(listParam.toJson());
          if (rowset1 != null) {
            yield DetailLoadedState(details: rowset1);
            print('data1');
          } else {
            yield DetailErrorState(message: 'Data Kosong');
          }
        } catch (e) {
          yield DetailErrorState(message: "Data Tidak di temukan");
        }
      }
    } else if (event is ApproveEntry) {
      print('Approve');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Document_Number", value: event.orderNumber),
      ];
      print('Document_Number: ${event.orderNumber}');

      final listParam =
          GetWaitingApprovalListParam(token: _token, inputs: paramList);
      String statusCode;
      if (event.orderNumber != null) {
        try {
          statusCode =
              await waitingListApprovalRepository.approvePO(listParam.toJson());
          print(statusCode);
          if (statusCode == "200") {
            print('Success');
            yield ApproveSuccess(message: 'PO Approved');
          } else {
            print('Failed');
            yield ApproveFailed(message: 'Error');
          }
        } catch (e) {
          yield ApproveFailed(message: 'Error');
        }
      }
    } else if (event is RejectEntry) {
      print('Reject');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Document_Number", value: event.orderNumber),
        Input(name: "Description", value: event.remarks),
      ];
      print('Document_Number: ${event.orderNumber}');
      print('Description: ${event.remarks}');

      final listParam =
          GetWaitingApprovalListParam(token: _token, inputs: paramList);
      String statusCode;
      if (event.orderNumber != null) {
        try {
          statusCode =
              await waitingListApprovalRepository.rejectPO(listParam.toJson());
          print(statusCode);
          if (statusCode == "200") {
            print('Success');
            yield RejectSuccess(message: 'PO Approved');
          } else {
            print('Failed');
            yield RejectFailed(message: 'Error');
          }
        } catch (e) {
          yield RejectFailed(message: 'Error');
        }
      }
    }
  }
}
