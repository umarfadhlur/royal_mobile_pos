import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:royal_mobile_pos/core/constant/constants.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/core/widget/item_search_filter.dart';
import 'package:royal_mobile_pos/feature/work_order_list/bloc/work_order_list_bloc.dart';
import 'package:royal_mobile_pos/feature/work_order_list/data/model/work_order_list_response.dart';
import 'package:royal_mobile_pos/feature/work_order_list/data/repository/work_order_list_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkOrderList extends StatefulWidget {
  @override
  _WorkOrderListState createState() => _WorkOrderListState();
}

class _WorkOrderListState extends State<WorkOrderList> {
  DateTime dt = DateTime.parse('20211213');

  int _radioValue = -1;

  WorkOrderListBloc _workOrderListBloc =
      WorkOrderListBloc(workOrderListRepository: WorkOrderListRepositoryImpl());
  TextEditingController controllerSearch = new TextEditingController();
  TextEditingController _customerNumber = new TextEditingController();
  TextEditingController _orderType = new TextEditingController();
  TextEditingController _requestDate = new TextEditingController();
  TextEditingController _assetNumber = new TextEditingController();
  TextEditingController _woStatus = new TextEditingController();
  TextEditingController _branch = new TextEditingController();
  String _token;
  String token;

  @override
  void initState() {
    BotToast.closeAllLoading();
    _workOrderListBloc.add(SearchListSelectEvent(orderNumber: null));
    _customerNumber.text = '*';
    _orderType.text = '*';
    _requestDate.text = '*';
    _assetNumber.text = '*';
    _woStatus.text = '*';
    _branch.text = '*';
    _workOrderListBloc.add(FilterListSelectEvent(
        orTy: _orderType.text,
        requestDate: _requestDate.text,
        assetNumber: _assetNumber.text,
        woStatus: _woStatus.text,
        branch: _branch.text));
    SharedPreferences.getInstance().then((prefVal) => {
          setState(() {
            _token = prefVal.getString(SharedPref.token) ?? false;
            //_companyBloc.add(FetchArticleEvent(token: _token, name: null));
          })
        });
    super.initState();
  }

  void onSearch(String orderNumber) {
    print("on search: ${orderNumber}");
    if (orderNumber.isEmpty) {
      setState(() {
        //_companyBloc.add(SearchCompanySelectEvent(name: name));
        //_companyBloc.add(FetchArticleEvent(token: _token));
      });
      return;
    } else {
      _workOrderListBloc
          .add(SearchListSelectEvent(orderNumber: int.parse(orderNumber)));
      setState(() {
        //_companyBloc.add(SearchCompanySelectEvent(name: name));
      });
    }
  }

