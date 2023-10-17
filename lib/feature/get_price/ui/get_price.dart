import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_mobile_pos/core/constant/formatCurrency.dart';
import 'package:royal_mobile_pos/feature/get_price/bloc/get_price_bloc.dart';
import 'package:royal_mobile_pos/feature/get_price/data/model/get_price_response.dart';
import 'package:royal_mobile_pos/feature/get_price/data/repository/get_price_repository.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetPrice extends StatefulWidget {
  @override
  State<GetPrice> createState() => _GetPriceState();
}

class PriceListDataTableSource extends DataTableSource {
  final List<PriceList> data;

  PriceListDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.descAdjName.toString())),
      DataCell(Text(rowData.factorValueNumeric.toString())),
      DataCell(Text(formatCurrency(rowData.unitPrice))),
      DataCell(Text(rowData.bC)),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _GetPriceState extends State<GetPrice> {
  final globalKey = GlobalKey<ScaffoldState>();
  GetPriceBloc _getPriceBloc =
      GetPriceBloc(getPriceRepository: GetPriceRepositoryImpl());
  final _businessController = TextEditingController();
  final _itemController = TextEditingController();
  final _addressController = TextEditingController();
  final _kendaraanController = TextEditingController();
  FocusNode _focusNodeSurat;
  FocusNode _focusNodeDriver;
  FocusNode _focusNodeContainer;
  String barcode1 = "";
  String barcode2 = "";
  String barcode3 = "";
  String barcode4 = "";

  @override
  void initState() {
    super.initState();
    _focusNodeSurat = FocusNode();
    _focusNodeDriver = FocusNode();
    _focusNodeContainer = FocusNode();
    _businessController.text = '';
    _itemController.text = '';
    _addressController.text = '';
    _kendaraanController.text = '';
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
        child: BlocProvider<GetPriceBloc>(
          create: (context) => GetPriceBloc(
            getPriceRepository: GetPriceRepositoryImpl(),
          ),
          child: BlocListener<GetPriceBloc, GetPriceState>(
            bloc: _getPriceBloc,
            listener: (BuildContext context, GetPriceState state) {
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
              bloc: _getPriceBloc,
              builder: (context, state) {
                if (state is GetPriceInitial) {
                  return _buildWidget();
                } else if (state is PriceListLoaded) {
                  BotToast.closeAllLoading();
                  return buildArticleList(state.articles);
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
              controller: _businessController,
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
                  print("submit surat : ${_businessController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _businessController.text);
                  print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Surat Saved'),
                  );

                  globalKey.currentState.showSnackBar(snackBar);
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _businessController.text);
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
                  print("submit driver : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _itemController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _itemController.text);
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
              controller: _addressController,
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
                  print("submit container : ${_addressController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.container, _addressController.text);
                  print(
                      'Driver Saved: ${prefs.getString(SharedPref.container)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.container, _addressController.text);
                  print(
                      'Driver Saved: ${prefs.getString(SharedPref.container)}');
                }
              },
            ),
          ),
        ),
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
            visible: true,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, item) {
                return Card();
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildArticleList(List<PriceList> articles) {
    int total = articles.fold(
        0, (previousValue, element) => previousValue + element.unitPrice);
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
              controller: _businessController,
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
                  print("submit surat : ${_businessController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _businessController.text);
                  print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Surat Saved'),
                  );

                  globalKey.currentState.showSnackBar(snackBar);
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _businessController.text);
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
                  print("submit driver : ${_itemController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _itemController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _itemController.text);
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
              controller: _addressController,
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
                  print("submit container : ${_addressController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.container, _addressController.text);
                  print(
                      'Driver Saved: ${prefs.getString(SharedPref.container)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.container, _addressController.text);
                  print(
                      'Driver Saved: ${prefs.getString(SharedPref.container)}');
                }
              },
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: MaterialButton(
              color: Colors.blue,
              minWidth: MediaQuery.of(context).size.width * 0.2,
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
          flex: 11,
          child: Visibility(
            visible: true,
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: Text('Get SO Price'),
                      columns: [
                        DataColumn(label: Text('Desc\nAdj Name')),
                        DataColumn(label: Text('Factor Value\nNumeric')),
                        DataColumn(label: Text('Unit Price')),
                        DataColumn(label: Text('BC')),
                      ],
                      source: PriceListDataTableSource(data: articles),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Text(
                              'Amount - Price per Unit:',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          formatCurrency(total),
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _onSubmitted(BuildContext context) async {
    BotToast.showLoading();
    _getPriceBloc.add(GetPriceListEvent(
      addressNumber: _addressController.text,
      businessUnit: _businessController.text,
      itemNumber: _itemController.text,
    ));
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
        'Get SO Price',
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
