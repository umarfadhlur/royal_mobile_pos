import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';

Widget ButtonLogin({Function onPress, String textName, List<Color> color}) {
  return Padding(
    padding: EdgeInsets.only(
        top: PaddingConstant.formInputLow,
        left: PaddingConstant.formInput,
        right: PaddingConstant.formInput),
    child: RaisedButton(
      onPressed: onPress,
      splashColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      padding: EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: color,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Container(
          constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: Text(
            textName,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: SizeConstant.textContentMedium,
                fontFamily: "Product-Sans"),
          ),
        ),
      ),
    ),
  );
}
