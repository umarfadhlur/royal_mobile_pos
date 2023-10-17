import 'package:barcode_scan/barcode_scan.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/po_receipt/bloc/po_receipt_bloc.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/model/get_item_description_response_model.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/model/get_qty_uom_response_model.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/model/po_receipt_new_param_modal.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/repository/po_receipt_repository.dart';
import 'package:royal_mobile_pos/feature/po_receipt/ui/po_receipt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PoReceiptGrid extends StatefulWidget {
  @override
  State<PoReceiptGrid> createState() => _PoReceiptGridState();
}

class _PoReceiptGridState extends State<PoReceiptGrid> {
  final globalKey = GlobalKey<ScaffoldState>();
  PoReceiptBloc _poReceiptBloc =
      PoReceiptBloc(poReceiptRepository: PoReceiptRepositoryImpl());
  final _poController = TextEditingController();
  final _lotController = TextEditingController();
  final _itemController = TextEditingController();
  final _itemDescController = TextEditingController();
  final _qtyController = TextEditingController();
  final _uomController = TextEditingController();
  FocusNode _focusNodePo;
  FocusNode _focusNodeLot;
  FocusNode _focusNodeItem;
  FocusNode _focusNodeItemDesc;
  FocusNode _focusNodeQty;
  FocusNode _focusNodeUom;
  String barcode1 = "";
  String barcode2 = "";
  String barcode3 = "";
  String barcode4 = "";
  String _surat, _driver, _container, _kendaraan;
  bool _visible;

  List<GridDatum> gridDatas = [];

