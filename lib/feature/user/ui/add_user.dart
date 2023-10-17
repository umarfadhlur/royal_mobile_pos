import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_mobile_pos/feature/create_so/bloc/create_so_bloc.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/user/bloc/user_bloc.dart';
import 'package:royal_mobile_pos/feature/user/data/repository/user_repository.dart';
import 'package:royal_mobile_pos/feature/user/ui/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final globalKey = GlobalKey<ScaffoldState>();
  GetUserBloc _getUserBloc =
      GetUserBloc(getUserRepository: GetUserRepositoryImpl());
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _bpController = TextEditingController();
  final _shopController = TextEditingController();
  String barcode1 = "";
  String barcode2 = "";
  String barcode3 = "";
  String barcode4 = "";
  bool _visible;

  @override
  void initState() {
    super.initState();
    _visible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      key: globalKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: BlocProvider<GetUserBloc>(
          create: (context) => GetUserBloc(
            getUserRepository: GetUserRepositoryImpl(),
          ),
          child: BlocListener<GetUserBloc, GetUserState>(
            bloc: _getUserBloc,
            listener: (BuildContext context, GetUserState state) {
              if (state is SuccessEntry) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Success'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is AddUserSuccess) {
                Future.delayed(Duration(seconds: 2), () {
                  Get.off(() => UserList());
                });
              }
            },
            child: BlocBuilder(
              bloc: _getUserBloc,
              builder: (context, state) {
                if (state is GetUserInitial) {
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
              'User ID',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _userController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Password',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _passController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Name',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _nameController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Branch Plant',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _bpController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
            title: Text(
              'Shop ID',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 14),
            ),
            subtitle: TextField(
              controller: _shopController,
              style: TextStyle(fontFamily: 'Montserrat'),
              decoration: InputDecoration(
                isDense: true,
              ),
              textInputAction: TextInputAction.go,
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
          flex: 8,
          child: Container(),
        ),
      ],
    );
  }

  _onSubmitted(BuildContext context) {
    _getUserBloc.add(AddUserEvent(
      userId: _userController.text,
      password: _passController.text,
      name: _nameController.text,
      branchPlant: _bpController.text,
      shopId: _shopController.text,
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
            navigator.pop();
          },
        ),
      ),
      titleSpacing: -20,
      title: Text(
        'Add User',
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
