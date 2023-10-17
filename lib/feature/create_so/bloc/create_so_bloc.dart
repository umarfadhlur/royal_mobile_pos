import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/create_so_kit_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/create_so_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/create_so_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/freegoods_getprice_new_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/get_so_detail.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/get_so_history.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/item_branch_params.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/item_branch_response.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/post_so_history.dart';
import 'package:royal_mobile_pos/feature/create_so/data/model/post_so_history_new.dart';
import 'package:royal_mobile_pos/feature/create_so/data/repository/create_so_repository.dart';
import 'package:royal_mobile_pos/feature/customer/bloc/customer_bloc.dart';
import 'package:royal_mobile_pos/feature/customer/data/model/get_customer_response.dart';
import 'package:royal_mobile_pos/feature/get_price/data/model/get_price_params.dart';
import 'package:royal_mobile_pos/feature/get_price/data/model/get_price_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'create_so_state.dart';
part 'create_so_event.dart';

class CreateSoBloc extends Bloc<CreateSoEvent, CreateSoState> {
  final CreateSoRepository createSoRepository;

  CreateSoBloc({@required this.createSoRepository});

  @override
  Stream<CreateSoState> mapEventToState(
    CreateSoEvent event,
  ) async* {
    if (event is CreateSoEntry) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      // List<GridIn13> gridData = [];
      print(event.gridData);

      final listParam = CreateSoParamModel(
        // token: _token,
        username: 'jde',
        password: 'jde',
        branchPlant: event.branchPlant,
        customer: event.customer,
        gridIn13: event.gridData,
        transactionOriginator: event.transactionOriginator,
      );

      if (event.branchPlant != null) {
        try {
          final previousOrder =
              await createSoRepository.soEntry(listParam.toJson());
          print(previousOrder.previousOrder);
          if (previousOrder.previousOrder != null) {
            print('Success');
            yield GetOrderNumber(previousOrder: previousOrder);
            // yield SuccessEntry(message: 'SO Created');
          } else {
            print('Failed');
            yield FailedEntry(message: 'SO Failed');
          }
        } catch (e) {
          yield FailedEntry(message: 'SO Failed');
        }
      }
    } else if (event is CreateSoKitEntry) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      // List<GridIn13> gridData = [];
      print(event.gridData);

      final listParam = CreateSoParamModel(
        // token: _token,
        username: 'jde',
        password: 'jde',
        branchPlant: event.branchPlant,
        customer: event.customer,
        gridIn13: event.gridData,
        transactionOriginator: event.transactionOriginator,
      );

