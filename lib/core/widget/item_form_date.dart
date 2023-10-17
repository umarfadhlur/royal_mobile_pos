import 'package:flutter/material.dart';

Widget InputFormDate(
    {String title,
    TextEditingController controller,
    IconData icon,
    Function onTap}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: Material(
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Material(
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(title,
                        style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                            color: Colors.black)),
                    new Expanded(
                      child: new TextField(
                        readOnly: true,
                        onTap: onTap,
                        controller: controller,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.blue,
                        ),
                        decoration: new InputDecoration(
                            suffixIcon: Icon(
                              icon,
                              size: 20,
                            ),
                            border: InputBorder.none),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
