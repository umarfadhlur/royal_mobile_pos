import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/widget/background.dart';
import 'package:royal_mobile_pos/core/widget/button_login.dart';
import 'package:royal_mobile_pos/core/widget/text_form_input.dart';
import 'package:royal_mobile_pos/feature/login/bloc/login_bloc.dart';
import 'package:royal_mobile_pos/feature/login/data/repository/login_repo.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _urlController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginBloc _loginBloc = LoginBloc(loginRepository: LoginRepositoryImpl());
  bool _isHidePass = true;
  bool isSwitched = false;

  _loginProgress(String username, String password) {
    BotToast.showLoading();
    _loginBloc.add(LocalLoginSubmit(username: username, password: password));
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePass = !_isHidePass;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _openPreferences() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    right: -40.0,
                    top: -40.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close),
                          color: Colors.white,
                        ),
                        backgroundColor: ColorCustom.blueColor,
                      ),
                    ),
                  ),
                  Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'URL Preferences',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Product-Sans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              color: ColorCustom.blueColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Product-Sans", fontSize: 15.0),
                            controller: _urlController,
                            decoration: InputDecoration(
                              hintText: "Input URL Here..",
                              contentPadding: EdgeInsets.all(15.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            color: ColorCustom.blueColor,
                            child: Text("Submit"),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    }

    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(loginRepository: LoginRepositoryImpl()),
      child: BlocListener(
          bloc: _loginBloc,
          listener: (context, state) {
            print("login state : $state");
            if (state is LoginErrorState) {
              BotToast.closeAllLoading();
              _scaffoldKey.currentState.showSnackBar(new SnackBar(
                backgroundColor: Colors.red,
                content: new Text(state.message),
              ));
            }
            if (state is LoginSuccessState) {
              BotToast.closeAllLoading();
              Get.off(() => HomePage());
            }
            if (state is LoginLocalState) {
              BotToast.closeAllLoading();
              Get.off(() => HomePage());
              // _loginBloc
              //     .add(LoginSubmit(username: 'jde', password: 'jde'));
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              print("stateeeee : $state");
              return Scaffold(
                key: _scaffoldKey,
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Background(
                            context: context, color: ColorCustom.whiteGradient),
                        PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Text(
                                "Preferences",
                                style: TextStyle(
                                  color: ColorCustom.darkGrey,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Product-Sans',
                                ),
                              ),
                            ),
                          ],
                          color: Colors.white,
                          elevation: 4,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          onSelected: (value) {
                            _openPreferences();
                          },
                        ),
                        Positioned(
                          top: 50.0,
                          bottom: 0.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Form(
                                child: Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                ),
                                Image.asset(
                                  'assets/images/logoOpusB.png',
                                  height: 50,
                                  //width: 60,
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 67,
                                  child: Text(
                                    'Sign In \nto Your Account',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'Product-Sans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      color: ColorCustom.blueColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormInput(
                                    iconName: Icon(
                                      Icons.people,
                                      color: Colors.white,
                                    ),
                                    paddingForm: EdgeInsets.only(
                                        top: 10,
                                        left: PaddingConstant.formInput,
                                        right: PaddingConstant.formInput),
                                    hintText: "username",
                                    isURL: false,
                                    isEmail: true,
                                    isPassword: false,
                                    controllerName: _emailController),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormInput(
                                    iconName: Icon(
                                      Icons.vpn_key,
                                      color: Colors.white,
                                    ),
                                    paddingForm: EdgeInsets.only(
                                        top: 10,
                                        left: PaddingConstant.formInput,
                                        right: PaddingConstant.formInput),
                                    hintText: "password",
                                    isURL: false,
                                    isEmail: false,
                                    isPassword: _isHidePass,
                                    controllerName: _passwordController,
                                    pass: GestureDetector(
                                      onTap: () => _togglePasswordVisibility(),
                                      child: Icon(
                                        _isHidePass
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: _isHidePass
                                            ? Colors.grey[300]
                                            : ColorCustom.darkGrey,
                                      ),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ButtonLogin(
                                  color: ColorCustom.blueGradient1,
                                  textName: "LOGIN",
                                  onPress: () {
                                    _loginProgress(_emailController.text,
                                        _passwordController.text);
                                  },
                                ),
                              ],
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
