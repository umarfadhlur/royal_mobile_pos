import 'package:flutter/material.dart';

Widget Background({BuildContext context, List<Color> color}){
  return  Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: color,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
  );
}