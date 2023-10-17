import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/widget/row_list_item.dart';

Widget itemListEquipment({String name}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            rowListItem(judul: "Equipment Number :", val: name),
          ],
        ),
      ],
    ),
  );
}
