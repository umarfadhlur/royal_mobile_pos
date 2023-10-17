import 'package:flutter/material.dart';
Widget rowListItem({String judul, val}){
  return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(judul,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.black)),
             SizedBox(width: 10,),       
            Text(val,
                style: new TextStyle(
                    fontSize: 13.0,
                    color: Colors.black)),
          ]
  );
}