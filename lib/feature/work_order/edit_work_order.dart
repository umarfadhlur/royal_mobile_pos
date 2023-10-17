import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/color.dart';
import 'package:royal_mobile_pos/core/constant/size_text.dart';
import 'package:royal_mobile_pos/core/constant/utils.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/feature/offline_wo/ui/work_order_list_offline.dart';
import 'package:royal_mobile_pos/feature/offline_wo/utils/local_database/database.dart';
import 'package:royal_mobile_pos/feature/offline_wo/utils/local_database/table_createwo.dart';
import 'package:royal_mobile_pos/feature/work_order/data/cubit/work_order_bloc.dart';
import 'package:royal_mobile_pos/feature/work_order/data/repository/repository_add_work_order.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'data/model/work_order_response_model.dart';

class EditWorkOrder extends StatefulWidget {
  final WorkOrder workOrder;

  const EditWorkOrder({Key key, this.workOrder}) : super(key: key);

  @override
  _EditWorkOrderState createState() => _EditWorkOrderState();
}

class _EditWorkOrderState extends State<EditWorkOrder> {
  String customerNumber;
  String contactName;
  String prefix;
  String phone;
  String equipNumber;
  String invItemNumber;
  String failureDesc;
  String reqFinishDate;
  String reqFinishTime;
  String notes;
  String woNumber;
  final globalKey = GlobalKey<ScaffoldState>();
  bool readOnly = false;

  DateTime now = DateTime.now();

  String barcode = "";

  TextEditingController _customerNumber = TextEditingController();
  TextEditingController _contactName = TextEditingController();
  TextEditingController _prefix = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _equipmentNumber = TextEditingController();
  TextEditingController _invItemNumber = TextEditingController();
  TextEditingController _failureDesc = TextEditingController();
  TextEditingController _reqFinishDate = TextEditingController();
  TextEditingController _reqFinishTime = TextEditingController();
  TextEditingController _notes = TextEditingController();
  TextEditingController _woNumber = TextEditingController();

  FocusNode _fnCustomer = FocusNode();

