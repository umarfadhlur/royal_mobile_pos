import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/feature/bom/ui/get_bom.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/create_so_header.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/grid_details.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/so_history.dart';
import 'package:royal_mobile_pos/feature/customer/ui/customer_list.dart';
import 'package:royal_mobile_pos/feature/get_price/ui/get_price.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/feature/equipment_master/ui/equip_master_list.dart';
import 'package:royal_mobile_pos/feature/main_menu/ui/widget/qr.dart';
import 'package:royal_mobile_pos/feature/offline_wo/ui/work_order_list_offline.dart';
import 'package:royal_mobile_pos/feature/user/ui/user_list.dart';
import 'package:royal_mobile_pos/feature/work_order/add_work_order.dart';
import 'package:royal_mobile_pos/feature/work_order_list/ui/work_order_list.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: Container(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 4,
              mainAxisSpacing: 10.0,
              children: mainMenuItem,
            ),
          ),
        ),
      ),
    );
  }
}

List<MainMenuItem> mainMenuItem = [
  MainMenuItem(
    title: 'SO Price Detail',
    icon: Icons.download_rounded,
    colorBox: Colors.cyan,
    iconColor: Colors.white,
    press: () {
      Get.to(() => GetPrice());
    },
  ),
  MainMenuItem(
    title: 'User List',
    icon: Icons.person,
    colorBox: Colors.cyan,
    iconColor: Colors.white,
    press: () {
      Get.to(() => QRWidget());
    },
  ),
  MainMenuItem(
    title: 'Customer List',
    icon: Icons.handyman,
    colorBox: Colors.cyan,
    iconColor: Colors.white,
    press: () {
      Get.to(() => CustomerList());
    },
  ),
  MainMenuItem(
    title: 'Get BOM',
    icon: Icons.format_list_numbered_outlined,
    colorBox: Colors.cyan,
    iconColor: Colors.white,
    press: () {
      Get.to(() => GetBom());
    },
  ),
  MainMenuItem(
    title: 'Offline List',
    icon: Icons.post_add_outlined,
    colorBox: Colors.cyan,
    iconColor: Colors.white,
    press: () {
      Get.to(() => WorkOrderListOffline());
    },
  ),
  MainMenuItem(
    title: 'PO Approval',
    icon: Icons.check,
    colorBox: Colors.cyan,
    iconColor: Colors.white,
    press: () {
      Get.to(() => GridDetails());
    },
  ),
  MainMenuItem(
    title: 'SO History',
    icon: Icons.bookmark_border_outlined,
    colorBox: Colors.cyan,
    iconColor: Colors.white,
    press: () {
      Get.to(() => SoHistory());
    },
  ),
  MainMenuItem(
    title: 'Create SO',
    icon: Icons.upload_rounded,
    colorBox: Colors.cyan,
    iconColor: Colors.white,
    press: () {
      Get.to(() => CreateSoHeader());
    },
  ),
];

class MainMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color colorBox, iconColor;
  final Function() press;
  MainMenuItem(
      {this.title, this.icon, this.colorBox, this.iconColor, this.press});
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: press,
          child: Container(
            height: MediaQuery.of(context).size.width * 0.17,
            width: MediaQuery.of(context).size.width * 0.17,
            decoration: BoxDecoration(
              color: colorBox,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.only(top: 3.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