  void onSearchFiltered(String orderNumber) {
    print("on search: ${orderNumber}");
    if (orderNumber.isEmpty) {
      setState(() {
        //_companyBloc.add(SearchCompanySelectEvent(name: name));
        //_companyBloc.add(FetchArticleEvent(token: _token));
      });
      return;
    } else {
      _workOrderListBloc.add(FilterListSelectEvent(
          orTy: _orderType.text,
          requestDate: _requestDate.text,
          assetNumber: _assetNumber.text,
          woStatus: _woStatus.text,
          branch: _branch.text,
          orderNumber: int.parse(orderNumber)));
      setState(() {
        //_companyBloc.add(SearchCompanySelectEvent(name: name));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar(),
      body: Container(
        child: BlocProvider<WorkOrderListBloc>(
          create: (context) => WorkOrderListBloc(
            workOrderListRepository: WorkOrderListRepositoryImpl(),
          ),
          child: BlocListener<WorkOrderListBloc, WorkOrderListState>(
            listener: (BuildContext context, WorkOrderListState state) {
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
              bloc: _workOrderListBloc,
              builder: (context, state) {
                if (state is WorkOrderListInitial) {
                  return buildLoading();
                } else if (state is ArticleLoadingState) {
                  return buildLoading();
                } else if (state is ArticleLoadedState) {
                  return buildArticleList(state.articles);
                } else if (state is ArticleErrorState) {
                  return buildErrorUi(state.message);
                } else {
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

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(message, style: TextStyle(color: Colors.red))),
    );
  }

  Widget buildArticleList(List<WOList> articles) {
    switch (_radioValue) {
      case 0:
        articles.sort((a, b) {
          return a.orderNumber.toString().compareTo(b.orderNumber.toString());
        });
        break;
      case 1:
        articles.sort((a, b) {
          return b.orderNumber.toString().compareTo(a.orderNumber.toString());
        });
        break;
      case 2:
        articles.sort((a, b) {
          return DateTime.parse('20' +
                  a.requestDate.substring(6) +
                  a.requestDate.substring(3, 5) +
                  a.requestDate.substring(0, 2))
              .compareTo(
            DateTime.parse(
              '20' +
                  b.requestDate.substring(6) +
                  b.requestDate.substring(3, 5) +
                  b.requestDate.substring(0, 2),
            ),
          );
        });
        break;
      case 3:
        articles.sort((a, b) {
          return DateTime.parse('20' +
                  b.requestDate.substring(6) +
                  b.requestDate.substring(3, 5) +
                  b.requestDate.substring(0, 2))
              .compareTo(
            DateTime.parse(
              '20' +
                  a.requestDate.substring(6) +
                  a.requestDate.substring(3, 5) +
                  a.requestDate.substring(0, 2),
            ),
          );
        });
        break;
      case 4:
        articles.sort((a, b) {
          return a.assetNumber.toString().compareTo(b.assetNumber.toString());
        });
        break;
      case 5:
        articles.sort((a, b) {
          return b.assetNumber.toString().compareTo(a.assetNumber.toString());
        });
        break;
      case 6:
        articles.sort((a, b) {
          return a.wOType.toString().compareTo(b.wOType.toString());
        });
        break;
      case 7:
        articles.sort((a, b) {
          return b.wOType.toString().compareTo(a.wOType.toString());
        });
        break;
      case 8:
        articles.sort((a, b) {
          return a.priority.toString().compareTo(b.priority.toString());
        });
        break;
      case 9:
        articles.sort((a, b) {
          return b.priority.toString().compareTo(a.priority.toString());
        });
        break;
      case 10:
        articles.sort((a, b) {
          return a.woStatus.toString().compareTo(b.woStatus.toString());
        });
        break;
      case 11:
        articles.sort((a, b) {
          return b.woStatus.toString().compareTo(a.woStatus.toString());
        });
        break;
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Card(
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
                            articles[item].orTy +
                                '#' +
                                articles[item].orderNumber.toString(),
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            articles[item].woDescription,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Text(
                                'Status: ',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                articles[item].woStatus,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
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
                            'Asset#',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            articles[item].assetNumber,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            articles[item].eqpDescription,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '',
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
                            'Branch',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            articles[item]
                                .branch
                                .replaceAll(RegExp('\\s+'), ''),
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            '',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Text(
                                'Priority: ',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                articles[item].priority,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ],
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
                            'Originator',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Assigned To',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Type',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Requested',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
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
                            articles[item].originatorNumber.toString(),
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            articles[item].assignedTo.toString(),
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            articles[item].wOType,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            articles[item].requestDate,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
          ),
        );
      },
    );
  }

  Widget appbar() {
    return PreferredSize(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: ColorCustom.blueGradient1),
              // color: Color.fromRGBO(246, 247, 249, 1),
              border: BorderDirectional(
                bottom: BorderSide(width: 1, color: Colors.black12),
              )),
          child: Padding(
              padding: EdgeInsets.only(left: 10, bottom: 24, right: 10),
              child: Column(
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Container(
                      //color: Colors.deepOrange,
                      //padding: EdgeInsets.only(left: 70),
                      //alignment: AlignmentDirectional.centerEnd,
                      child: ItemSearchFilter(
                        textHint: "Search by Order Number",
                        controller: controllerSearch,
                        onchange: onSearchFiltered,
                        onPress1: () {
                          print('OnPressed1');
                          print(dt);
                          _sortDialog(context);
                        },
                        onPress2: () {
                          print('OnPressed2');
                          _displayTextInputDialog(context);
                        },
                      ),
                    ),
                    // Container(
                    //     alignment: AlignmentDirectional.centerStart,
                    //     child: Text("Add Company",
                    //         style: TextStyle(
                    //             fontSize: 26,
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold))),
                    // Container(
                    //     alignment: AlignmentDirectional.centerStart,
                    //     child: Text("Select",
                    //         style: TextStyle(
                    //             fontSize: 15,
                    //             color: Colors.black,
                    //             fontWeight: FontWeight.bold)))
                  ])),
        ),
        preferredSize: Size.fromHeight(90));
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filter'),
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
                      Visibility(
                        visible: false,
                        child: Expanded(
                          flex: 4,
                          child: Text(
                            'Customer Number',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: _customerNumber,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Order Type',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _orderType,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Requested Date',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _requestDate,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Asset Number',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(controller: _assetNumber),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'WO Status',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _woStatus,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Branch',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _branch,
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
                  _customerNumber.text = '*';
                  _orderType.text = '*';
                  _requestDate.text = '*';
                  _assetNumber.text = '*';
                  _woStatus.text = '*';
                  _branch.text = '*';
                },
              ),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text('OK'),
                onPressed: () {
                  setState(() {
                    _workOrderListBloc.add(FilterListSelectEvent(
                        orTy: _orderType.text,
                        requestDate: _requestDate.text,
                        assetNumber: _assetNumber.text,
                        woStatus: _woStatus.text,
                        branch: _branch.text));
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          );
        });
  }

  Future<void> _sortDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Sort'),
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
                        '',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(FontAwesome5Solid.sort_alpha_down),
                    ),
                    Expanded(
                      flex: 1,
                      child: Icon(FontAwesome5Solid.sort_alpha_up),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Order Number',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: true,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Requested Date',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Radio(
                          value: 2,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChanged,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Radio(
                          value: 3,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChanged,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Asset Number',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 4,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 5,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'WO Type',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 6,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 7,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'Priority',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 8,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 9,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'WO Status',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 10,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Radio(
                        value: 11,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChanged,
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
                _radioValue = -1;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _handleRadioValueChanged(int value) {
    setState(() {
      _radioValue = value;
      print(_radioValue);
    });
    Navigator.pop(context);
  }
}
