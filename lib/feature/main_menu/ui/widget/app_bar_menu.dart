import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:get/get.dart';

Widget AppBarMenuCustom({Function logOut, String judul}) {
  return AppBar(
    elevation: 0.0,
    automaticallyImplyLeading: false,
    leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        }),
    //title: Text(judul),
    actions: [
      IconButton(
        icon: Icon(
          Icons.info,
          color: Colors.white,
        ),
        tooltip: "info",
        onPressed: () {
          //save();
        },
      ),
      IconButton(
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ),
          tooltip: "info",
          onPressed: logOut)
    ],
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: ColorCustom.blueGradient1),
      ),
    ),
  );
}
