import 'dart:io';
import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/widget/approval_count.dart';
import 'package:royal_mobile_pos/feature/approval/bloc/waiting_list_approval_bloc.dart';
import 'package:royal_mobile_pos/feature/approval/data/model/waiting_list_approval_response.dart';
import 'package:royal_mobile_pos/feature/approval/data/repository/waiting_list_approval_repository.dart';
import 'package:royal_mobile_pos/feature/approval/ui/approval_detail.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApprovalListPage extends StatefulWidget {
  @override
  _ApprovalListPageState createState() => _ApprovalListPageState();
}

class _ApprovalListPageState extends State<ApprovalListPage> {
  WaitingListApprovalBloc _waitingListApprovalBloc = WaitingListApprovalBloc(
      waitingListApprovalRepository: WaitingListApprovalRepositoryImpl());

  String _company, _username, _environment, _address;
  final oCcy = NumberFormat("#,##0.00", "en_US");

  void initState() {
    BotToast.showLoading();
    SharedPreferences.getInstance().then(
      (prefVal) => {
        setState(
          () {
            _company = prefVal.getString(SharedPref.company) ?? "";
            _username = prefVal.getString(SharedPref.username) ?? "";
            _environment = prefVal.getString(SharedPref.environtment) ?? "";
            _address = prefVal.getString(SharedPref.addressnumber) ?? "";
            _waitingListApprovalBloc.add(FilterListSelectEvent(
                personResponsible: _address, eventPoint: "W"));
            print('test $_company, $_username, $_environment, $_address');
          },
        ),
      },
    );
    super.initState();
  }

  void getFile(String doco, String dcto, String kcoo) async {
    Map recBody = {
      "username": "jde",
      "password": "jde",
      "inputs": [
        {"name": "Order Company", "value": kcoo},
        {"name": "Order Number ", "value": doco},
        {"name": "Order Type ", "value": dcto}
      ]
    };
    Map attBody = {
      "username": "jde",
      "password": "jde",
      "inputs": [
        {"name": "mnDocumentorderinvoicee", "value": doco},
        {"name": "szOrdertype", "value": dcto},
        {"name": "szDocumentCompany", "value": kcoo},
        {"name": "szOrderSuffix", "value": "000"},
        {"name": "sq", "value": "1"}
      ]
    };

    try {
      // Take Records Count
      final checkRec = await http.post(EndPoint.getApvDetail,
          headers: {
            "Content-Type": "application/json",
          },
          body: utf8.encode(json.encode(recBody)));
      var testRec = jsonDecode(checkRec.body);
      int rec = testRec['GetDataF55ORCH2']['records'];
      print('Count: ' + rec.toString());

      // Header Attachments
      final checkHeadExt = await http.post(EndPoint.dlAttach,
          headers: {
            "Content-Type": "application/json",
          },
          body: utf8.encode(json.encode(attBody)));
      final dlHeadAttach = await http.post(EndPoint.dlAttach,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/octet-stream",
          },
          body: utf8.encode(json.encode(attBody)));

      // Take File Extension
      var testExt = jsonDecode(checkHeadExt.body);
      List<String> ext = testExt['fileName'].toString().split('.');
      print('Extension: ' + ext.last);
      if (dlHeadAttach.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        if (ext.last == 'pdf') {
          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;
          File file = new File('$tempPath/$doco-$dcto-$kcoo.pdf');
          await file.writeAsBytes(dlHeadAttach.bodyBytes);
          await prefs.setString(SharedPref.filePath, file.path);
          print(prefs.getString(SharedPref.filePath));
        } else if (ext.last == 'png') {
          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;
          File file = new File('$tempPath/$doco-$dcto-$kcoo.png');
          await file.writeAsBytes(dlHeadAttach.bodyBytes);
          await prefs.setString(SharedPref.filePath, file.path);
          print(prefs.getString(SharedPref.filePath));
        } else if (ext.last == 'jpg') {
          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;
          File file = new File('$tempPath/$doco-$dcto-$kcoo.jpg');
          await file.writeAsBytes(dlHeadAttach.bodyBytes);
          await prefs.setString(SharedPref.filePath, file.path);
          print(prefs.getString(SharedPref.filePath));
        } else if (ext.last == 'jpeg') {
          Directory tempDir = await getTemporaryDirectory();
          String tempPath = tempDir.path;
          File file = new File('$tempPath/$doco-$dcto-$kcoo.jpeg');
          await file.writeAsBytes(dlHeadAttach.bodyBytes);
          await prefs.setString(SharedPref.filePath, file.path);
          print(prefs.getString(SharedPref.filePath));
        }
      } else {
        print('Tidak Ada');
      }
    } catch (value) {
      print(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.off(() => HomePage());
          },
        ),
        elevation: 0,
        title: Image.asset(
          'assets/images/logoOpusB.png',
          fit: BoxFit.fitHeight,
          height: 32,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: BlocProvider<WaitingListApprovalBloc>(
          create: (context) => WaitingListApprovalBloc(
            waitingListApprovalRepository: WaitingListApprovalRepositoryImpl(),
          ),
          child:
              BlocListener<WaitingListApprovalBloc, WaitingListApprovalState>(
            bloc: _waitingListApprovalBloc,
            listener: (BuildContext context, WaitingListApprovalState state) {
              if (state is ArticleLoadedState) {
                BotToast.closeAllLoading();
              }
              if (state is ArticleErrorState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              return Container();
            },
            child: BlocBuilder(
              bloc: _waitingListApprovalBloc,
              builder: (context, state) {
                if (state is WaitingListApprovalInitial) {
                  return Container();
                } else if (state is ArticleLoadedState) {
                  return buildList(state.articles);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildList(List<ApvList> articles) {
    return articles.length == 0
        ? Center(
            child: Text(
              'No Pending Approval',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                approvalCount(
                    count: articles.length.toString(),
                    title: 'Approval Purchase Order'),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: articles.length,
                  itemBuilder: (context, item) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: InkWell(
                        onTap: () async {
                          BotToast.showLoading();
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(
                              SharedPref.origName, articles[item].origName);
                          await prefs.setString(SharedPref.supplierName,
                              articles[item].supplierName);
                          await prefs.setString(SharedPref.quantityOrdered,
                              articles[item].quantityOrdered.toString());
                          await prefs.setString(
                            SharedPref.orderDate,
                            articles[item]
                                .orderDate
                                .toString()
                                .substring(0, 10),
                          );
                          await prefs.setString(SharedPref.orderNumber,
                              articles[item].orderNumber.toString());
                          await prefs.setString(
                              SharedPref.noPo, articles[item].noPo);
                          await prefs.setString(
                              SharedPref.orTy, articles[item].orTy);
                          await prefs.setString(
                              SharedPref.company, articles[item].orderCo);
                          await prefs.setString(
                              SharedPref.curCod, articles[item].curCod);
                          getFile(articles[item].orderNumber.toString(),
                              articles[item].orTy, articles[item].orderCo);
                          Future.delayed(Duration(seconds: 5), () {
                            Get.to(() => ApprovalDetailPage());
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              articles[item].origName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              articles[item].branch,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            articles[item].supplierName,
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            oCcy.format(
                                                  articles[item]
                                                          .quantityOrdered /
                                                      100,
                                                ) +
                                                ' ' +
                                                articles[item].curCod,
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              articles[item].noPo,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              articles[item]
                                                  .orderDate
                                                  .toString()
                                                  .substring(0, 10),
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Icon(Icons.chevron_right),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
