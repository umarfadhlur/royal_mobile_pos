import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/bom/data/model/bom_params.dart';
import 'package:royal_mobile_pos/feature/bom/data/model/bom_response.dart';
import 'package:royal_mobile_pos/feature/bom/data/repository/bom_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'bom_event.dart';
part 'bom_state.dart';

class BomBloc extends Bloc<BomEvent,BomState> {
  final BomRepository bomRepository;

  BomBloc({@required this.bomRepository});
  
  @override
  Stream<BomState> mapEventToState(BomEvent event) async* {
    if (event is GetBomEvent) {
      print('Get BOM');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);

      final listParam = BomParams(
        // token: _token,
        username: 'jde',
        password: 'jde',
        the2NdItemNumber1: event.the2ndItemNumber,
        branch1: event.branch1,
        typBom1: 'M',
      );

      List<Rowset> rowset1 = [];
      List<Rowset> rowset2 = [];

      if (event.the2ndItemNumber != null) {
        try {
          yield ArticleLoadingState();
          print('No data ${event.the2ndItemNumber}');
          rowset2.clear();
          rowset1 = await bomRepository.bomList(listParam.toJson());
          print('No data1 $rowset1');
          yield BomLoaded(articles: rowset1);
        } catch (e) {
          yield BomNotFound(message: "Not Found");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await bomRepository.bomList(listParam.toJson());
          if (rowset1 != null) {
            yield BomLoaded(articles: rowset1);
            print('data1');
          } else {
            yield BomNotFound(message: 'Not Found');
          }
        } catch (e) {
          yield BomNotFound(message: "Not Found");
        }
      }
    }
  }

  @override
  BomState get initialState => BomInitial();
}