  @override
  void initState() {
    super.initState();
    _focusNodePo = FocusNode();
    _focusNodeLot = FocusNode();
    _focusNodeItem = FocusNode();
    _focusNodeQty = FocusNode();
    _poController.text = '';
    _lotController.text = '';
    _itemController.text = '';
    _itemDescController.text = 'empty';
    _qtyController.text = '';
    _visible = false;
    print(_visible);
    SharedPreferences.getInstance().then(
      (prefVal) => {
        setState(
          () {
            _surat = prefVal.getString(SharedPref.surat) ?? false;
            _driver = prefVal.getString(SharedPref.driver) ?? false;
            _container = prefVal.getString(SharedPref.container) ?? false;
            _kendaraan = prefVal.getString(SharedPref.kendaraan) ?? false;
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
        child: BlocProvider<PoReceiptBloc>(
          create: (context) => PoReceiptBloc(
            poReceiptRepository: PoReceiptRepositoryImpl(),
          ),
          child: BlocListener<PoReceiptBloc, PoReceiptState>(
            bloc: _poReceiptBloc,
            listener: (BuildContext context, PoReceiptState state) {
              if (state is SuccessEntry) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Success Entry'),
                    backgroundColor: Colors.green,
                  ),
                );
                Future.delayed(Duration(seconds: 1), () {
                  Get.off(() => PoReceipt());
                });
              }
              if (state is LotFound) {
                BotToast.closeAllLoading();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.green,
                  ),
                );
              }
              if (state is LotNotFound) {
                // _focusNodeItem.requestFocus();
                _poReceiptBloc.add(GetQtyUom(lotNumber: _lotController.text));
              }
              if (state is QtyUomLoaded) {
                setState(() {
                  _qtyController.text = state.qtyuoms.first.quantity;
                  _uomController.text = state.qtyuoms.first.uom;
                  _itemController.text = state.qtyuoms.first.itemNumber;
                });
                Future.delayed(Duration(seconds: 1), () {
                  if (_itemController.text != '') {
                    _poReceiptBloc
                        .add(GetItemDesc(itemDesc: _itemController.text));
                  } else {
                    print('Not Found');
                  }
                });
              }
              if (state is ItemDescLoaded) {
                setState(() {
                  _itemDescController.text = state.descs.first.description +
                      ' ' +
                      state.descs.first.descriptionLine2;
                });
              }
            },
            child: BlocBuilder(
              bloc: _poReceiptBloc,
              builder: (context, state) {
                if (state is PoReceiptInitial) {
                  BotToast.closeAllLoading();
                  return _buildWidget();
                } else if (state is LotFound) {
                  BotToast.closeAllLoading();
                  return _buildWidget();
                } else if (state is LotNotFound) {
                  return _buildWidget();
                } else if (state is QtyUomLoaded) {
                  return _buildWidgetQty(state.qtyuoms);
                } else if (state is ItemDescLoaded) {
                  BotToast.closeAllLoading();
                  return _buildWidgetDesc(state.descs);
                } else {
                  BotToast.closeAllLoading();
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
              'PO Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodePo,
              controller: _poController,
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
                  print("submit surat : ${_poController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.po, _poController.text);
                  print('PO Saved: ${prefs.getString(SharedPref.po)}');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('PO Saved'),
                  );
                  globalKey.currentState.showSnackBar(snackBar);
                  _focusNodeLot.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.po, _poController.text);
                  print('PO Saved: ${prefs.getString(SharedPref.po)}');
                  _focusNodeLot.requestFocus();
                }
              },
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningSurat,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Lot Serial Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodeLot,
              controller: _lotController,
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
                  print("submit driver : ${_lotController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.lotN, _lotController.text);
                  print(
                      'Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');
                  _focusNodeItem.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.lotN, _lotController.text);
                  print(
                      'Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');
                  BotToast.showLoading();
                  _checkLot(context);

                  // _focusNodeItem.requestFocus();
                }
              },
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningDriver,
            ),
          ),
        ),
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
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                  _poReceiptBloc
                      .add(GetItemDesc(itemDesc: _itemController.text));
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
              onPressed: barcodeScanningContainer,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Description',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              enabled: false,
              focusNode: _focusNodeItemDesc,
              controller: _itemDescController,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
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
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

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
                        _focusNodeUom.requestFocus();
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.quantity, _qtyController.text);
                        print(
                            'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                        _focusNodeUom.requestFocus();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  title: Text(
                    'UOM',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  subtitle: TextField(
                    focusNode: _focusNodeUom,
                    controller: _uomController,
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
                        print("submit kendaraan : ${_uomController.text}");

                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.uom, _uomController.text);
                        print('UOM Saved: ${prefs.getString(SharedPref.uom)}');
                        _onSubmitted(context);
                      } else {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString(
                            SharedPref.uom, _uomController.text);
                        print('UOM Saved: ${prefs.getString(SharedPref.uom)}');
                        _onSubmitted(context);
                      }
                    },
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
          flex: 11,
          child: Visibility(
            visible: true,
            child: buildPo(),
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetQty(List<QtyUom> lists) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'PO Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodePo,
              controller: _poController,
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
                  print("submit surat : ${_poController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.po, _poController.text);
                  print('PO Saved: ${prefs.getString(SharedPref.po)}');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('PO Saved'),
                  );
                  globalKey.currentState.showSnackBar(snackBar);
                  _focusNodeLot.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.po, _poController.text);
                  print('PO Saved: ${prefs.getString(SharedPref.po)}');
                  _focusNodeLot.requestFocus();
                }
              },
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningSurat,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Lot Serial Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  _lotController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _lotController.value.text.length);
                }
              },
              child: TextField(
                focusNode: _focusNodeLot,
                controller: _lotController,
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
                    print("submit driver : ${_lotController.text}");

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(SharedPref.lotN, _lotController.text);
                    print(
                        'Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');
                    _focusNodeItem.requestFocus();
                  } else {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(SharedPref.lotN, _lotController.text);
                    print(
                        'Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');
                    BotToast.showLoading();
                    _checkLot(context);
                  }
                },
              ),
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningDriver,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  _itemController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _itemController.value.text.length);
                }
              },
              child: TextField(
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
                    await prefs.setString(
                        SharedPref.itemN, _itemController.text);
                    print(
                        'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                    _focusNodeQty.requestFocus();
                  } else {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        SharedPref.itemN, _itemController.text);
                    print(
                        'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                    _poReceiptBloc
                        .add(GetItemDesc(itemDesc: _itemController.text));
                    _focusNodeQty.requestFocus();
                  }
                },
              ),
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningContainer,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Description',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              enabled: false,
              focusNode: _focusNodeItemDesc,
              controller: _itemDescController,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
              ),
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
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

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
                  subtitle: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        _qtyController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _qtyController.value.text.length);
                      }
                    },
                    child: TextField(
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
                          _focusNodeUom.requestFocus();
                        } else {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              SharedPref.quantity, _qtyController.text);
                          print(
                              'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                          _focusNodeUom.requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  title: Text(
                    'UOM',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  subtitle: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        _uomController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _uomController.value.text.length);
                      }
                    },
                    child: TextField(
                      focusNode: _focusNodeUom,
                      controller: _uomController,
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
                          print("submit kendaraan : ${_uomController.text}");

                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              SharedPref.uom, _uomController.text);
                          print(
                              'UOM Saved: ${prefs.getString(SharedPref.uom)}');
                          _onSubmitted(context);
                        } else {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              SharedPref.uom, _uomController.text);
                          print(
                              'UOM Saved: ${prefs.getString(SharedPref.uom)}');
                          _onSubmitted(context);
                        }
                      },
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
          flex: 11,
          child: Visibility(
            visible: true,
            child: buildPo(),
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetDesc(List<ItemDesc> descs) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'PO Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodePo,
              controller: _poController,
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
                  print("submit surat : ${_poController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.po, _poController.text);
                  print('PO Saved: ${prefs.getString(SharedPref.po)}');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('PO Saved'),
                  );
                  globalKey.currentState.showSnackBar(snackBar);
                  _focusNodeLot.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.po, _poController.text);
                  print('PO Saved: ${prefs.getString(SharedPref.po)}');
                  _focusNodeLot.requestFocus();
                }
              },
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningSurat,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Lot Serial Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  _lotController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _lotController.value.text.length);
                }
              },
              child: TextField(
                focusNode: _focusNodeLot,
                controller: _lotController,
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
                    print("submit driver : ${_lotController.text}");

                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(SharedPref.lotN, _lotController.text);
                    print(
                        'Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');
                    _focusNodeItem.requestFocus();
                  } else {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(SharedPref.lotN, _lotController.text);
                    print(
                        'Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');

                    BotToast.showLoading();
                    _checkLot(context);

                    // _focusNodeItem.requestFocus();
                  }
                },
              ),
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningDriver,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  _itemController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _itemController.value.text.length);
                }
              },
              child: TextField(
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
                    await prefs.setString(
                        SharedPref.itemN, _itemController.text);
                    print(
                        'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                    _focusNodeQty.requestFocus();
                  } else {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        SharedPref.itemN, _itemController.text);
                    print(
                        'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
                    BotToast.showLoading();
                    _poReceiptBloc.add(UpdateItem(
                      lotNumber: _lotController.text,
                      itemNumber: _itemController.text,
                    ));
                    // _focusNodeQty.requestFocus();
                  }
                },
              ),
            ),
            trailing: IconButton(
              icon: new Icon(
                Icons.qr_code,
                color: Colors.blue,
                size: 35,
              ),
              onPressed: barcodeScanningContainer,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Item Description',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              enabled: false,
              focusNode: _focusNodeItemDesc,
              controller: _itemDescController,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
              ),
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
                  _focusNodeQty.requestFocus();
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(SharedPref.itemN, _itemController.text);
                  print(
                      'Item Number Saved: ${prefs.getString(SharedPref.itemN)}');

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
                  subtitle: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        _qtyController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _qtyController.value.text.length);
                      }
                    },
                    child: TextField(
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
                          _focusNodeUom.requestFocus();
                        } else {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              SharedPref.quantity, _qtyController.text);
                          print(
                              'Qty Saved: ${prefs.getString(SharedPref.quantity)}');
                          _focusNodeUom.requestFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                  title: Text(
                    'UOM',
                    style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  ),
                  subtitle: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        _uomController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _uomController.value.text.length);
                      }
                    },
                    child: TextField(
                      focusNode: _focusNodeUom,
                      controller: _uomController,
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
                          print("submit kendaraan : ${_uomController.text}");

                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              SharedPref.uom, _uomController.text);
                          print(
                              'UOM Saved: ${prefs.getString(SharedPref.uom)}');
                          _onSubmitted(context);
                        } else {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              SharedPref.uom, _uomController.text);
                          print(
                              'UOM Saved: ${prefs.getString(SharedPref.uom)}');
                          _onSubmitted(context);
                        }
                      },
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
          flex: 11,
          child: Visibility(
            visible: true,
            child: buildPo(),
          ),
        ),
      ],
    );
  }

  Widget buildPo() {
    return ListView.builder(
      itemCount: gridDatas.length,
      itemBuilder: (content, index) {
        final gridData = gridDatas[index];
        print(gridDatas.length);

        return Card(
          child: ListTile(
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(gridData.poNumber),
                ),
                Expanded(
                  flex: 1,
                  child: Text(gridData.itemNumber),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(gridData.lotSerialNumber),
                ),
                Expanded(
                  flex: 1,
                  child: Text(gridData.quantity + ' ' + gridData.uom),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _onSubmitted(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPref.po, _poController.text);
    await prefs.setString(SharedPref.lotN, _lotController.text);
    await prefs.setString(SharedPref.itemN, _itemController.text);
    await prefs.setString(SharedPref.quantity, _qtyController.text);
    await prefs.setString(SharedPref.uom, _uomController.text);
    print('PO Saved: ${prefs.getString(SharedPref.po)}');
    print('Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');
    print('Item Number Saved: ${prefs.getString(SharedPref.itemN)}');
    print('Qty Saved: ${prefs.getString(SharedPref.quantity)}');
    print('UOM Saved: ${prefs.getString(SharedPref.uom)}');

    setState(() {
      gridDatas.add(
        GridDatum(
          poNumber: _poController.text,
          lotSerialNumber: _lotController.text,
          itemNumber: _itemController.text,
          quantity: _qtyController.text,
          uom: _uomController.text,
        ),
      );
    });

    print(gridDatas.toString());

    _poController.text = '';
    _lotController.text = '';
    _itemController.text = '';
    _itemDescController.text = 'empty';
    _qtyController.text = '';
    _uomController.text = '';

    _focusNodePo.requestFocus();
  }

  _onUpSubmit(BuildContext context) async {
    _poReceiptBloc.add(NewPoEntry(
      noSurat: _surat,
      driver: _driver,
      containerID: _container,
      noKendaraan: _kendaraan,
      gridData: gridDatas,
    ));
  }

  _checkLot(BuildContext context) async {
    print('CHECK');
    _poReceiptBloc.add(LotCheck(
      lotNumber: _lotController.text,
    ));
  }

  Future barcodeScanningSurat() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() async {
        this._poController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit surat : ${_poController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.po, _poController.text);
          print('PO Saved: ${prefs.getString(SharedPref.po)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('PO Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.po, _poController.text);
          print('PO Saved: ${prefs.getString(SharedPref.po)}');
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

  Future barcodeScanningDriver() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() async {
        this._lotController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit driver : ${_lotController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.lotN, _lotController.text);
          print('Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Lot Number Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.lotN, _lotController.text);
          print('Lot Number Saved: ${prefs.getString(SharedPref.lotN)}');
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

  Future barcodeScanningContainer() async {
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

  Future barcodeScanningKendaraan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() async {
        this._qtyController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit kendaraan : ${_qtyController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.quantity, _qtyController.text);
          print('Qty Saved: ${prefs.getString(SharedPref.quantity)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Location Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.quantity, _qtyController.text);
          print('Qty Saved: ${prefs.getString(SharedPref.quantity)}');
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
        'PO Receipt Grid',
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
          child: Text("Submit"),
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
