import 'package:bot_toast/bot_toast.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:royal_mobile_pos/core/constant/color.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/login_page.dart';
import 'package:royal_mobile_pos/feature/main_menu/ui/widget/app_bar_menu.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String _environment, _company, _username, _token, _address;

  // Future<String> getData() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   company = sharedPreferences.getString(SharedPref.company)??"";
  //   username = sharedPreferences.getString(SharedPref.username)??"";
  //   environment = sharedPreferences.getString(SharedPref.environtment)??"";
  // }

  @override
  void initState() {
    super.initState();
    BotToast.cleanAll();
    
    SharedPreferences.getInstance().then((prefVal) => {
          setState(() {
            _company = prefVal.getString(SharedPref.company) ?? "";
            _username = prefVal.getString(SharedPref.username) ?? "";
            _environment = prefVal.getString(SharedPref.environtment) ?? "";
            _token = prefVal.getString(SharedPref.token) ?? false;
            _address = prefVal.getString(SharedPref.addressnumber) ?? "";
            print('Test $_company, $_username, $_environment, $_address');
            // addressNumberBloc.add(AddressNumberInput(name: 'User ID 1', val: _username, token: _token));
          })
        });
  }

  clear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        clear();
        Navigator.pop(context);
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Get.off(() => LoginPage());
//        BlocProvider.of<AuthBloc>(context).add(AuthEventLogout());
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout Confirmation"),
      content: Text("Are you sure want to logout?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        // backgroundColor: ColorCustom.blueColor,
        appBar: AppBarMenuCustom(
            logOut: () {
              showAlertDialog(context);
            },
            judul: _company),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: CustomPaint(
                  painter: RPSCustomPainter(),
                ),
              ),
              Positioned(
                top: size.height * 0.08,
                right: size.width * 0.12,
                child: Container(
                  width: 100.0,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border: new Border.all(
                      color: Colors.white,
                      width: 4.0,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.25,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.11),
                        child: Icon(
                          EvaIcons.globeOutline,
                          size: 40.0,
                          color: ColorCustom.blueColor,
                        ),
                      ),
                      Text(
                        'Expanse',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Product-Sans",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.35,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.11),
                        child: Icon(
                          EvaIcons.flipOutline,
                          size: 40.0,
                          color: ColorCustom.blueColor,
                        ),
                      ),
                      Text(
                        'Reimbursement',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Product-Sans",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.45,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.11),
                        child: Icon(
                          Icons.more_horiz,
                          size: 40.0,
                          color: ColorCustom.blueColor,
                        ),
                      ),
                      Text(
                        'Advanced',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Product-Sans",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.55,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.11),
                        child: Icon(
                          Icons.payments_outlined,
                          size: 40.0,
                          color: ColorCustom.blueColor,
                        ),
                      ),
                      Text(
                        'Payment Request',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Product-Sans",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.65,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.11),
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          size: 40.0,
                          color: ColorCustom.blueColor,
                        ),
                      ),
                      Text(
                        'Watch List',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Product-Sans",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.75,
                child: InkWell(
                  onTap: () {
                    Get.off(() => HomePage());
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.11),
                        child: Icon(
                          Icons.check,
                          size: 40.0,
                          color: ColorCustom.blueColor,
                        ),
                      ),
                      Text(
                        'Select Company',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "Product-Sans",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    child: Text(
                      _company,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Product-Sans",
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.2),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
            context: context,
            builder: (context) => new AlertDialog(
                  title: Text('Confirm Exit ?',
                      style:
                          new TextStyle(color: Colors.black, fontSize: 20.0)),
                  content: new Text(
                      'Are you sure you want to exit the app? Tap \'Yes\' to exit \'No\' to cancel.'),
                  actions: [
                    new FlatButton(
                      onPressed: () {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                      child:
                          new Text('Yes', style: new TextStyle(fontSize: 18.0)),
                    ),
                    new FlatButton(
                      onPressed: () => Navigator.pop(
                          context), // this line dismisses the dialog
                      child:
                          new Text('No', style: new TextStyle(fontSize: 18.0)),
                    )
                  ],
                )) ??
        false;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = ColorCustom.blueColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.quadraticBezierTo(
        0, size.height * 0.1595745, 0, size.height * 0.2127660);
    path_0.cubicTo(
        size.width * 0.1250000,
        size.height * 0.1698582,
        size.width * 0.3700000,
        size.height * 0.1762411,
        size.width * 0.5000000,
        size.height * 0.1773050);
    path_0.cubicTo(
        size.width * 0.6225000,
        size.height * 0.1769504,
        size.width * 0.8750000,
        size.height * 0.1861702,
        size.width,
        size.height * 0.1418440);
    path_0.quadraticBezierTo(
        size.width, size.height * 0.1063830, size.width, 0);
    path_0.lineTo(0, 0);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
