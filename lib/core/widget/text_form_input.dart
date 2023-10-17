import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';

Widget TextFormInput(
    {String hintText,
    bool isPassword,
    Function onSaved,
    bool isEmail,
    bool isURL,
    EdgeInsets paddingForm,
    Function validator,
    TextEditingController controllerName,
    Icon iconName,
    GestureDetector pass}) {
  return Padding(
    padding: paddingForm,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        style: TextStyle(fontFamily: "Product-Sans", fontSize: 15.0),
        decoration: InputDecoration(
          suffixIcon: pass,
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  width: 0,
                  //color: ColorCustom.blueColor,
                  style: BorderStyle.none)),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            child: Container(
                decoration: BoxDecoration(
                    color: ColorCustom.blueColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )),
                child: iconName),
          ), // icon is 48px widget.
        ),
        obscureText: isPassword,
        controller: controllerName,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        onSaved: onSaved,
        validator: validator,
      ),
    ),
  );
}
