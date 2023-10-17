import 'dart:math';

import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/feature/main_menu/data/model/count_wo_response.dart';
import 'package:pie_chart/pie_chart.dart';

Widget chartMenuCustom(ResponseCountWo countWO) {
  Map<String, double> dataMap;
  double number;
  if (countWO == null) {
    dataMap = {
    "Preventive": 5,
    "Predictive": 3,
    "Corrective": 2,
    "Breakdown": 2,
    "Modification": 2,
  };
  } else {
    String name = "a";
    double mod = pow(10.0, 0); 
    number = countWO.rudCountwopertypeF4801DrRepeating.first.rudCountwopertypeF4801Dr.rowset.first.countWo.toDouble();
    dataMap = {"Preventive" : ((number * mod).round().toDouble())};
    print(number);
    countWO.rudCountwopertypeF4801DrRepeating.forEach((element) {
      if(element.rudCountwopertypeF4801Dr.rowset.first.woType!="1") {
      if (element.rudCountwopertypeF4801Dr.rowset.first.woType=="2") {
        name = "Predictive";
        print("2");
      } else if (element.rudCountwopertypeF4801Dr.rowset.first.woType=="3") {
        name = "Corrective";
        print("3");
      } else if (element.rudCountwopertypeF4801Dr.rowset.first.woType=="4") {
        name = "Breakdown";
        print("4");
      } else if (element.rudCountwopertypeF4801Dr.rowset.first.woType=="5") {
        name = "Modification";
        print("5");
      } 
      //dataMap.addAll({name:element.rudCountwopertypeF4801Dr.rowset.first.countWo.toDouble()});
      dataMap[name] = element.rudCountwopertypeF4801Dr.rowset.first.countWo.toDouble();
      }
    });
    
  }
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Number of Work Orders",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 180,
            child: PieChart(
              //dataMap : dataMap,
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32,
              legendOptions: LegendOptions(
                showLegendsInRow: false,
                legendPosition: LegendPosition.right,
                showLegends: true,
                legendTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: true,
                showChartValues: true,
                showChartValuesInPercentage: false,
                showChartValuesOutside: false,
                decimalPlaces: 0,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
  );
}

// Map<String, double> dataMap = {
//     "Preventive": 5,
//     "Predictive": 3,
//     "Corrective": 2,
//     "Breakdown": 2,
//     "Modification": 2,
//   };