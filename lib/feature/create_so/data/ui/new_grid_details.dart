import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/formatCurrency.dart';
import 'package:royal_mobile_pos/feature/create_so/bloc/create_so_bloc.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_new_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/repository/create_so_repository.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';

class NewGridDetails extends StatefulWidget {
  final String priceHistory;
  final String appBar;

  NewGridDetails(this.priceHistory, this.appBar);

  @override
  State<NewGridDetails> createState() => _NewGridDetailsState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('MM/dd/yyyy').format(now);

class FreeGoodsDataTableSource extends DataTableSource {
  final List<FluffyRowset> data;

  FreeGoodsDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.f56CpfreCa1Litm.toString())),
      DataCell(
          Text(rowData.f56CpfreTrqt.toString() + ' ' + rowData.f56CpfreUom)),
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
  final List<StickyRowset> data;

  PriceHistoryDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.zDl01108.toString())),
      DataCell(Text(rowData.zFvtr93.toString())),
      DataCell(Text(formatCurrency(rowData.zUprc95))),
      DataCell(Text(rowData.zBscd97)),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _NewGridDetailsState extends State<NewGridDetails> {
  final globalKey = GlobalKey<ScaffoldState>();
  CreateSoBloc _createSoBloc =
      CreateSoBloc(createSoRepository: CreateSoRepositoryImpl());
  String _branchPlant, _customer, _customerPo, _itemNumber, _qtyOrdered;
  List<GridIn11> detailDatas = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = json.decode(widget.priceHistory);
    final fggp = FreeGoodsGetPriceResponseNew.fromJson(data);
    int total = fggp.serviceRequest6.fsP4074W4074D.data.gridData.rowset
        .fold(0, (previousValue, element) => previousValue + element.zUprc95);
    final ardF56CpfreRowset =
        fggp.serviceRequest4.fsDatabrowseF56Cpfre.data.gridData.rowset;
    final rudGetpriceP4074Fr1Rowset =
        fggp.serviceRequest6.fsP4074W4074D.data.gridData.rowset;
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
            widget.appBar,
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
