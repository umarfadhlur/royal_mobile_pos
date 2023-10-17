import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:royal_mobile_pos/core/constant/color.dart';
import 'package:royal_mobile_pos/core/constant/size_text.dart';
import 'package:royal_mobile_pos/feature/equipment_number/bloc/equipment_number_bloc.dart';
import 'package:royal_mobile_pos/feature/equipment_number/data/repository/equipment_number_repo.dart';
import 'package:royal_mobile_pos/feature/equipment_number/ui/page/equipment_number_detail.dart';
import 'package:royal_mobile_pos/feature/equipment_number/ui/widget/item_list_equipment.dart';
import 'package:royal_mobile_pos/feature/login/ui/page/home_page.dart';

class EquipmentNumber extends StatefulWidget {
  //const EquipmentNumber({ Key? key }) : super(key: key);

  @override
  _EquipmentNumberState createState() => _EquipmentNumberState();
}

class _EquipmentNumberState extends State<EquipmentNumber> {
  EquipmentNumberBloc _equipmentNumberBloc;

  @override
  void initState() {
    super.initState();
    _equipmentNumberBloc = EquipmentNumberBloc(
        equipmentNumberRepository: EquipmentNumberRepositoryIml());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocProvider<EquipmentNumberBloc>(
        create: (context) => EquipmentNumberBloc(
          equipmentNumberRepository: EquipmentNumberRepositoryIml(),
        ),
        child: Container(
          child: BlocListener<EquipmentNumberBloc, EquipmentNumberState>(
            listener: (context, state) {
              // if (state is ListreimbursmentError) {
              //   Scaffold.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text(state.error),
              //     ),
              //   );
              // }
              //return _body(context);
            },
            child: BlocBuilder(
              bloc: _equipmentNumberBloc,
              builder: (context, state) {
                // if (state is ListreimbursmentLoad) {
                //   return buildLoading();
                // } else if (state is ListreimbursmentLoaded) {
                //   return buildReimbursList(state.reimbursement);
                // } else if (state is ListreimbursmentError) {
                //   return buildErrorUi(state.error);
                // } else {
                //   return Container();
                // }
                return _body(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, item) {
        return Padding(
          padding: EdgeInsets.only(bottom: 2.0),
          child: Card(
            child: InkWell(
              child: itemListEquipment(
                  name: "Data"),
                onTap: () {
                Get.to(() => EquipmentNumberDetail());
                //BlocProvider.of<ListreimbursmentBloc>(context).add();
              },
            ),
          ),
        );
      },
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
            Get.off(() => HomePage());
          },
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add_circle, color: Colors.white),
          tooltip: "info",
          onPressed: () {
            //Get.to(() => AddReimbursement());
          },
        ),
      ],
      titleSpacing: -20,
      title: Text(
        'Equipment Number',
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
}