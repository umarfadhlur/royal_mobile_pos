import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:royal_mobile_pos/core/constant/color.dart';
import 'package:royal_mobile_pos/core/constant/size_text.dart';
import 'package:royal_mobile_pos/feature/equipment_number/bloc/equipment_number_bloc.dart';
import 'package:royal_mobile_pos/feature/equipment_number/data/repository/equipment_number_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EquipmentNumberDetail extends StatefulWidget {
  //const EquipmentNumberDetail({ Key? key }) : super(key: key);

  @override
  _EquipmentNumberDetailState createState() => _EquipmentNumberDetailState();
}

class _EquipmentNumberDetailState extends State<EquipmentNumberDetail> {
  final globalKey = GlobalKey<ScaffoldState>();
  EquipmentNumberBloc _equipmentNumberBloc = EquipmentNumberBloc(
      equipmentNumberRepository: EquipmentNumberRepositoryIml());
  final _equipmentNumberController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  double lat, long;

  GoogleMapController _googleMapController;
  List<Marker> myMarker = [];

  Future<String> equipmentNumber() async {
    final prefs = await SharedPreferences.getInstance();
    String equipNumber = prefs.getString('assetNumber');
    _equipmentNumberController.text = equipNumber;
    return equipNumber;
  }

  delaySubmit() async {
    Future.delayed(Duration(seconds: 5), () {
      _onEquipmentSubmitted(context);
    });
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BotToast.showLoading();
    equipmentNumber();
    // _equipmentNumberController.text = equipNumber;
    _latitudeController.text = "0";
    _longitudeController.text = "0";
    delaySubmit();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      body: BlocProvider<EquipmentNumberBloc>(
        create: (context) => EquipmentNumberBloc(
          equipmentNumberRepository: EquipmentNumberRepositoryIml(),
        ),
        child: BlocListener(
          bloc: _equipmentNumberBloc,
          listener: (context, state) {
            if (state is AddError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                ),
              );
            } else if (state is EquipmentFound) {
              BotToast.closeAllLoading();
              print("cc");
              this._longitudeController.text = state.equipment.longitude;
              this._latitudeController.text = state.equipment.latitude;
              _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(double.parse(state.equipment.latitude),
                        double.parse(state.equipment.longitude)),
                    zoom: 12,
                  ),
                ),
              );
              myMarker = [];
              myMarker.add(
                Marker(
                  markerId: MarkerId(
                      state.equipment.latitude + state.equipment.longitude),
                  position: LatLng(double.parse(state.equipment.latitude),
                      double.parse(state.equipment.longitude)),
                ),
              );
            } else if (state is AddSuccess) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(state.success),
                ),
              );
            }
            print("aa");
          },
          child: BlocBuilder(
            bloc: _equipmentNumberBloc,
            builder: (context, state) {
              print("bb");
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: _size.width * 0.035),
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
                              flex: 4,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: _size.width * 0.035),
                                child: Container(
                                  width: _size.width * 0.45,
                                  height: _size.height * 0.06,
                                  child: TextFormField(
                                    onTap: () {},
                                    controller: _equipmentNumberController,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(8),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    style: TextStyle(fontSize: 15),
                                    onFieldSubmitted: (value) {
                                      _onEquipmentSubmitted(context);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _size.width * 0.035),
                              child: Text(
                                "Latitude",
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
                              padding:
                                  EdgeInsets.only(right: _size.width * 0.035),
                              child: Container(
                                width: _size.width * 0.45,
                                height: _size.height * 0.06,
                                child: TextFormField(
                                  onTap: () {},
                                  controller: _latitudeController,
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
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _size.width * 0.035),
                              child: Text(
                                "Longitude",
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
                              padding:
                                  EdgeInsets.only(right: _size.width * 0.035),
                              child: Container(
                                width: _size.width * 0.45,
                                height: _size.height * 0.06,
                                child: TextFormField(
                                  onTap: () {},
                                  controller: _longitudeController,
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
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          minWidth: _size.width * 0.5,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            if (_equipmentNumberController.text == null ||
                                _equipmentNumberController.text == "") {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Equipment Number Required'),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else {
                              _onEquipmentSubmitted(context);
                            }
                          },
                          child: Text(
                            "Get Equipment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Oswald'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 300,
                        child: GoogleMap(
                          mapType: MapType.normal,
                          markers: Set.from(myMarker),
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                double.parse(_latitudeController.text),
                                double.parse(_longitudeController.text)),
                            zoom: 12,
                          ),
                          onMapCreated: (controller) =>
                              _googleMapController = controller,
                          onTap: _handleTap,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(7.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          minWidth: _size.width * 0.5,
                          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          onPressed: () {
                            if (_equipmentNumberController.text == null ||
                                _equipmentNumberController.text == "") {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Equipment Number Required'),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else {
                              _onEquipmentUpdated(context);
                            }
                          },
                          child: Text(
                            "Update Equipment",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Oswald'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
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
            //Get.off(() => EquipmentNumber());
            // Get.to(() => EquipMasterList());
            Navigator.pop(context);
          },
        ),
      ),
      actions: [],
      titleSpacing: -20,
      title: Text(
        'Equipment Geolocation',
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

  _onEquipmentSubmitted(BuildContext context) {
    print("submit equip : ${_equipmentNumberController.text}");
    _equipmentNumberBloc
        .add(FindEquipment(equipmentNumber: _equipmentNumberController.text));
    //BlocProvider.of<EquipmentNumberBloc>(context).processPickingActualCompleted();
  }

  _onEquipmentUpdated(BuildContext context) {
    print("submit equip : ${_equipmentNumberController.text}");
    _equipmentNumberBloc.add(UpdateEquipment(
        equipmentNumber: _equipmentNumberController.text,
        latitude: _latitudeController.text,
        longitude: _longitudeController.text));
    //BlocProvider.of<EquipmentNumberBloc>(context).processPickingActualCompleted();
  }

  _handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      _latitudeController.text = tappedPoint.latitude.toString();
      _longitudeController.text = tappedPoint.longitude.toString();
      _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(tappedPoint.latitude, tappedPoint.longitude),
            zoom: 12,
          ),
        ),
      );
    });
  }
}
