import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_mobile_pos/feature/bom/bloc/bom_bloc.dart';
import 'package:royal_mobile_pos/feature/bom/data/model/bom_response.dart';
import 'package:royal_mobile_pos/feature/bom/data/repository/bom_repository.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetBom extends StatefulWidget {
  @override
  State<GetBom> createState() => _GetBomState();
}

class PriceListDataTableSource extends DataTableSource {
  final List<Rowset> data;

  PriceListDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.f3002Litm.toString())),
      DataCell(Text(rowData.f3002Qnty.toString())),
      DataCell(Text(rowData.f3002Um)),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _GetBomState extends State<GetBom> {
  final globalKey = GlobalKey<ScaffoldState>();
  BomBloc _bomBloc = BomBloc(bomRepository: BomRepositoryImpl());
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
        child: BlocProvider<BomBloc>(
          create: (context) => BomBloc(
            bomRepository: BomRepositoryImpl(),
          ),
          child: BlocListener<BomBloc, BomState>(
            bloc: _bomBloc,
            listener: (BuildContext context, BomState state) {
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
              bloc: _bomBloc,
              builder: (context, state) {
                if (state is BomInitial) {
                  return _buildWidget();
                } else if (state is BomLoaded) {
                  BotToast.closeAllLoading();
                  return buildArticleList(state.articles);
                } else if (state is BomNotFound) {
                  BotToast.closeAllLoading();
                  return _buildWidget();
                } else if (state is ArticleLoadingState) {
                  BotToast.showLoading();
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
              'the 2nd Item Number',
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
              'Branch',
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
          flex: 14,
          child: Visibility(
            visible: true,
            child: Column(),
          ),
        ),
      ],
    );
  }

  Widget buildArticleList(List<Rowset> articles) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'the 2nd Item Number',
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
              'Branch',
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
          flex: 14,
          child: Visibility(
            visible: true,
            child: Column(
              children: [
                Expanded(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: PaginatedDataTable(
                      header: Text('Get BOM'),
                      columns: [
                        DataColumn(label: Text('the 2nd Item Number')),
                        DataColumn(label: Text('Qty')),
                        DataColumn(label: Text('UoM')),
                      ],
                      source: PriceListDataTableSource(data: articles),
                    ),
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
    _bomBloc.add(GetBomEvent(
      the2ndItemNumber: _itemController.text,
      branch1: _businessController.text,
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
        'Get BOM',
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
