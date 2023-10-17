import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/get_price/data/model/get_price_params.dart';
import 'package:royal_mobile_pos/feature/get_price/data/model/get_price_response.dart';
import 'package:royal_mobile_pos/feature/get_price/data/repository/get_price_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_price_state.dart';
part 'get_price_event.dart';

class GetPriceBloc extends Bloc<GetPriceEvent,GetPriceState> {
  final GetPriceRepository getPriceRepository;

  GetPriceBloc({@required this.getPriceRepository});
  
  @override
  Stream<GetPriceState> mapEventToState(GetPriceEvent event) async* {
    if (event is GetPriceListEvent) {
      print('Get Price List');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);

      final listParam = GetPriceParamModel(
        // token: _token,
        username: 'jde',
        password: 'jde',
        addressNumber: event.addressNumber,
        businessUnit: event.businessUnit,
        itemNumber: event.itemNumber
      );

      List<PriceList> rowset1 = [];
      List<PriceList> rowset2 = [];

      if (event.itemNumber != null) {
        try {
          print('No data ${event.itemNumber}');
          rowset2.clear();
          rowset1 = await getPriceRepository.getPriceList(listParam.toJson());
          print('sqqNo: ${rowset1.first.seqNo}');
          print('adjName: ${rowset1.first.adjName}');
          print('descAdjName: ${rowset1.first.descAdjName}');
          print('factorValueNumeric: ${rowset1.first.factorValueNumeric}');
          print('unitPrice: ${rowset1.first.unitPrice}');
          print('bC: ${rowset1.first.bC}');
          print('No data1 $rowset1');
          yield PriceListLoaded(articles: rowset1);
        } catch (e) {
          yield PriceListNotFound(message: "Not Found");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await getPriceRepository.getPriceList(listParam.toJson());
          if (rowset1 != null) {
            yield PriceListLoaded(articles: rowset1);
            print('data1');
          } else {
            yield PriceListNotFound(message: 'Not Found');
          }
        } catch (e) {
          yield PriceListNotFound(message: "Not Found");
        }
      }
    }
  }

  @override
  GetPriceState get initialState => GetPriceInitial();
}