import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:royal_mobile_pos/feature/user/bloc/user_bloc.dart';
import 'package:royal_mobile_pos/feature/user/data/model/get_user_response.dart';
import 'package:royal_mobile_pos/feature/user/data/repository/user_repository.dart';
import 'package:royal_mobile_pos/feature/user/ui/add_user.dart';

class UserList extends StatefulWidget {
  @override
  State<UserList> createState() => _UserListState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('MM/dd/yyyy').format(now);

class UserListDataTableSource extends DataTableSource {
  final List<GetUserResponse> data;

  UserListDataTableSource({this.data});

  @override
  DataRow getRow(int index) {
    final rowData = data[index];
    return DataRow(cells: [
      DataCell(Text(rowData.userId.toString())),
      DataCell(Text(rowData.name.toString())),
      DataCell(Text(rowData.branchPlant.toString())),
      DataCell(Text(rowData.shopId.toString())),
      DataCell(Text(rowData.shopId.toString())),
    ]);
  }

  @override
  int get rowCount => data.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class _UserListState extends State<UserList> {
  final globalKey = GlobalKey<ScaffoldState>();
  GetUserBloc _getUserBloc =
      GetUserBloc(getUserRepository: GetUserRepositoryImpl());

  @override
  void initState() {
    super.initState();
    _getUserBloc.add(GetUserEntry());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: BlocProvider<GetUserBloc>(
          create: (context) => GetUserBloc(
            getUserRepository: GetUserRepositoryImpl(),
          ),
          child: BlocListener<GetUserBloc, GetUserState>(
            bloc: _getUserBloc,
            listener: (BuildContext context, GetUserState state) {},
            child: BlocBuilder(
              bloc: _getUserBloc,
              builder: (context, state) {
                if (state is GetUserInitial) {
                  BotToast.showLoading();
                  return Container();
                } else if (state is UserLoaded) {
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

  Widget _buildWidgetDetail(List<GetUserResponse> data) {
    final getUserResponse = data;
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
            'User List',
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
                Get.to(() => AddUser());
              },
              child: Text("Add User"),
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
                      DataColumn(label: Text('User ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Branch Plant')),
                      DataColumn(label: Text('Shop ID')),
                      DataColumn(label: Text('Details')),
                    ],
                    source: UserListDataTableSource(data: getUserResponse),
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
