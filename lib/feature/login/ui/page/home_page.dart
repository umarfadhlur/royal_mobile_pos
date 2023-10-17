import 'package:royal_mobile_pos/feature/main_menu/bloc/menu_bloc.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/count_wo_response.dart';
import 'package:royal_mobile_pos/feature/login/bloc/login_bloc.dart';
import 'package:royal_mobile_pos/feature/login/data/repository/login_repo.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/watchlist_count_wo_response.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/repository/menu_repo.dart';
import 'package:royal_mobile_pos/feature/main_menu/ui/widget/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/login_page.dart';
import 'package:royal_mobile_pos/feature/main_menu/ui/widget/main_menu.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bot_toast/bot_toast.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _branchPlant, _username, _token, _shopId;
  MenuBloc _menuBloc;
  ResponseCountWo countWo;
  ResponseWatchlistCountWo watchList;

  LoginBloc _addLoginBloc = LoginBloc(loginRepository: LoginRepositoryImpl());

  void initState() {
    super.initState();
    _menuBloc = MenuBloc(menuRepository: MenuRepositoryImpl());
    _menuBloc.add(GetAN8Input());
    SharedPreferences.getInstance().then(
      (prefVal) => {
        setState(
          () {
            _username = prefVal.getString(SharedPref.loginName) ?? "";
            _branchPlant = prefVal.getString(SharedPref.loginBp) ?? "";
            _shopId = prefVal.getString(SharedPref.shopID) ?? "";
            _token = prefVal.getString(SharedPref.token) ?? false;
          },
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Image.asset(
          'assets/images/logoOpusB.png',
          fit: BoxFit.fitHeight,
          height: 32,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            tooltip: "Logout",
            onPressed: () {
              BotToast.showLoading(duration: Duration(milliseconds: 500));
              _addLoginBloc.add(LogoutSubmit(token: _token));
              Get.off(() => LoginPage());
              SharedPreferences.getInstance().then(
                (prefVal) => {
                  setState(
                    () {
                      prefVal.setString(SharedPref.username, '');
                      prefVal.setString(SharedPref.password, '');
                    },
                  ),
                },
              );
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              tileColor: Theme.of(context).primaryColor,
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile1.jpg'),
              ),
              title: Text(
                '$_username\n$_branchPlant\n$_shopId',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            MainMenu(),
            SizedBox(height: size.width * 0.05),
          ],
        ),
      ),
    );
  }
}
