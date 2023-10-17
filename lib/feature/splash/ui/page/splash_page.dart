import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/widget/background.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _delay(context);
    return Scaffold(
      body: Stack(
        children: [
          Background(context: context, color: ColorCustom.blueGradient1),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
//                Image.asset(
//                  "assets/images/opus_b.png",
//                  height: 100,
//                  width: 200,
//                ),
                Text('ADVANCE',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Righteous-Reguler',
                    )),
              ],
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: SpinKitFoldingCube(
                size: 50.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _delay(BuildContext context) {
  Future<void>.delayed(const Duration(seconds: 2), () {});
}