      if (event.branchPlant != null) {
        try {
          final previousOrder =
              await createSoRepository.soKitEntry(listParam.toJson());
          print(previousOrder.continuedOnError);
          if (previousOrder.serviceRequest2.submitted != null) {
            print('Success');
            yield GetOrderKitNumber(previousOrder: previousOrder);
            // yield SuccessEntry(message: 'SO Created');
          } else {
            print('Failed');
            yield FailedEntry(message: 'SO Failed');
          }
        } catch (e) {
          yield FailedEntry(message: 'SO Failed');
        }
      }
    } else if (event is GetPriceListEvent) {
      print('Get Price List');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);

      final listParam = GetPriceParamModel(
          // token: _token,
          username: 'jde',
          password: 'jde',
          addressNumber: event.addressNumber,
          businessUnit: event.businessUnit,
          itemNumber: event.itemNumber);

      List<PriceList> rowset1 = [];
      List<PriceList> rowset2 = [];

      if (event.itemNumber != null) {
        try {
          print('No data ${event.itemNumber}');
          rowset2.clear();
          rowset1 = await createSoRepository.getPriceList(listParam.toJson());
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
          rowset1 = await createSoRepository.getPriceList(listParam.toJson());
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
    } else if (event is GetFreeGoodsPriceHistoryEvent) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);

      final listParam = FreeGoodsGetPriceParams(
        // token: _token,
        username: 'jde',
        password: 'jde',
        gridIn11: event.gridData,
      );

      print(listParam.toJson());

      if (event.gridData != []) {
        try {
          FreeGoodsGetPriceResponse data = await createSoRepository
              .getFreeGoodsPriceHistory(listParam.toJson());
          yield FreeGoodsPriceHistoryLoaded(data: data);
        } catch (e) {
          yield FreeGoodsPriceHistoryFailed(message: 'Failed');
        }
      }
    } else if (event is GetFreeGoodsPriceHistoryNewEvent) {
      yield LoadingDataState();
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);

      final listParam = FreeGoodsGetPriceParams(
        // token: _token,
        username: 'jde',
        password: 'jde',
        gridIn11: event.gridData,
      );

      print(listParam.toJson());

      if (event.gridData != []) {
        try {
          print('apakah sampaii sini');
          FreeGoodsGetPriceResponseNew data = await createSoRepository
              .getFreeGoodsPriceHistoryNew(listParam.toJson());
          yield FreeGoodsPriceHistoryNewLoaded(data: data);
        } catch (e) {
          yield FreeGoodsPriceHistoryNewFailed(message: e.toString());
        }
      }
    } else if (event is GetSoHistoryLoadEvent) {
      try {
        List<GetSoHistory> rowset = await createSoRepository.getSoHistory();
        yield SoHistoryLoaded(data: rowset);
      } catch (e) {
        yield SoHistoryFailed(message: 'Failed');
      }
    } else if (event is PostSoHistoryEvent) {
      final listParam = PostSoHistory(
        an8: event.an8,
        doco: event.doco,
        mcu: event.mcu,
        soDate: event.soDate,
        vr01: event.vr01,
      );
      try {
        String statusCode =
            await createSoRepository.postDataHistory(listParam.toJson());
        print(statusCode);
        if (statusCode == "200") {
          print('Success');
          print(listParam);
          yield PostHistorySuccess(message: 'SO Saved');
        } else {
          print('Failed');
          yield PostHistoryFailed(message: 'SO Failed');
        }
      } catch (e) {
        yield PostHistoryFailed(message: 'SO Failed');
      }
    } else if (event is PostSoHistoryNewEvent) {
      final listParam = PostSoHistoryNew(
          an8: event.an8,
          doco: event.doco,
          mcu: event.mcu,
          soDate: event.soDate,
          vr01: event.vr01,
          details: event.gridData);
      try {
        String statusCode =
            await createSoRepository.postDataHistory(listParam.toJson());
        print(statusCode);
        if (statusCode == "200") {
          print('Success');
          print(listParam);
          yield PostHistorySuccess(message: 'SO Saved');
        } else {
          print('Failed');
          yield PostHistoryFailed(message: 'SO Failed');
        }
      } catch (e) {
        yield PostHistoryFailed(message: 'SO Failed');
      }
    } else if (event is FetchSoDetailEvent) {
      try {
        List<GetSoDetail> data =
            await createSoRepository.getSoDetail(event.soHeaderId);
        print(data);
        yield SoDetailLoaded(detail: data);
      } catch (e) {
        yield SoDetailFailed(message: 'Failed');
      }
    } else if (event is GetCustomerEntry) {
      try {
        List<GetCustomerResponse> data = await createSoRepository.getCustomer();
        print(data);
        yield CustomerLoaded(articles: data);
      } catch (e) {
        yield CustomerFailed(message: 'Failed');
      }
    } else if (event is GetItemBranchEvent) {
      print('Get Item Branch');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);

      final listParam = ItemBranchParams(
        // token: _token,
        username: 'jde',
        password: 'jde',
        the2NdItemNumber1: event.the2NdItemNumber1,
        businessUnit1: event.businessUnit1,
      );

      List<ItemBranch> rowset1 = [];
      List<ItemBranch> rowset2 = [];

      if (event.the2NdItemNumber1 != null) {
        try {
          print('No data ${event.the2NdItemNumber1}');
          rowset2.clear();
          rowset1 = await createSoRepository.getItemBranch(listParam.toJson());
          yield ItemBranchLoaded(articles: rowset1);
        } catch (e) {
          yield ItemBranchFailed(message: "Not Found");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await createSoRepository.getItemBranch(listParam.toJson());
          if (rowset1 != null) {
            yield ItemBranchLoaded(articles: rowset1);
            print('data1');
          } else {
            yield ItemBranchFailed(message: 'Not Found');
          }
        } catch (e) {
          yield ItemBranchFailed(message: "Not Found");
        }
      }
    }
  }

  @override
  CreateSoState get initialState => CreateSoInitial();
}
