import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/formatCurrency.dart';
import 'package:royal_mobile_pos/feature/create_so/bloc/create_so_bloc.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/get_so_detail.dart';
import 'package:royal_mobile_pos/feature/create_so/data/repository/create_so_repository.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/create_so_header.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/new_grid_details.dart';

class SoDetails extends StatefulWidget {
  final int details;
  final String soNumber;
  final String bp;
  final String customer;
  final String customerPo;

  SoDetails(
      this.details, this.soNumber, this.bp, this.customer, this.customerPo);

  @override
  State<SoDetails> createState() => _SoDetailsState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('MM/dd/yyyy').format(now);

class SoDetailsDataTableSource extends DataTableSource {
  final List<GetSoDetail> data;

  SoDetailsDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.litm.toString())),
      DataCell(Text(rowData.qty.toString())),
      DataCell(Text(formatCurrency(int.parse(rowData.uprc)))),
      DataCell(Text(formatCurrency(int.parse(rowData.uprc) * rowData.qty))),
      DataCell(
        InkWell(
          onTap: () {
            Get.to(() => NewGridDetails(rowData.priceHistory, 'SO Details'));
          },
          child: Text(
            'Details',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _SoDetailsState extends State<SoDetails> {
  final globalKey = GlobalKey<ScaffoldState>();
  CreateSoBloc _createSoBloc =
      CreateSoBloc(createSoRepository: CreateSoRepositoryImpl());
  List<GridIn11> detailDatas = [];

  final _soController = TextEditingController();
  final _bpController = TextEditingController();
  final _custController = TextEditingController();
  final _custPoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _createSoBloc.add(FetchSoDetailEvent(soHeaderId: widget.details));
    _soController.text = widget.soNumber;
    _bpController.text = widget.bp;
    _custController.text = widget.customer;
    _custPoController.text = widget.customerPo;
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
                } else if (state is SoDetailLoaded) {
                  BotToast.closeAllLoading();
                  return _buildWidgetDetail(state.detail);
                } else {
                  BotToast.closeAllLoading();
                  print(state);
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

  Widget _buildWidgetDetail(List<GetSoDetail> data) {
    final getSoDetail = data;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
            'SO Details',
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
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        title: Text(
                          'SO Number',
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                        ),
                        subtitle: TextField(
                          controller: _soController,
                          enabled: false,
                          style: TextStyle(fontFamily: 'Montserrat'),
                          decoration: InputDecoration(
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        title: Text(
                          'Branch / Plant',
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                        ),
                        subtitle: TextField(
                          controller: _bpController,
                          enabled: false,
                          style: TextStyle(fontFamily: 'Montserrat'),
                          decoration: InputDecoration(
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        title: Text(
                          'Customer',
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                        ),
                        subtitle: TextField(
                          controller: _custController,
                          enabled: false,
                          style: TextStyle(fontFamily: 'Montserrat'),
                          decoration: InputDecoration(
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        title: Text(
                          'Customer PO',
                          style:
                              TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                        ),
                        subtitle: TextField(
                          controller: _custPoController,
                          enabled: false,
                          style: TextStyle(fontFamily: 'Montserrat'),
                          decoration: InputDecoration(
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: PaginatedDataTable(
                    header: Text('SO Details'),
                    columns: [
                      DataColumn(label: Text('Item Number')),
                      DataColumn(label: Text('Quantity')),
                      DataColumn(label: Text('Unit Price')),
                      DataColumn(label: Text('Extended Price')),
                      DataColumn(label: Text('Details')),
                    ],
                    source: SoDetailsDataTableSource(data: getSoDetail),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
