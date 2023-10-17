import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/customer/ui/add_customer.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:royal_mobile_pos/feature/customer/bloc/customer_bloc.dart';
import 'package:royal_mobile_pos/feature/customer/data/model/get_customer_response.dart';
import 'package:royal_mobile_pos/feature/customer/data/repository/customer_repository.dart';

class CustomerList extends StatefulWidget {
  @override
  State<CustomerList> createState() => _CustomerListState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('MM/dd/yyyy').format(now);

class CustomerListDataTableSource extends DataTableSource {
  final List<GetCustomerResponse> data;

  CustomerListDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.nama.toString())),
      DataCell(Text(rowData.alamat.toString())),
      DataCell(Text(rowData.noHp.toString())),
      DataCell(Text(rowData.idNumber.toString())),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _CustomerListState extends State<CustomerList> {
  final globalKey = GlobalKey<ScaffoldState>();
  GetCustomerBloc _getCustomerBloc =
      GetCustomerBloc(getCustomerRepository: GetCustomerRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _getCustomerBloc.add(GetCustomerEntry());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: BlocProvider<GetCustomerBloc>(
          create: (context) => GetCustomerBloc(
            getCustomerRepository: GetCustomerRepositoryImpl(),
          ),
          child: BlocListener<GetCustomerBloc, GetCustomerState>(
            bloc: _getCustomerBloc,
            listener: (BuildContext context, GetCustomerState state) {},
            child: BlocBuilder(
              bloc: _getCustomerBloc,
              builder: (context, state) {
                if (state is GetCustomerInitial) {
                  BotToast.showLoading();
                  return Container();
                } else if (state is CustomerLoaded) {
                  BotToast.closeAllLoading();
                  return _buildWidgetDetail(state.articles);
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

  Widget _buildWidgetDetail(List<GetCustomerResponse> data) {
    final getCustomerResponse = data;
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
                Get.to(() => HomePage());
              },
            ),
          ),
          titleSpacing: -20,
          title: Text(
            'Customer List',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Product-Sans",
              fontSize: SizeConstant.textContentMedium,
            ),
          ),
          actions: [
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Get.to(() => AddCustomer());
              },
              child: Text("Add Customer"),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ],
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
                flex: 2,
                child: SingleChildScrollView(
                  child: PaginatedDataTable(
                    header: Text('SO Details'),
                    columns: [
                      DataColumn(label: Text('Customer ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Branch Plant')),
                      DataColumn(label: Text('Shop ID')),
                    ],
                    source: CustomerListDataTableSource(data: getCustomerResponse),
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
