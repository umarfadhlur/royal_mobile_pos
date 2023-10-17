import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/equipment_master/bloc/equipment_master_bloc.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/model/equip_master_response.dart';
import 'package:royal_mobile_pos/feature/equipment_master/data/repository/equip_master_repository.dart';
import 'package:royal_mobile_pos/feature/equipment_master/ui/equip_master_detail.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EquipMasterList extends StatefulWidget {
  @override
  _EquipMasterListState createState() => _EquipMasterListState();
}

class _EquipMasterListState extends State<EquipMasterList> {
  DateTime dt = DateTime.parse('20211213');

  EquipMasterBloc _equipMasterBloc =
      EquipMasterBloc(equipMasterRepository: EquipMasterRepositoryImpl());
  TextEditingController controllerSearch = new TextEditingController();
  TextEditingController _description = new TextEditingController();
  TextEditingController _unitNumber = new TextEditingController();
  String _token;

  @override
  void initState() {
    BotToast.closeAllLoading();
    _description.text = '*';
    _unitNumber.text = '*';
    _equipMasterBloc.add(FilterListSelectEvent(
        descriptionF1201: _description.text,
        unitNumberF1201: _unitNumber.text));
    SharedPreferences.getInstance().then((prefVal) => {
          setState(() {
            _token = prefVal.getString(SharedPref.token) ?? false;
            //_companyBloc.add(FetchArticleEvent(token: _token, name: null));
          })
        });
    super.initState();
  }

  void onSearch(String description) {
    print("on search: ${description}");
    if (description.isEmpty) {
      setState(() {
        //_companyBloc.add(SearchCompanySelectEvent(name: name));
        //_companyBloc.add(FetchArticleEvent(token: _token));
      });
      return;
    } else {
      _equipMasterBloc
          .add(SearchListSelectEvent(descriptionF1201: description));
      setState(() {
        //_companyBloc.add(SearchCompanySelectEvent(name: name));
      });
    }
  }

  void onSearchFiltered(String description) {
    print("on search: $_token");
    if (description.isEmpty) {
      setState(() {
        //_companyBloc.add(SearchCompanySelectEvent(name: name));
        //_companyBloc.add(FetchArticleEvent(token: _token));
      });
      return;
    } else {
      _equipMasterBloc.add(FilterListSelectEvent(
          descriptionF1201: _description.text,
          unitNumberF1201: _unitNumber.text));
      setState(() {
        //_companyBloc.add(SearchCompanySelectEvent(name: name));
      });
    }
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
                if (state is EquipMasterInitial) {
                  return buildLoading();
                } else if (state is ArticleLoadingState) {
                  return buildLoading();
                } else if (state is ArticleLoadedState) {
                  return buildArticleList(state.articles);
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

  Widget buildArticleList(List<EMList> articles) {
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
                          'Bengalon Coal Project',
                          style: TextStyle(
                            fontSize: 14.0,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          articles[item].eqStF1201 == 'AV'
                              ? 'Available'
                              : articles[item].eqStF1201 == 'SB'
                                  ? 'Stand By'
                                  : 'Down on Site',
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
                  'assetNumber', articles[item].assetNumberF1201);
              print(prefs.getString('assetNumber'));
              // Get.to(() => EquipmentNumberDetail());
              Get.to(() => EquipMasterDetail());
            },
          ),
        );
      },
    );
  }

  Widget _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          tooltip: 'Open shopping cart',
          onPressed: () {
            _displayTextInputDialog(context);
          },
        ),
      ],
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
        'Equipment Master Inquiry',
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

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Search'),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Description',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        onTap: () {
                          _description.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: _description.value.text.length);
                        },
                        controller: _description,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Unit Number',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        onTap: () {
                          _unitNumber.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: _unitNumber.value.text.length);
                        },
                        controller: _unitNumber,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Reset'),
              onPressed: () {
                _description.text = '*';
                _unitNumber.text = '*';
              },
            ),
            FlatButton(
              color: Colors.blueAccent,
              textColor: Colors.white,
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  _equipMasterBloc.add(FilterListSelectEvent(
                      descriptionF1201: _description.text + '%',
                      unitNumberF1201: _unitNumber.text + '%'));
                  Navigator.pop(context);
                });
              },
            ),
          ],
        );
      },
    );
  }
}
