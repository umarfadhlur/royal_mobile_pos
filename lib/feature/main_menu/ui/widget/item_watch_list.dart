import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/color.dart';
import 'package:royal_mobile_pos/core/widget/item_list_menu.dart';

class ItemWatchListHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _crossAxisSpacing = 8;
    var _screenWidth = MediaQuery.of(context).size.width;
    var _crossAxisCount = 4;
    var _width = (_screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    var cellHeight = 75;
    var _aspectRatio = _width / cellHeight;
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width - 10,
      color: ColorCustom.blueColor,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: ColorCustom.blueColor,
              width: 2.0,
            )),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/watchlist.png',
                height: 60,
                width: 60,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Watch List",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: ColorCustom.darkGrey,
                fontFamily: "Product-Sans",
              ),
            )
          ],
        ),
      ),
      //     child: ListView(
      //   shrinkWrap: true,
      //   children: [
      //     itemList(title: 'judul', subtitle: 'keterangan', number: '1'),
      //     itemList(title: 'judul', subtitle: 'keterangan', number: '2'),
      //     itemList(title: 'judul', subtitle: 'keterangan', number: '11'),
      //     itemList(title: 'judul', subtitle: 'keterangan', number: '13'),
      //     itemList(title: 'judul', subtitle: 'keterangan', number: '21'),
      //     itemList(title: 'judul', subtitle: 'keterangan', number: '11'),
      //   ],
      // )
    );
  }
}
