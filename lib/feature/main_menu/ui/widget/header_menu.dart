import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';

Widget headerMenu(
    BuildContext context, String username, String environment, String company) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(left: 10.0, bottom: 10.0, right: 10),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color: Colors.grey,
            //blurRadius: 5.0, // soften the shadow
            //spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              1.0, // Move to right 10  horizontally
              1.0, // Move to bottom 10 Vertically
            ))
      ],
      gradient: LinearGradient(colors: ColorCustom.blueGradient1),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(00), bottomRight: Radius.circular(00)),
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Product-Sans",
                    fontSize: 30,
                  ),
                ),
                // Text(
                //   environment,
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontFamily: "Righteous-Reguler",
                //       fontSize: SizeConstant.textContentMin),
                // ),
                // Text(
                //   company,
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontFamily: "Righteous-Reguler",
                //       fontSize: SizeConstant.textContentMin),
                // ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
