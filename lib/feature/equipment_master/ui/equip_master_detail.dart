import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/feature/equipment_master/bloc/equipment_master_bloc.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/model/equip_master_detail_response.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/repository/equip_master_repository.dart';
import 'package:royal_mobile_pos/feature/equipment_number/ui/page/equipment_number_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EquipMasterDetail extends StatefulWidget {
  @override
  _EquipMasterDetailState createState() => _EquipMasterDetailState();
}

class _EquipMasterDetailState extends State<EquipMasterDetail> {
  EquipMasterBloc _equipMasterBloc =
      EquipMasterBloc(equipMasterRepository: EquipMasterRepositoryImpl());
  final _equipmentNumberController = TextEditingController();

  Future<String> equipmentNumber() async {
    final prefs = await SharedPreferences.getInstance();
    String equipNumber = prefs.getString('assetNumber');
    _equipmentNumberController.text = equipNumber;
    return equipNumber;
  }

  delaySubmit() async {
    Future.delayed(Duration(milliseconds: 100), () {
      _onEquipmentSubmitted(context);
    });
  }

  _onEquipmentSubmitted(BuildContext context) {
    print("submit equip : ${_equipmentNumberController.text}");
    _equipMasterBloc
        .add(FindEquipment(assetNumberF1217: _equipmentNumberController.text));
    //BlocProvider.of<EquipmentNumberBloc>(context).processPickingActualCompleted();
  }

  @override
  void initState() {
    super.initState();
    equipmentNumber();
    // _equipmentNumberController.text = equipNumber;
    delaySubmit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: Container(
        child: BlocProvider<EquipMasterBloc>(
          create: (context) => EquipMasterBloc(
            equipMasterRepository: EquipMasterRepositoryImpl(),
          ),
          child: BlocListener<EquipMasterBloc, EquipMasterState>(
            listener: (BuildContext context, EquipMasterState state) {
              if (state is ArticleErrorState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
              if (state is CompanySelectState) {
                BotToast.showLoading();
              }
              return Container();
            },
            child: BlocBuilder(
              bloc: _equipMasterBloc,
              builder: (context, state) {
                if (state is EquipMasterDetailInitial) {
                  return buildLoading();
                } else if (state is ArticleLoadingState) {
                  return buildLoading();
                } else if (state is DetailLoadedState) {
                  return Stack(
                    children: [
                      buildDetail(state.articles),
                      geoLocation(),
                    ],
                  );
                } else if (state is ArticleErrorState) {
                  return buildErrorUi(state.message);
                } else {
                  return buildLoading();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDetail(List<DetailList> articles) {
    BotToast.closeAllLoading();
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Unit Number'),
                      initialValue: articles[item]
                                  .unitNumberF1201
                                  .replaceAll(RegExp('\\s+'), '') ==
                              ''
                          ? '<No Item Number>'
                          : articles[item]
                              .unitNumberF1201
                              .replaceAll(RegExp('\\s+'), ''),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Description'),
                      initialValue: articles[item].descriptionF1201,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Serial Number'),
                      initialValue: articles[item].serialNumberF1201,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Equipment #'),
                      initialValue: articles[item].assetNumberF1217,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Sites'),
                      initialValue: articles[item].lessorAddressF1201,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: ''),
                      initialValue: 'Bengalon Coal Project',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Parent Number'),
                      initialValue: articles[item].parentNumberF1201,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Date Acquired'),
                      initialValue: articles[item].dateAcquiredF1201,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Installed Date'),
                      initialValue: articles[item].contractDateF1201,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration:
                          InputDecoration(labelText: 'Equipment Status'),
                      initialValue: articles[item].eqStF1201 == 'AV'
                          ? 'Available'
                          : articles[item].eqStF1201 == 'SB'
                              ? 'Stand By'
                              : 'Down on Site',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Allow Work Order'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Checkbox(
                      onChanged: (value) => true,
                      value: articles[item].wOF1201 == '1' ? true : false,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text('Meter Reading Required'),
                  ),
                  Expanded(
                    flex: 1,
                    child: Checkbox(
                      onChanged: (value) => true,
                      value: articles[item].meterSchedulesF1217 == '1'
                          ? true
                          : false,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: 'Location'),
                      initialValue: articles[item]
                          .locationF1201
                          .replaceAll(RegExp('\\s+'), ''),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      enabled: false,
                      decoration: InputDecoration(labelText: ''),
                      initialValue: 'Bengalon Coal Project',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildArticleList(List<DetailList> articles) {
    BotToast.closeAllLoading();
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, item) {
        return Card(
          child: InkWell(
            child: ListTile(
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          articles[item]
                                      .unitNumberF1201
                                      .replaceAll(RegExp('\\s+'), '') ==
                                  ''
                              ? '<No Item Number>'
                              : articles[item]
                                  .unitNumberF1201
                                  .replaceAll(RegExp('\\s+'), ''),
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          articles[item].descriptionF1201,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          articles[item].lessorAddressF1201,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          articles[item].contractDateF1201 == "null"
                              ? '<No Contract Date>'
                              : articles[item].contractDateF1201.substring(6) +
                                  '/' +
                                  articles[item]
                                      .contractDateF1201
                                      .substring(4, 6) +
                                  '/' +
                                  articles[item]
                                      .contractDateF1201
                                      .substring(0, 4),
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          articles[item]
                              .locationF1201
                              .replaceAll(RegExp('\\s+'), ''),
                          style: TextStyle(
                            fontSize: 14.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          articles[item].eqStF1201,
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString(
                  'assetNumber', articles[item].assetNumberF1217);
              print(prefs.getString('assetNumber'));
            },
          ),
        );
      },
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(message, style: TextStyle(color: Colors.red))),
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
            Navigator.pop(context);
          },
        ),
      ),
      titleSpacing: -20,
      title: Text(
        'Equipment Master Detail',
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

  Widget geoLocation() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 50.0,
        child: Material(
          color: Colors.blueAccent,
          child: InkWell(
            onTap: () {
              Get.to(() => EquipmentNumberDetail());
            },
            child: Center(
              child: Text(
                "Geolocation",
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
}
