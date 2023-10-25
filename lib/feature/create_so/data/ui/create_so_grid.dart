import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/formatCurrency.dart';
import 'package:royal_mobile_pos/feature/create_so/bloc/create_so_bloc.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/create_so_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/create_so_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_new_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/item_branch_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/post_so_history_new.dart';
import 'package:royal_mobile_pos/feature/create_so/data/repository/create_so_repository.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/create_so_header.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/grid_details.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/new_grid_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateSoGrid extends StatefulWidget {
  @override
  State<CreateSoGrid> createState() => _CreateSoGridState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('dd/MM/yyyy').format(now);
String freePriceDate = DateFormat('MM/dd/yyyy').format(now);
String postedDate = DateFormat('yyyy-MM-dd').format(now);

class TempGrid {
  String quantityOrdered;
  String itemNumber;
  String unitPrice;
  String extendedPrice;
  String status;
  String priceHistory;

  TempGrid({
    this.quantityOrdered,
    this.itemNumber,
    this.unitPrice,
    this.extendedPrice,
    this.status,
    this.priceHistory,
  });
}

class TempGridDataTableSource extends DataTableSource {
  final List<TempGrid> data;

  TempGridDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.itemNumber.toString())),
      DataCell(Text(rowData.quantityOrdered.toString())),
      DataCell(Text(rowData.unitPrice)),
      DataCell(Text(rowData.extendedPrice)),
      DataCell(Text(rowData.status)),
      DataCell(
        InkWell(
          onTap: () {
            Get.to(() => NewGridDetails(rowData.priceHistory, 'Grid Details'));
          },
          child: Text(
            'Detail',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
      // DataCell(
      //   InkWell(
      //     onTap: () async {
      //       final prefs = await SharedPreferences.getInstance();
      //       await prefs.setString(
      //           SharedPref.itemN, rowData.itemNumber.toString());
      //       await prefs.setString(
      //           SharedPref.quantity, rowData.quantityOrdered.toString());
      //       Get.to(() => GridDetails());
      //     },
      //     child: Text(
      //       'Details',
      //       style: TextStyle(
      //         color: Colors.blue,
      //       ),
      //     ),
      //   ),
      // ),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class TempGridDataTableSource2 extends DataTableSource {
  final List<TempGrid> data;

  TempGridDataTableSource2({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.itemNumber.toString())),
      DataCell(Text(rowData.quantityOrdered.toString())),
      DataCell(Text(rowData.unitPrice)),
      DataCell(Text(rowData.extendedPrice)),
      DataCell(
        InkWell(
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString(
                SharedPref.itemN, rowData.itemNumber.toString());
            await prefs.setString(
                SharedPref.quantity, rowData.quantityOrdered.toString());
            Get.to(() => GridDetails());
          },
          child: Text(
            'Details',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _CreateSoGridState extends State<CreateSoGrid> {
  final globalKey = GlobalKey<ScaffoldState>();
  CreateSoBloc _createSoBloc =
      CreateSoBloc(createSoRepository: CreateSoRepositoryImpl());
  final _kitController = TextEditingController();
  final _lotController = TextEditingController();
  final _itemController = TextEditingController();
  final _priceController = TextEditingController();
  final _qtyController = TextEditingController();
  FocusNode _focusNodePo;
  FocusNode _focusNodeItem;
  FocusNode _focusNodeQty;
  String barcode1 = "";
  String barcode2 = "";
  String barcode3 = "";
  String barcode4 = "";
  String _branchPlant, _customer, _customerPo, _userId;
  bool _visible;

  List<GridIn13> gridDatas = [];
  List<TempGrid> tempDatas = [];
  List<GridIn11> detailDatas = [];
  List<Detail> postDatas = [];

  @override
  void initState() {
    super.initState();
    _focusNodePo = FocusNode();
    _focusNodeItem = FocusNode();
    _focusNodeQty = FocusNode();
    _kitController.text = '-';
    _lotController.text = '';
    _itemController.text = '';
    _priceController.text = '-';
    _qtyController.text = '';
    _visible = false;
    print(_visible);
    SharedPreferences.getInstance().then(
      (prefVal) => {
        setState(
          () {
            _userId = prefVal.getString(SharedPref.userID) ?? false;
            _branchPlant = prefVal.getString(SharedPref.branchPlant) ?? false;
            _customer = prefVal.getString(SharedPref.customer) ?? false;
            _customerPo = prefVal.getString(SharedPref.customerPo) ?? false;
          },
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      key: globalKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: BlocProvider<CreateSoBloc>(
          create: (context) => CreateSoBloc(
            createSoRepository: CreateSoRepositoryImpl(),
          ),
          child: BlocListener<CreateSoBloc, CreateSoState>(
            bloc: _createSoBloc,
            listener: (BuildContext context, CreateSoState state) {
              if (state is GetOrderNumber) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.previousOrder.previousOrder.toString()),
                    backgroundColor: Colors.green,
                  ),
                );
                Future.delayed(Duration(seconds: 2), () {
                  _createSoBloc.add(PostSoHistoryNewEvent(
                    doco: state.previousOrder.previousOrder.toString(),
                    mcu: _branchPlant,
                    an8: _customer,
                    vr01: _customerPo,
                    soDate: now,
                    gridData: postDatas,
                  ));
                });
              } else if (state is GetOrderKitNumber) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.previousOrder.serviceRequest1.forms.last
                        .fsP4210W4210G.data.zDoco102.value
                        .toString()),
                    backgroundColor: Colors.green,
                  ),
                );
                Future.delayed(Duration(seconds: 2), () {
                  _createSoBloc.add(PostSoHistoryNewEvent(
                    doco: state.previousOrder.serviceRequest1.forms.last
                        .fsP4210W4210G.data.zDoco102.value
                        .toString(),
                    mcu: _branchPlant,
                    an8: _customer,
                    vr01: _customerPo,
                    soDate: now,
                    gridData: postDatas,
                  ));
                });
              } else if (state is PostHistorySuccess) {
                Future.delayed(Duration(seconds: 2), () {
                  Get.off(() => CreateSoHeader());
                });
              }
            },
            child: BlocBuilder(
              bloc: _createSoBloc,
              builder: (context, state) {
                if (state is CreateSoInitial) {
                  // BotToast.closeAllLoading();
                  print(state);
                  return _buildWidget();
                } else if (state is GetOrderNumber) {
                  BotToast.closeAllLoading();
                  print(state);
                  return _buildWidgetOrder(state.previousOrder);
                } else if (state is FreeGoodsPriceHistoryNewLoaded) {
                  BotToast.closeAllLoading();
                  print(state);
                  return _buildWidgetPriceGoods(state.data);
                } else if (state is ItemBranchLoaded) {
                  BotToast.closeAllLoading();
                  print(state);
                  return _buildWidgetItemBranch(state.articles);
                } else if (state is FreeGoodsPriceHistoryNewFailed) {
                  BotToast.closeAllLoading();
                  print(state);
                  return Text(state.message);
                } else if (state is LoadingDataState) {
                  BotToast.showLoading();
                  print(state);
                  return _buildWidget();
                } else {
                  BotToast.closeAllLoading();
                  print(state);
                  return _buildWidget();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildWidget() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodeItem,
              controller: _itemController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                final result = await Connectivity().checkConnectivity();
                print(result);
                if (result == ConnectivityResult.none) {
                  print('offline');
                  print("submit container : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                }
              },
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningItem,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Kit / Non Kit',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              enabled: false,
              controller: _kitController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                final result = await Connectivity().checkConnectivity();
                print(result);
                if (result == ConnectivityResult.none) {
                  print('offline');
                  print("submit container : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  title: Text(
                    'Quantity',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  subtitle: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: _focusNodeQty,
                    controller: _qtyController,
                    style: TextStyle(fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      final result = await Connectivity().checkConnectivity();
                      print(result);
                      if (result == ConnectivityResult.none) {
                        print('offline');
                        print("submit kendaraan : ${_qtyController.text}");

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        BotToast.showLoading();
                        setState(() {
                          _onSubmitted(context);
                        });
                      },
                      child: Text(
                        "Add to Grid",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 14,
          child: Container(),
        ),
      ],
    );
  }

  Widget _buildWidgetItemBranch(List<ItemBranch> item) {
    if (item.first.f4102Stkt == 'K') {
      _kitController.text = 'Kit';
    } else {
      _kitController.text = 'Non Kit';
    }
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodeItem,
              controller: _itemController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                final result = await Connectivity().checkConnectivity();
                print(result);
                if (result == ConnectivityResult.none) {
                  print('offline');
                  print("submit container : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                }
              },
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningItem,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Kit / Non Kit',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              enabled: false,
              controller: _kitController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                final result = await Connectivity().checkConnectivity();
                print(result);
                if (result == ConnectivityResult.none) {
                  print('offline');
                  print("submit container : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  title: Text(
                    'Quantity',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  subtitle: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: _focusNodeQty,
                    controller: _qtyController,
                    style: TextStyle(fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      final result = await Connectivity().checkConnectivity();
                      print(result);
                      if (result == ConnectivityResult.none) {
                        print('offline');
                        print("submit kendaraan : ${_qtyController.text}");

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        BotToast.showLoading();
                        setState(() {
                          _onSubmitted(context);
                        });
                      },
                      child: Text(
                        "Add to Grid",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 14,
          child: Container(),
        ),
      ],
    );
  }

  Widget _buildWidgetOrder(CreateSoResponseModel previousOrder) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodeItem,
              controller: _itemController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                final result = await Connectivity().checkConnectivity();
                print(result);
                if (result == ConnectivityResult.none) {
                  print('offline');
                  print("submit container : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                }
              },
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningItem,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Kit / Non Kit',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              enabled: false,
              controller: _kitController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                final result = await Connectivity().checkConnectivity();
                print(result);
                if (result == ConnectivityResult.none) {
                  print('offline');
                  print("submit container : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  title: Text(
                    'Quantity',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  subtitle: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: _focusNodeQty,
                    controller: _qtyController,
                    style: TextStyle(fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      final result = await Connectivity().checkConnectivity();
                      print(result);
                      if (result == ConnectivityResult.none) {
                        print('offline');
                        print("submit kendaraan : ${_qtyController.text}");

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        setState(() {
                          _onSubmitted(context);
                        });
                      },
                      child: Text(
                        "Add to Grid",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 14,
          child: Center(
            child: Column(
              children: [
                Text('Order Created!'),
                Text('Order Number:'),
                Text(
                  previousOrder.previousOrder.toString(),
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetPriceGoods(FreeGoodsGetPriceResponseNew fggp) {
    print('Price Free Goods');
    int total = fggp.serviceRequest6.fsP4074W4074D.data.gridData.rowset
        .fold(0, (previousValue, element) => previousValue + element.zUprc95);
    print(formatCurrency(total));
    tempDatas.add(TempGrid(
      itemNumber: _itemController.text,
      quantityOrdered: _qtyController.text,
      unitPrice: formatCurrency(total),
      extendedPrice: formatCurrency(int.parse(_qtyController.text) * total),
      status: _kitController.text,
      priceHistory: jsonEncode(fggp),
    ));
    postDatas.add(Detail(
      litm: _itemController.text,
      qty: _qtyController.text,
      uprc: total.toString(),
      priceHistory: jsonEncode(fggp),
    ));

    _itemController.text = '';
    _priceController.text = '-';
    _qtyController.text = '';
    _kitController.text = '-';

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodeItem,
              controller: _itemController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                final result = await Connectivity().checkConnectivity();
                print(result);
                if (result == ConnectivityResult.none) {
                  print('offline');
                  print("submit container : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                }
              },
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeNoDuplicateItem,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Kit / Non Kit',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              enabled: false,
              controller: _kitController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
              onSubmitted: (value) async {
                final result = await Connectivity().checkConnectivity();
                print(result);
                if (result == ConnectivityResult.none) {
                  print('offline');
                  print("submit container : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

                  _checkItemBranch(context);
                  _focusNodeQty.requestFocus();
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  title: Text(
                    'Quantity',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  subtitle: TextField(
                    keyboardType: TextInputType.number,
                    focusNode: _focusNodeQty,
                    controller: _qtyController,
                    style: TextStyle(fontFamily: 'Montserrat'),
                    decoration: InputDecoration(
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) async {
                      final result = await Connectivity().checkConnectivity();
                      print(result);
                      if (result == ConnectivityResult.none) {
                        print('offline');
                        print("submit kendaraan : ${_qtyController.text}");

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Visibility(
                  visible: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: MaterialButton(
                      color: Colors.blue,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      onPressed: () {
                        setState(() {
                          detailDatas.removeLast();
                          _priceController.text = '-';
                          setState(() {
                            gridDatas.add(
                              GridIn13(
                                itemNumber: _itemController.text,
                                quantityOrdered: _qtyController.text,
                              ),
                            );
                            detailDatas.add(
                              GridIn11(
                                businessUnit: _branchPlant,
                                orderCo: "18000",
                                orTy: "S1",
                                lineNumber: "1",
                                customerNumber: _customer,
                                the2NdItemNumber: _itemController.text,
                                transQty: _qtyController.text,
                                um: "PC",
                                dateUpdated: freePriceDate,
                              ),
                            );
                            print('detailDatas: ' + jsonEncode(detailDatas));
                            _createSoBloc.add(GetFreeGoodsPriceHistoryNewEvent(
                                gridData: detailDatas));
                            _itemController.text = '';
                            _qtyController.text = '';
                          });
                        });
                      },
                      child: Text(
                        "Add to Grid",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 14,
          child: tempDatas.length > 0
              ? SingleChildScrollView(
                  child: PaginatedDataTable(
                    header: Text('SO Grid'),
                    columns: [
                      DataColumn(label: Text('Item Number')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Unit Price')),
                      DataColumn(label: Text('Extended Price')),
                      DataColumn(label: Text('Status')),
                      DataColumn(label: Text('Details')),
                    ],
                    source: TempGridDataTableSource(data: tempDatas),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }

  _onSubmitted(BuildContext context) {
    setState(() {
      gridDatas.add(
        GridIn13(
          itemNumber: _itemController.text,
          quantityOrdered: _qtyController.text,
        ),
      );
      detailDatas.add(
        GridIn11(
          businessUnit: _branchPlant,
          orderCo: "18000",
          orTy: "S1",
          lineNumber: "1",
          customerNumber: _customer,
          the2NdItemNumber: _itemController.text,
          transQty: _qtyController.text,
          um: "PC",
          dateUpdated: freePriceDate,
        ),
      );
      print('detailDatas: ' + jsonEncode(detailDatas));
      _createSoBloc
          .add(GetFreeGoodsPriceHistoryNewEvent(gridData: detailDatas));
    });

    _focusNodePo.requestFocus();
  }

  _checkItemBranch(BuildContext context) {
    BotToast.showLoading();
    _createSoBloc.add(GetItemBranchEvent(
      the2NdItemNumber1: _itemController.text,
      businessUnit1: _branchPlant,
    ));
  }

  _onUpSubmit(BuildContext context) {
    BotToast.showLoading();
    if (tempDatas.first.status != 'Kit') {
      print('Non Kit');
      _createSoBloc.add(CreateSoEntry(
        branchPlant: _branchPlant,
        customer: _customer,
        customerPo: _customerPo,
        gridData: gridDatas,
        transactionOriginator: _userId,
      ));
    } else {
      print('Kit');
      _createSoBloc.add(CreateSoKitEntry(
        branchPlant: _branchPlant,
        customer: _customer,
        customerPo: _customerPo,
        gridData: gridDatas,
        transactionOriginator: _userId,
      ));
    }
  }

  Future barcodeScanningItem() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() async {
        this._itemController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit Container : ${_itemController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.itemN, _itemController.text);
          print('Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Location Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.itemN, _itemController.text);
          print('Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
        }
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode1 = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode1 = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode1 = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode1 = 'Unknown error: $e');
    }
  }

  Future barcodeNoDuplicateItem() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() async {
        this._itemController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit Container : ${_itemController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.itemN, _itemController.text);
          print('Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Location Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
          setState(() {
            tempDatas.removeLast();
            postDatas.removeLast();
          });
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.itemN, _itemController.text);
          print('Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
          setState(() {
            tempDatas.removeLast();
            postDatas.removeLast();
          });
        }
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode1 = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode1 = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode1 = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode1 = 'Unknown error: $e');
    }
  }

  Widget _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Transform.translate(
        offset: Offset(-10, 0),
        child: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      titleSpacing: -20,
      title: Text(
        'Create SO Grid',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Product-Sans",
          fontSize: SizeConstant.textContentMedium,
        ),
      ),
      actions: [
        FlatButton(
          textColor: Colors.white,
          onPressed: () {
            _onUpSubmit(context);
          },
          child: Text("Submit to JDE"),
          shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: ColorCustom.blueGradient1),
        ),
      ),
    );
  }
}
