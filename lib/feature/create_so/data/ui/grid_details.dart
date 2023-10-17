import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/formatCurrency.dart';
import 'package:royal_mobile_pos/feature/create_so/bloc/create_so_bloc.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/repository/create_so_repository.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/create_so_header.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GridDetails extends StatefulWidget {
  @override
  State<GridDetails> createState() => _GridDetailsState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('MM/dd/yyyy').format(now);

class FreeGoodsDataTableSource extends DataTableSource {
  final List<ArdF56CpfreRowset> data;

  FreeGoodsDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.cam2NdItemNumber1.toString())),
      DataCell(Text(rowData.transQty.toString() + ' ' + rowData.um)),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class PriceHistoryDataTableSource extends DataTableSource {
  final List<RudGetpriceP4074Fr1Rowset> data;

  PriceHistoryDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.descAdjName.toString())),
      DataCell(Text(rowData.factorValueNumeric.toString())),
      DataCell(Text(formatCurrency(rowData.unitPrice))),
      DataCell(Text(rowData.bC)),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _GridDetailsState extends State<GridDetails> {
  final globalKey = GlobalKey<ScaffoldState>();
  CreateSoBloc _createSoBloc =
      CreateSoBloc(createSoRepository: CreateSoRepositoryImpl());
  String _branchPlant, _customer, _customerPo, _itemNumber, _qtyOrdered;
  List<GridIn11> detailDatas = [];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then(
      (prefVal) => {
        setState(
          () {
            _branchPlant = prefVal.getString(SharedPref.branchPlant) ?? false;
            _customer = prefVal.getString(SharedPref.customer) ?? false;
            _customerPo = prefVal.getString(SharedPref.customerPo) ?? false;
            _itemNumber = prefVal.getString(SharedPref.itemN) ?? false;
            _qtyOrdered = prefVal.getString(SharedPref.quantity) ?? false;

            print(
                '$_branchPlant, $_customer, $_customerPo, $_itemNumber, $_qtyOrdered');
            detailDatas.add(
              GridIn11(
                businessUnit: _branchPlant,
                orderCo: "18000",
                orTy: "S1",
                lineNumber: "1",
                customerNumber: "100175",
                the2NdItemNumber: "KML000670011197S200120",
                transQty: "1",
                um: "PC",
                dateUpdated: formattedDate,
              ),
            );
            print('detailDatas: $detailDatas');
            _createSoBloc
                .add(GetFreeGoodsPriceHistoryEvent(gridData: detailDatas));
          },
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: BlocProvider<CreateSoBloc>(
          create: (context) => CreateSoBloc(
            createSoRepository: CreateSoRepositoryImpl(),
          ),
          child: BlocListener<CreateSoBloc, CreateSoState>(
            bloc: _createSoBloc,
            listener: (BuildContext context, CreateSoState state) {
              if (state is SuccessEntry) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Success Entry'),
                    backgroundColor: Colors.green,
                  ),
                );
                Future.delayed(Duration(seconds: 1), () {
                  Get.off(() => CreateSoHeader());
                });
              }
            },
            child: BlocBuilder(
              bloc: _createSoBloc,
              builder: (context, state) {
                if (state is CreateSoInitial) {
                  BotToast.showLoading();
                  return Container();
                } else if (state is FreeGoodsPriceHistoryLoaded) {
                  BotToast.closeAllLoading();
                  return _buildWidgetData(state.data);
                } else {
                  BotToast.closeAllLoading();
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

  Widget _buildWidgetData(FreeGoodsGetPriceResponse data) {
    final ardF56CpfreRowset = data.ardF56Cpfre.rowset;
    final rudGetpriceP4074Fr1Rowset = data.rudGetpriceP4074Fr1.rowset;

    int total = rudGetpriceP4074Fr1Rowset.fold(
        0, (previousValue, element) => previousValue + element.unitPrice);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Price History',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'Free Goods',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          automaticallyImplyLeading: false,
          leading: Transform.translate(
            offset: Offset(-10, 0),
            child: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          titleSpacing: -20,
          title: Text(
            'Grid Details',
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
        ),
        body: TabBarView(
          children: [
            Center(
              child: Column(
                children: [
                  Expanded(
                    flex: 12,
                    child: SingleChildScrollView(
                      child: PaginatedDataTable(
                        header: Text('SO Price History'),
                        columns: [
                          DataColumn(label: Text('Desc\nAdj Name')),
                          DataColumn(label: Text('Factor Value\nNumeric')),
                          DataColumn(label: Text('Unit Price')),
                          DataColumn(label: Text('BC')),
                        ],
                        source: PriceHistoryDataTableSource(
                            data: rudGetpriceP4074Fr1Rowset),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Text(
                                'Amount - Price per Unit:',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            formatCurrency(total),
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: PaginatedDataTable(
                  header: Text('Free Goods'),
                  columns: [
                    DataColumn(label: Text('Free Goods')),
                    DataColumn(label: Text('Quantity')),
                  ],
                  source: FreeGoodsDataTableSource(data: ardF56CpfreRowset),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
