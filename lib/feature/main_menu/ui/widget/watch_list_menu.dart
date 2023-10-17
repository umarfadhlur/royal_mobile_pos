import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/watchlist_count_wo_response.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/feature/work_order_list/ui/work_order_list.dart';

Widget WatchList(ResponseWatchlistCountWo watchList) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () {
          Get.to(() => WorkOrderList());
        },
        child: ListTile(
          tileColor: Colors.white,
          title: Text(
            'Number of Work Orders',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.blue,
            ),
            child: Text(
              watchList.rudCountwoF4801Dr.rowset.first.countWo.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