  WorkOrderBloc _addWorkOrderBloc =
      WorkOrderBloc(addWorkOrderRepository: AddWorkOrderRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _customerNumber.text = widget.workOrder.customerNumber ?? false;
    _contactName.text = widget.workOrder.contactName ?? false;
    _prefix.text = widget.workOrder.prefix ?? false;
    _phone.text = widget.workOrder.phone ?? false;
    _equipmentNumber.text = widget.workOrder.equipNumber ?? false;
    _invItemNumber.text = widget.workOrder.invItemNumber ?? false;
    _failureDesc.text = widget.workOrder.failureDesc ?? false;
    _reqFinishDate.text = widget.workOrder.reqFinishDate ?? false;
    _reqFinishTime.text = widget.workOrder.reqFinishTime ?? false;
    _notes.text = widget.workOrder.notes ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: _appBar(),
      body: BlocProvider(
        create: (_) => _addWorkOrderBloc,
        child: BlocListener<WorkOrderBloc, WorkOrderState>(
          listener: (context, state) {
            if (state is AddError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                ),
              );
            } else if (state is WorkOrderLoaded) {
              BotToast.closeAllLoading();
            }
          },
          child: BlocBuilder(
            bloc: _addWorkOrderBloc,
            builder: (context, state) {
              if (state is AddWorkOrderInitial) {
                return _stackInitial();
              } else if (state is WorkOrderLoaded) {
                return _stack(state.model);
              } else {
                return _stackInitial();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _stack(WorkOrderResponseModel model) {
    _woNumber.text = model.woCreated.toString();
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "(*) Required",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(right: _size.width * 0.035),
                        child: Container(
                          width: _size.width * 0.45,
                          height: _size.height * 0.06,
                          child: TextFormField(
                            onTap: () {},
                            controller: _customerNumber,
                            onEditingComplete: () {
                              _addWorkOrderBloc
                                  .add(FindCustomer(_customerNumber.text));
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Customer Number *",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          focusNode: _fnCustomer,
                          onTap: () {},
                          controller: _customerNumber,
                          onEditingComplete: () {
                            _addWorkOrderBloc
                                .add(FindCustomer(_customerNumber.text));
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Contact Name",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _contactName,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _prefix,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _phone,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Equipment Number",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: _size.width * 0.45,
                      height: _size.height * 0.06,
                      child: TextFormField(
                        onTap: () {},
                        onEditingComplete: () {
                          _addWorkOrderBloc
                              .add(FindEquipment(_equipmentNumber.text));
                        },
                        controller: _equipmentNumber,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: IconButton(
                          icon: new Icon(
                            Icons.qr_code,
                            color: Colors.blue,
                            size: 35,
                          ),
                          onPressed: barcodeScanning,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Inv. Item Number",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {
                            _addWorkOrderBloc
                                .add(FindItem(_invItemNumber.text));
                          },
                          controller: _invItemNumber,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Failure Description *",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _failureDesc,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Requested Finish Date",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new DateFormatter()
                          ],
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _reqFinishDate,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'dd/mm/yy',
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new TimeFormatter()
                          ],
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _reqFinishTime,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'hh:mm:ss',
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Notes",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: Container(
                          height: 120,
                          child: TextFormField(
                            maxLines: 5,
                            onTap: () {},
                            onEditingComplete: () {},
                            controller: _notes,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "WO Created",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: _size.width * 0.035, top: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: model.woCreated == null
                            ? Text('')
                            : Text(
                                _woNumber.text,
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  child: Material(
                    color: Colors.blueAccent,
                    child: InkWell(
                      onTap: () async {
                        final note = widget.workOrder.copy(
                          customerNumber: _customerNumber.text,
                          contactName: _contactName.text,
                          prefix: _prefix.text,
                          phone: _phone.text,
                          equipNumber: _equipmentNumber.text,
                          invItemNumber: _invItemNumber.text,
                          failureDesc: _failureDesc.text,
                          reqFinishDate: _reqFinishDate.text,
                          reqFinishTime: _reqFinishTime.text,
                          notes: _notes.text,
                          woNumber: _woNumber.text,
                        );

                        print(_woNumber.text);
                        await WorkOrderDatabase.instance.update(note);
                        if (_woNumber.text != '') {
                          delete();
                        }
                        Get.off(() => WorkOrderListOffline());
                      },
                      child: Center(
                        child: Text(
                          "Back",
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
                Container(
                  height: 50,
                  width: 100,
                  child: Material(
                    color: Colors.grey,
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: Text(
                          "Update",
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
                Container(
                  height: 50,
                  width: 100,
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _stackInitial() {
    Size _size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "(*) Required",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(right: _size.width * 0.035),
                        child: Container(
                          width: _size.width * 0.45,
                          height: _size.height * 0.06,
                          child: TextFormField(
                            onTap: () {},
                            controller: _customerNumber,
                            onEditingComplete: () {
                              _addWorkOrderBloc
                                  .add(FindCustomer(_customerNumber.text));
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Customer Number *",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          focusNode: _fnCustomer,
                          onTap: () {},
                          onEditingComplete: () {
                            _addWorkOrderBloc
                                .add(FindCustomer(_customerNumber.text));
                          },
                          controller: _customerNumber,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Contact Name",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _contactName,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _prefix,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _phone,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Equipment Number",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: _size.width * 0.45,
                      height: _size.height * 0.06,
                      child: TextFormField(
                        onTap: () {},
                        onEditingComplete: () {
                          _addWorkOrderBloc
                              .add(FindEquipment(_equipmentNumber.text));
                        },
                        controller: _equipmentNumber,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: IconButton(
                          icon: new Icon(
                            Icons.qr_code,
                            color: Colors.blue,
                            size: 35,
                          ),
                          onPressed: barcodeScanning,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Inv. Item Number",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {
                            _addWorkOrderBloc
                                .add(FindItem(_invItemNumber.text));
                          },
                          controller: _invItemNumber,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Failure Description *",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _failureDesc,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Requested Finish Date",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new DateFormatter()
                          ],
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _reqFinishDate,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'dd/mm/yy',
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            new TimeFormatter()
                          ],
                          onTap: () {},
                          onEditingComplete: () {},
                          controller: _reqFinishTime,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'hh:mm:ss',
                            isDense: true,
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).primaryColor,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "Notes",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: Container(
                          height: 120,
                          child: TextFormField(
                            maxLines: 5,
                            onTap: () {},
                            onEditingComplete: () {},
                            controller: _notes,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(8),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _size.width * 0.035),
                      child: Text(
                        "WO Created",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: _size.width * 0.035, top: _size.width * 0.035),
                      child: Container(
                        width: _size.width * 0.45,
                        height: _size.height * 0.06,
                        child: Text(''),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                  width: 100,
                  child: Material(
                    color: Colors.blueAccent,
                    child: InkWell(
                      onTap: () {
                        Get.off(() => WorkOrderListOffline());
                      },
                      child: Center(
                        child: Text(
                          "Cancel",
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
                Container(
                  height: 50,
                  width: 100,
                  child: Material(
                    color: Colors.blueAccent,
                    child: InkWell(
                      onTap: () {
                        updateRecord();
                        final snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Data Updated'),
                        );
                        globalKey.currentState.showSnackBar(snackBar);
                      },
                      child: Center(
                        child: Text(
                          "Update",
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
                Container(
                  height: 50,
                  width: 100,
                  child: Material(
                    color: Colors.blueAccent,
                    child: InkWell(
                      onTap: () {
                        BotToast.showLoading();
                        if ((_customerNumber.text == null &&
                                _failureDesc.text == null) ||
                            _customerNumber.text == "" &&
                                _failureDesc.text == "") {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'Customer Number and Failure Description Cannot Be Blank'),
                          );
                          globalKey.currentState.showSnackBar(snackBar);
                        } else if ((_customerNumber.text == null &&
                                _failureDesc.text == null) ||
                            _customerNumber.text == "" &&
                                _failureDesc.text == "") {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(
                                'Customer Number and Failure Description Cannot Be Blank'),
                          );
                          globalKey.currentState.showSnackBar(snackBar);
                        } else if (_customerNumber.text == null ||
                            _customerNumber.text == "") {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Customer Number Cannot Be Blank'),
                          );
                          globalKey.currentState.showSnackBar(snackBar);
                        } else if (_failureDesc.text == null ||
                            _failureDesc.text == "") {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content:
                                Text('Failure Description Cannot Be Blank'),
                          );
                          globalKey.currentState.showSnackBar(snackBar);
                        } else {
                          _addWorkOrderBloc.add(FetchWorkOrderAdd(
                              int.parse(_customerNumber.text),
                              _contactName.text,
                              _prefix.text,
                              _phone.text,
                              _equipmentNumber.text,
                              _invItemNumber.text,
                              _failureDesc.text,
                              _reqFinishDate.text,
                              _reqFinishTime.text,
                              _notes.text));
                        }
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
              ],
            ),
          ),
        ),
      ],
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
            if (_woNumber.text != '') {
              delete();
            }
            Get.off(() => WorkOrderListOffline());
          },
        ),
      ),
      titleSpacing: -20,
      title: Text(
        'Edit Work Order',
        // widget.workOrder.woNumber,
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

  Future barcodeScanning() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._equipmentNumber.text = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nothing captured.');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  Future updateRecord() async {
    final note = widget.workOrder.copy(
      customerNumber: _customerNumber.text,
      contactName: _contactName.text,
      prefix: _prefix.text,
      phone: _phone.text,
      equipNumber: _equipmentNumber.text,
      invItemNumber: _invItemNumber.text,
      failureDesc: _failureDesc.text,
      reqFinishDate: _reqFinishDate.text,
      reqFinishTime: _reqFinishTime.text,
      notes: _notes.text,
      woNumber: _woNumber.text,
    );

    await WorkOrderDatabase.instance.update(note);
  }

  Future delete() async {
    await WorkOrderDatabase.instance.delete(widget.workOrder.columnId);
  }
}
