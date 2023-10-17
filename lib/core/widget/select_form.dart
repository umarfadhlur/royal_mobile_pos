import 'package:flutter/material.dart';

Widget SelectForm({Function function,String textFinal, String title }){
//  String textFinal = "$text1 - $text2";
//  if (text1 != null && text2 != null){
//      textFinal = "$text1 - $text2";
//  } else {
//      textFinal = text;
//  }
  return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white),
          child: Material(
            child: InkWell(
              onTap: function,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                  CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text( title,
                          style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                              color: Colors.black)),
                    ),
                    new Expanded(
                        child: Align(
                            alignment:
                            Alignment.centerRight,
                            child: Text(
                                textFinal ,
                                style: new TextStyle(
                                    fontWeight:
                                    FontWeight
                                        .bold,
                                    fontSize: 12.0,
                                    color: Colors
                                        .black))
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
}