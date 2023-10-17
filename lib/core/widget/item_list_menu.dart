import 'package:flutter/material.dart';

Widget itemList({String number, String title, String subtitle}){
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Card(
      color: Colors.white,
      child: ListTile(
        leading: Text(number),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    ),
  );
}