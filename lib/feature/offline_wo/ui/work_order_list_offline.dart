import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:royal_mobile_pos/feature/offline_wo/utils/local_database/database.dart';
import 'package:royal_mobile_pos/feature/offline_wo/utils/local_database/table_createwo.dart';
import 'package:royal_mobile_pos/feature/work_order/data/cubit/work_order_bloc.dart';
import 'package:royal_mobile_pos/feature/work_order/data/repository/repository_add_work_order.dart';
import 'package:royal_mobile_pos/feature/work_order/edit_work_order.dart';
import 'package:sqflite/sqlite_api.dart';

class WorkOrderListOffline extends StatefulWidget {
  @override
  _WorkOrderListOfflineState createState() => _WorkOrderListOfflineState();
}

class _WorkOrderListOfflineState extends State<WorkOrderListOffline> {
  List<WorkOrder> workOrders;
  bool isLoading = false;

  WorkOrderBloc _addWorkOrderBloc =
      WorkOrderBloc(addWorkOrderRepository: AddWorkOrderRepositoryImpl());

  @override
  void initState() {
    super.initState();
    refreshWorkOrders();
  }

  Future refreshWorkOrders() async {
    setState(() => isLoading = true);

    this.workOrders = await WorkOrderDatabase.instance.readAllWorkOrder();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : workOrders.isEmpty
                ? Stack(
                    children: [
                      Center(child: Text('No Work Orders')),
                      syncButtonDisabled(),
                    ],
                  )
                : Stack(
                    children: [
                      buildWorkOrder(),
                      syncButton(),
                    ],
                  ),
      ),
    );
  }

  Widget buildWorkOrder() {
    return ListView.builder(
        itemCount: workOrders.length,
        itemBuilder: (context, index) {
          final workOrder = workOrders[index];
          print(workOrders.length);

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditWorkOrder(
                    workOrder: workOrder,
                  ),
                ),
              );
            },
            child: Card(
              child: ListTile(
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        workOrder.invItemNumber == ''
                            ? '<No Item Number>'
                            : workOrder.invItemNumber.substring(3),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        workOrder.failureDesc,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            workOrder.contactName == ''
                                ? '<No Name>'
                                : workOrder.contactName,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Req Date: ${workOrder.reqFinishDate}',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                            workOrder.prefix == '' && workOrder.phone == ''
                                ? '<No Phone Number>'
                                : workOrder.prefix + workOrder.phone,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            workOrder.notes == ''
                                ? '<No Notes>'
                                : workOrder.notes,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget syncButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50.0,
        child: Material(
          color: Colors.blueAccent,
          child: InkWell(
            onTap: () async {
              BotToast.showLoading();
              for (int index = 0; index < workOrders.length; index++) {
                final wo = workOrders[index];
                _addWorkOrderBloc.add(FetchWorkOrderAdd(
                    int.parse(wo.customerNumber),
                    wo.contactName,
                    wo.prefix,
                    wo.phone,
                    wo.equipNumber,
                    wo.invItemNumber,
                    wo.failureDesc,
                    wo.reqFinishDate,
                    wo.reqFinishTime,
                    wo.notes));
                // await WorkOrderDatabase.instance.delete(wo.columnId);
                // setState(() {
                //   refreshWorkOrders();
                // });
              }
              await WorkOrderDatabase.instance.deleteAll();
              setState(() {
                refreshWorkOrders();
              });
              BotToast.closeAllLoading();
            },
            child: Center(
              child: Text(
                "Sync",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: "Product-Sans",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget syncButtonDisabled() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50.0,
        child: Material(
          color: Colors.grey,
          child: InkWell(
            onTap: () {},
            child: Center(
              child: Text(
                "Sync",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontFamily: "Product-Sans",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: Transform.translate(
        offset: Offset(-10, 0),
        child: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Get.off(() => HomePage());
          },
        ),
      ),
      titleSpacing: -20,
      title: Text(
        'List Work Order (Offline)',
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Product-Sans",
          fontSize: SizeConstant.textContentMedium,
        ),
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: ColorCustom.blueGradient1),
        ),
      ),
    );
  }
}
