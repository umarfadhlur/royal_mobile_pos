import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/feature/create_so/bloc/create_so_bloc.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/get_so_history.dart';
import 'package:royal_mobile_pos/feature/create_so/data/repository/create_so_repository.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/create_so_header.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/create_so/data/ui/so_details.dart';

class SoHistory extends StatefulWidget {
  @override
  State<SoHistory> createState() => _SoHistoryState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

class SoHistoryDataTableSource extends DataTableSource {
  final List<GetSoHistory> data;

  SoHistoryDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(
      cells: [
        DataCell(Text(rowData.doco.toString())),
        DataCell(Text(rowData.vr01.toString())),
        DataCell(Text(DateFormat('yyyy-MM-dd').format(rowData.soDate))),
        DataCell(Text(rowData.mcu.toString())),
        rowData.doco != ""
            ? DataCell(
                Text(
                  'Created',
                  style: TextStyle(color: Colors.green),
                ),
              )
            : DataCell(
                Text(
                  'Drafted',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
        DataCell(
          InkWell(
            onTap: () {
              Get.to(() => SoDetails(
                    int.parse(rowData.id),
                    rowData.doco.toString(),
                    rowData.mcu.toString(),
                    rowData.an8.toString(),
                    rowData.vr01.toString(),
                  ));
            },
            child: Text(
              'Details',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _SoHistoryState extends State<SoHistory> {
  final globalKey = GlobalKey<ScaffoldState>();
  CreateSoBloc _createSoBloc =
      CreateSoBloc(createSoRepository: CreateSoRepositoryImpl());
  List<GridIn11> detailDatas = [];

  @override
  void initState() {
    super.initState();
    _createSoBloc.add(GetSoHistoryLoadEvent());
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
                } else if (state is SoHistoryLoaded) {
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

  Widget _buildWidgetData(List<GetSoHistory> data) {
    return Scaffold(
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
          'SO History',
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
        child: SingleChildScrollView(
          child: PaginatedDataTable(
            header: Text('SO History'),
            columns: [
              DataColumn(label: Text('Document Number')),
              DataColumn(label: Text('Customer PO')),
              DataColumn(label: Text('SO Date')),
              DataColumn(label: Text('Branch / Plant')),
              DataColumn(label: Text('Status')),
              DataColumn(label: Text('Details')),
            ],
            source: SoHistoryDataTableSource(data: data),
          ),
        ),
      ),
    );
  }
}
