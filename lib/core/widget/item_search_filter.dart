import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:get/get.dart';

Widget ItemSearchFilter(
    {Function onPress1,
    Function onPress2,
    TextEditingController controller,
    Function onchange,
    String textHint}) {
  return Container(
    height: 50.0,
    width: double.infinity,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), color: Colors.white),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Get.back();
            },
            iconSize: 30.0,
          ),
        ),
        Expanded(
          flex: 5,
          child: TextField(
            textInputAction: TextInputAction.search,
            onChanged: onchange,
            controller: controller,
            decoration: InputDecoration(
              hintText: textHint,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15.0),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            tooltip: 'Filter',
            icon: Icon(FontAwesome5Solid.filter),
            onPressed: onPress2,
            iconSize: 25.0,
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            tooltip: 'Sort',
            icon: Icon(FontAwesome5Solid.sort_alpha_down),
            onPressed: onPress1,
            iconSize: 25.0,
          ),
        ),
      ],
    ),
  );
}
