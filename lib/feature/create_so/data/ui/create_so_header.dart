import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_mobile_pos/feature/create_so/bloc/create_so_bloc.dart';
import 'package:royal_mobile_pos/feature/create_so/data/repository/create_so_repository.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/create_so_grid.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/customer/data/model/get_customer_response.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateSoHeader extends StatefulWidget {
  @override
  State<CreateSoHeader> createState() => _CreateSoHeaderState();
}

class _CreateSoHeaderState extends State<CreateSoHeader> {
  final globalKey = GlobalKey<ScaffoldState>();
  CreateSoBloc _poReceiptBloc =
      CreateSoBloc(createSoRepository: CreateSoRepositoryImpl());
  final _branchController = TextEditingController();
  final _customerController = TextEditingController();
  final _customerPoController = TextEditingController();
  String _branchPlant, _username, _token, _shopId;
  bool _visible;

  @override
  void initState() {
    super.initState();
    _poReceiptBloc.add(GetCustomerEntry());
    _visible = false;
    SharedPreferences.getInstance().then(
      (prefVal) => {
        setState(
          () {
            _username = prefVal.getString(SharedPref.loginName) ?? "";
            _branchPlant = prefVal.getString(SharedPref.loginBp) ?? "";
            _shopId = prefVal.getString(SharedPref.shopID) ?? "";
            _token = prefVal.getString(SharedPref.token) ?? false;
            _branchController.text = _branchPlant;
            _customerController.text = _shopId;
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
            bloc: _poReceiptBloc,
            listener: (BuildContext context, CreateSoState state) {
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
                if (state is CreateSoInitial) {
                  return _buildWidget();
                } else if (state is CustomerLoaded) {
                  return _buildWidgetDropdown(state.articles);
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
              'Branch Plant',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _branchController,
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
                  print("submit surat : ${_branchController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _branchController.text);
                  print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Surat Saved'),
                  );

                  globalKey.currentState.showSnackBar(snackBar);
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _branchController.text);
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
              'Customer',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _customerController,
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
                  print("submit driver : ${_customerController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _customerController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _customerController.text);
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
              'Customer PO',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _customerPoController,
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
                  print("submit driver : ${_customerController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _customerController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _customerController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
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
              minWidth: MediaQuery.of(context).size.width * 0.3,
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
          flex: 12,
          child: Visibility(
            visible: _visible,
            child: Container(),
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetDropdown(List<GetCustomerResponse> customer) {
    GetCustomerResponse selectedItem;
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Branch Plant',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _branchController,
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
                  print("submit surat : ${_branchController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _branchController.text);
                  print('Surat Saved: ${prefs.getString(SharedPref.surat)}');
                  final snackBar = SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Surat Saved'),
                  );

                  globalKey.currentState.showSnackBar(snackBar);
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.surat, _branchController.text);
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
              'Customer',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: DropdownButtonFormField<GetCustomerResponse>(
              value: selectedItem,
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
                print(selectedItem.nama);
              },
              items: customer.map((item) {
                return DropdownMenuItem<GetCustomerResponse>(
                  value: item,
                  child: Text(item.nama),
                );
              }).toList(),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Customer PO',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _customerPoController,
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
                  print("submit driver : ${_customerController.text}");

                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _customerController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
                } else {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(
                      SharedPref.driver, _customerController.text);
                  print('Driver Saved: ${prefs.getString(SharedPref.driver)}');
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
              minWidth: MediaQuery.of(context).size.width * 0.3,
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
          flex: 12,
          child: Visibility(
            visible: _visible,
            child: Container(),
          ),
        ),
      ],
    );
  }

  _onSubmitted(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPref.branchPlant, _branchController.text);
    await prefs.setString(SharedPref.customer, _customerController.text);
    await prefs.setString(SharedPref.customerPo, _customerPoController.text);
    print('Branch Plant Saved: ${prefs.getString(SharedPref.branchPlant)}');
    print('Customer Saved: ${prefs.getString(SharedPref.customer)}');
    print('Customer PO Saved: ${prefs.getString(SharedPref.customerPo)}');
    Get.to(() => CreateSoGrid());
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
        'Create SO Header',
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
