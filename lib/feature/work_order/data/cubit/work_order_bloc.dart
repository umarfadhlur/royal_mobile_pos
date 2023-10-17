import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/core/model/param_list_data.dart';
import 'package:royal_mobile_pos/feature/work_order/data/model/add_work_order/find_customer.dart';
import 'package:royal_mobile_pos/feature/work_order/data/model/work_order_response_model.dart';
import 'package:royal_mobile_pos/feature/work_order/data/repository/repository_add_work_order.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'work_order_event.dart';
part 'work_order_state.dart';

class WorkOrderBloc extends Bloc<WorkOrderEvent, WorkOrderState> {
  final _logger = Logger();
  final AddWorkOrderRepository _addWorkOrderRepository;

  WorkOrderBloc({@required AddWorkOrderRepository addWorkOrderRepository})
      : _addWorkOrderRepository = addWorkOrderRepository;

  @override
  Stream<WorkOrderState> mapEventToState(
    WorkOrderEvent event,
  ) async* {
    final sharedPreferences = await SharedPreferences.getInstance();
    final _token = sharedPreferences.get(SharedPref.token);
    var now = new DateTime.now();
    var date = new DateFormat("dd/MM/yy");
    var time = new DateFormat.Hms();
    String dateFormat = date.format(now);
    String timeFormat = time.format(now);
    print("tanggal : $dateFormat");
    print("waktu : $timeFormat");

    if (event is FetchWorkOrderAdd) {
      List<Input> checkCustomer = [
        Input(name: "Customer Number", value: event.customerNumber.toString())
      ];

      List<Input> checkEquipment = [
        Input(name: "Equipment Number", value: event.equipNumber.toString())
      ];

      List<Input> checkItem = [
        Input(name: "Item Number", value: event.invItemNumber)
      ];

      List<Input> addWorkOrder = [
        Input(name: "Customer Number", value: event.customerNumber.toString()),
        Input(name: "Contact Name", value: event.contactName),
        Input(name: "Phone Prefix", value: event.prefix),
        Input(name: "Phone Number", value: event.phone),
        Input(name: "Equipment Number", value: event.equipNumber.toString()),
        Input(name: "Inv Item Number", value: event.invItemNumber),
        Input(name: "Failure Description", value: event.failureDesc),
        Input(name: "Requested Finish Date", value: event.reqFinishDate),
        Input(name: "Requested Finish Time", value: event.reqFinishTime),
        Input(name: "P17714_Version", value: "ZJDE0004")
      ];

      print('Customer Number: ${event.customerNumber}');
      print('Contact name: ${event.contactName}');
      print('Phone Prefix: ${event.prefix}');
      print('Phone Number: ${event.phone}');
      print('Equipment Number: ${event.equipNumber}');
      print('Inv Item Number: ${event.invItemNumber}');
      print('Failure Description: ${event.failureDesc}');
      print('Requested Finish Date: ${event.reqFinishDate}');
      print('Requested Finish Time: ${event.reqFinishTime}');
      print('P17714_Version: ZJDE0004');
      print('Notes: ${event.notes}');

      final paramCustomer = ParamListData(token: _token, inputs: checkCustomer);
      final paramEquipment =
          ParamListData(token: _token, inputs: checkEquipment);
      final paramItem = ParamListData(token: _token, inputs: checkItem);
      final paramAddWorkOrder =
          ParamListData(token: _token, inputs: addWorkOrder);

      if (event.customerNumber != null) {
        try {
          final countCustomer =
              await _addWorkOrderRepository.getCustomer(paramCustomer.toJson());
          yield AddWorkOrderInitial();
          if (countCustomer.first.countCustomer < 1) {
            yield AddError(error: 'Customer Number Not Found');
          } else {
            print('Customer Found');
            if (event.equipNumber != "") {
              try {
                final countEquip = await _addWorkOrderRepository
                    .getEqp(paramEquipment.toJson());
                yield AddWorkOrderInitial();
                if (countEquip.first.countEquipment < 1) {
                  yield AddError(error: 'Equipment Number Not Found');
                } else {
                  print('Equipment Found');
                  if (event.invItemNumber != "") {
                    try {
                      final countItem = await _addWorkOrderRepository
                          .getItem(paramItem.toJson());
                      yield AddWorkOrderInitial();
                      if (countItem.first.countItem < 1) {
                        yield AddError(error: 'Item Number Not Found');
                      } else {
                        print('Item Found');
                        try {
                          final woCreated = await _addWorkOrderRepository
                              .getWOCreated(paramAddWorkOrder.toJson());
                          yield AddWorkOrderInitial();
                          if (woCreated != null) {
                            if (woCreated.woCreated == 0) {
                              yield AddError(
                                  error: 'Error. Failed to Create Work Order');
                            } else {
                              print('Sukses');
                              yield WorkOrderLoaded(model: woCreated);
                              print('woCreated: ${woCreated.woCreated}');
                              if (event.notes != "") {
                                List<Input> addNotes = [
                                  Input(
                                      name: "WO Number",
                                      value: woCreated.woCreated.toString()),
                                  Input(name: "Notes", value: event.notes)
                                ];
                                final paramNotes = ParamListData(
                                    token: _token, inputs: addNotes);
                                try {
                                  final notes = await _addWorkOrderRepository
                                      .getAddNotes(paramNotes.toJson());
                                  if (notes.connectorRequest1.addTextStatus ==
                                      "Success") {
                                    print("Add Notes Success");
                                    yield WorkOrderLoaded(model: woCreated);
                                  }
                                } catch (e) {
                                  print('Error Notes');
                                  yield AddError(error: 'Add Notes Error');
                                }
                              } else if (event.notes == "") {
                                print("Add Notes 1");
                                yield WorkOrderLoaded(model: woCreated);
                              }
                            }
                          }
                        } catch (e) {
                          try {
                            print("Gagal");
                            final errorList = await _addWorkOrderRepository
                                .getError(paramAddWorkOrder.toJson());
                            if (errorList != null) {
                              print("error : " + errorList);
                              yield AddWorkOrderError(error: errorList);
                            }
                          } catch (e) {
                            yield AddWorkOrderError(error: "Gagal update");
                          }
                        }
                      }
                    } catch (e) {
                      print('Error Item 1');
                      yield AddError(error: 'Error Encountered');
                    }
                  } else if (event.invItemNumber == "") {
                    try {
                      final woCreated = await _addWorkOrderRepository
                          .getWOCreated(paramAddWorkOrder.toJson());
                      yield AddWorkOrderInitial();
                      if (woCreated != null) {
                        if (woCreated.woCreated == 0) {
                          yield AddError(
                              error: 'Error. Failed to Create Work Order');
                        } else {
                          print('Sukses');
                          yield WorkOrderLoaded(model: woCreated);
                          print('woCreated: ${woCreated.woCreated}');
                          if (event.notes != "") {
                            List<Input> addNotes = [
                              Input(
                                  name: "WO Number",
                                  value: woCreated.woCreated.toString()),
                              Input(name: "Notes", value: event.notes)
                            ];
                            final paramNotes =
                                ParamListData(token: _token, inputs: addNotes);
                            try {
                              final notes = await _addWorkOrderRepository
                                  .getAddNotes(paramNotes.toJson());
                              if (notes.connectorRequest1.addTextStatus ==
                                  "Success") {
                                print("Add Notes Success");
                                yield WorkOrderLoaded(model: woCreated);
                              }
                            } catch (e) {
                              print('Error Notes');
                              yield AddError(error: 'Add Notes Error');
                            }
                          } else if (event.notes == "") {
                            print("Add Notes 2");
                            yield WorkOrderLoaded(model: woCreated);
                          }
                        }
                      }
                    } catch (e) {
                      try {
                        print("Gagal");
                        final errorList = await _addWorkOrderRepository
                            .getError(paramAddWorkOrder.toJson());
                        if (errorList != null) {
                          print("error : " + errorList);
                          yield AddWorkOrderError(error: errorList);
                        }
                      } catch (e) {
                        yield AddWorkOrderError(error: "Gagal update");
                      }
                    }
                  }
                }
              } catch (e) {
                print('Error Equipment');
                yield AddError(error: 'Error Encountered');
              }
            } else if (event.equipNumber == "") {
              if (event.invItemNumber != "") {
                try {
                  final countItem =
                      await _addWorkOrderRepository.getItem(paramItem.toJson());
                  yield AddWorkOrderInitial();
                  if (countItem.first.countItem < 1) {
                    yield AddError(error: 'Item Number Not Found');
                  } else {
                    print('Item Found');
                    try {
                      final woCreated = await _addWorkOrderRepository
                          .getWOCreated(paramAddWorkOrder.toJson());
                      yield AddWorkOrderInitial();
                      if (woCreated != null) {
                        if (woCreated.woCreated == 0) {
                          yield AddError(
                              error: 'Error. Failed to Create Work Order');
                        } else {
                          print('Sukses');
                          yield WorkOrderLoaded(model: woCreated);
                          print('woCreated: ${woCreated.woCreated}');
                          if (event.notes != "") {
                            List<Input> addNotes = [
                              Input(
                                  name: "WO Number",
                                  value: woCreated.woCreated.toString()),
                              Input(name: "Notes", value: event.notes)
                            ];
                            final paramNotes =
                                ParamListData(token: _token, inputs: addNotes);
                            try {
                              final notes = await _addWorkOrderRepository
                                  .getAddNotes(paramNotes.toJson());
                              if (notes.connectorRequest1.addTextStatus ==
                                  "Success") {
                                print("Add Notes Success");
                                yield WorkOrderLoaded(model: woCreated);
                              }
                            } catch (e) {
                              print('Error Notes');
                              yield AddError(error: 'Add Notes Error');
                            }
                          } else if (event.notes == "") {
                            print("Add Notes 3");
                            yield WorkOrderLoaded(model: woCreated);
                          }
                        }
                      }
                    } catch (e) {
                      try {
                        print("Gagal");
                        final errorList = await _addWorkOrderRepository
                            .getError(paramAddWorkOrder.toJson());
                        if (errorList != null) {
                          print("error : " + errorList);
                          yield AddWorkOrderError(error: errorList);
                        }
                      } catch (e) {
                        yield AddWorkOrderError(error: "Gagal update");
                      }
                    }
                  }
                } catch (e) {
                  print('Error Item 2');
                  yield AddError(error: 'Error Encountered');
                }
              } else if (event.invItemNumber == "") {
                try {
                  final woCreated = await _addWorkOrderRepository
                      .getWOCreated(paramAddWorkOrder.toJson());
                  yield AddWorkOrderInitial();
                  if (woCreated != null) {
                    if (woCreated.woCreated == 0) {
                      yield AddError(
                          error: 'Error. Failed to Create Work Order');
                    } else {
                      print('Sukses');
                      yield WorkOrderLoaded(model: woCreated);
                      print('woCreated: ${woCreated.woCreated}');
                      if (event.notes != "") {
                        List<Input> addNotes = [
                          Input(
                              name: "WO Number",
                              value: woCreated.woCreated.toString()),
                          Input(name: "Notes", value: event.notes)
                        ];
                        final paramNotes =
                            ParamListData(token: _token, inputs: addNotes);
                        try {
                          final notes = await _addWorkOrderRepository
                              .getAddNotes(paramNotes.toJson());
                          if (notes.connectorRequest1.addTextStatus ==
                              "Success") {
                            print("Add Notes Success");
                            yield WorkOrderLoaded(model: woCreated);
                          }
                        } catch (e) {
                          print('Error Notes');
                          yield AddError(error: 'Add Notes Error');
                        }
                      } else if (event.notes == "") {
                        print("Add Notes 4");
                        yield WorkOrderLoaded(model: woCreated);
                      }
                    }
                  }
                } catch (e) {
                  try {
                    print("Gagal");
                    final errorList = await _addWorkOrderRepository
                        .getError(paramAddWorkOrder.toJson());
                    if (errorList != null) {
                      print("error : " + errorList);
                      yield AddWorkOrderError(error: errorList);
                    }
                  } catch (e) {
                    yield AddWorkOrderError(error: "Gagal update");
                  }
                }
              }
            }
          }
        } catch (e) {
          print('Error Customer');
          yield AddError(error: 'Error Encountered');
        }
      } else if (event.customerNumber == null) {
        yield AddError(error: 'Customer Number Cannot Be Blank');
      }
    }
  }

  @override
  // TODO: implement initialState
  WorkOrderState get initialState => AddWorkOrderInitial();
}
