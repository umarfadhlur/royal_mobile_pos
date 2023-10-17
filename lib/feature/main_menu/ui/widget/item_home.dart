import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/color.dart';

Widget itemHomeMain({String txtItem, Function onTap, String txtImg}) {
  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: ColorCustom.blueColor,
          width: 2.0,
        )),
    child: InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              txtImg,
              height: 60,
              width: 60,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            txtItem,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: ColorCustom.darkGrey,
              fontFamily: "Product-Sans",
            ),
          )
        ],
      ),
    ),
  );
  // return Column(
  //   children: [
  //     Material(
  //       //borderRadius: BorderRadius.circular(10),
  //       color: Colors.orange,
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(10),
  //         splashColor: Colors.white,
  //         onTap: onTap,
  //         child: Padding(
  //           padding: const EdgeInsets.all(10),
  //           child: Image.asset(
  //             txtImg,
  //             height: 30,
  //             width: 30,
  //           ),
  //         ),
  //       ),
  //     ),
  //     SizedBox(
  //       height: 10,
  //     ),
  //     Text(
  //       txtItem,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         fontSize: 10,
  //         color: ColorCustom.darkGrey,
  //         fontFamily: "Product-Sans",
  //       ),
  //     )
  //   ],
  // );
}
