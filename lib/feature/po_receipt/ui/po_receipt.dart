import 'package:barcode_scan/barcode_scan.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:royal_mobile_pos/feature/po_receipt/bloc/po_receipt_bloc.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/repository/po_receipt_repository.dart';
import 'package:royal_mobile_pos/feature/po_receipt/ui/po_receipt_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PoReceipt extends StatefulWidget {
  @override
  State<PoReceipt> createState() => _PoReceiptState();
}

class _PoReceiptState extends State<PoReceipt> {
  final globalKey = GlobalKey<ScaffoldState>();
  PoReceiptBloc _poReceiptBloc =
      PoReceiptBloc(poReceiptRepository: PoReceiptRepositoryImpl());
  final _suratController = TextEditingController();
  final _driverController = TextEditingController();
  final _containerController = TextEditingController();
  final _kendaraanController = TextEditingController();
  FocusNode _focusNodeSurat;
  FocusNode _focusNodeDriver;
  FocusNode _focusNodeContainer;
  FocusNode _focusNodeKendaraan;
  String barcode1 = "";
  String barcode2 = "";
  String barcode3 = "";
  String barcode4 = "";
  bool _visible;

  @override
  void initState() {
    super.initState();
    _focusNodeSurat = FocusNode();
    _focusNodeDriver = FocusNode();
    _focusNodeContainer = FocusNode();
    _focusNodeKendaraan = FocusNode();
    _suratController.text = '';
    _driverController.text = '';
    _containerController.text = '';
    _kendaraanController.text = '';
    _visible = false;
    SharedPreferences.getInstance().then(
      (prefVal) => {
        setState(
          () {
            // _cc = prefVal.getString(SharedPref.cycleCount) ?? false;
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
                    content: Text('Success'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: BlocBuilder(
              bloc: _poReceiptBloc,
              builder: (context, state) {
                if (state is PoReceiptInitial) {
                  return _buildWidget();
                } else {
                  BotToast.closeAllLoading();
                  return buildLoading();
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
              'Business Unit',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodeSurat,
              controller: _suratController,
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
                  print("submit surat : ${_suratController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _suratController.text);
                  print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Surat Saved'),
                  );

                  globalKey.currentState.showSnackBar(snackBar);
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _suratController.text);
                  print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
                }
              },
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
              focusNode: _focusNodeDriver,
              controller: _driverController,
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
                  print("submit driver : ${_driverController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _driverController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _driverController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Address Number',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              focusNode: _focusNodeContainer,
              controller: _containerController,
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
                  print("submit container : ${_containerController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.container, _containerController.text);
                  print(
                      'Driver Saved: ${prefs.getString(SharedPref.container)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.container, _containerController.text);
                  print(
                      'Driver Saved: ${prefs.getString(SharedPref.container)}');
                }
              },
            ),
          ),
        ),
        // Expanded(
        //   flex: 2,
        //   child: ListTile(
        //     contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
        //     title: Text(
        //       'Nomor Kendaraan',
        //       style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
        //     ),
        //     subtitle: TextField(
        //       focusNode: _focusNodeKendaraan,
        //       controller: _kendaraanController,
        //       style: TextStyle(fontFamily: 'Montserrat'),
        //       decoration: InputDecoration(
        //         isDense: true,
        //       ),
        //       textInputAction: TextInputAction.go,
        //       onSubmitted: (value) async {
        //         final result = await Connectivity().checkConnectivity();
        //         print(result);
        //         if (result == ConnectivityResult.none) {
        //           print('offline');
        //           print("submit kendaraan : ${_kendaraanController.text}");

        //           final prefs = await SharedPreferences.getInstance();
        //           await prefs.setString(
        //               SharedPref.kendaraan, _kendaraanController.text);
        //           print(
        //               'Kendaraan Saved: ${prefs.getString(SharedPref.kendaraan)}');
        //         } else {
        //           final prefs = await SharedPreferences.getInstance();
        //           await prefs.setString(
        //               SharedPref.kendaraan, _kendaraanController.text);
        //           print(
        //               'Kendaraan Saved: ${prefs.getString(SharedPref.kendaraan)}');
        //         }
        //       },
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: MaterialButton(
              color: Colors.blue,
              minWidth: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () => _onSubmitted(context),
              child: Text(
                "Submit",
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: Visibility(
            visible: _visible,
            child: list(),
          ),
        ),
      ],
    );
  }

  Widget list() {
    return Column(
      children: [
        GestureDetector(
          child: Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('30AF'),
                  Text('15'),
                ],
              ),
              subtitle: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('30AF'),
                      Text('Each'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('LotNo:'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('desc', '30AF');
            await prefs.setString('qtyNum', '15');
            print(prefs.getString('desc'));
            print(prefs.getString('qtyNum'));
          },
        ),
        GestureDetector(
          child: Card(
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('30BF'),
                  Text('12'),
                ],
              ),
              subtitle: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('30BF'),
                      Text('Each'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('LotNo:'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('desc', '30BF');
            await prefs.setString('qtyNum', '12');
            print(prefs.getString('desc'));
            print(prefs.getString('qtyNum'));
          },
        ),
        Card(
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30CF'),
                Text('10'),
              ],
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('30CF'),
                    Text('Each'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LotNo:'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30DF'),
                Text('8'),
              ],
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('30DF'),
                    Text('Each'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LotNo:'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('30EF'),
                Text('5'),
              ],
            ),
            subtitle: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('30EF'),
                    Text('Each'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('LotNo:'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _onSubmitted(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPref.surat, _suratController.text);
    await prefs.setString(SharedPref.driver, _driverController.text);
    await prefs.setString(SharedPref.container, _containerController.text);
    await prefs.setString(SharedPref.kendaraan, _kendaraanController.text);
    print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
    print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
    print('Container Saved: ${prefs.getString(SharedPref.container)}');
    print('Kendaraan Saved: ${prefs.getString(SharedPref.kendaraan)}');
    Get.to(() => PoReceiptGrid());
  }

  Future barcodeScanningSurat() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() async {
        this._suratController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit surat : ${_suratController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.surat, _suratController.text);
          print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Surat Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.surat, _suratController.text);
          print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
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
        this._driverController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit driver : ${_driverController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.driver, _driverController.text);
          print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Driver Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(SharedPref.driver, _driverController.text);
          print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
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
        this._containerController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit Container : ${_containerController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              SharedPref.container, _containerController.text);
          print('Container Saved: ${prefs.getString(SharedPref.container)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Location Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              SharedPref.container, _containerController.text);
          print('Container Saved: ${prefs.getString(SharedPref.container)}');
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
        this._kendaraanController.text = barcode;
        final result = await Connectivity().checkConnectivity();
        print(result);
        if (result == ConnectivityResult.none) {
          print('offline');
          print("submit kendaraan : ${_kendaraanController.text}");

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              SharedPref.kendaraan, _kendaraanController.text);
          print('Kendaraan Saved: ${prefs.getString(SharedPref.kendaraan)}');
          final snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text('Location Saved'),
          );
          globalKey.currentState.showSnackBar(snackBar);
        } else {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
              SharedPref.kendaraan, _kendaraanController.text);
          print('Kendaraan Saved: ${prefs.getString(SharedPref.kendaraan)}');
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
            Get.off(() => HomePage());
          },
        ),
      ),
      titleSpacing: -20,
      title: Text(
        'Get Price',
        style: TextStyle( 
          color: Colors.white,
          fontFamily: "Product-Sans",
          fontSize: SizeConstant.textContentMedium,
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: ColorCustom.blueGradient1),
        ),
      ),
    );
  }
}
