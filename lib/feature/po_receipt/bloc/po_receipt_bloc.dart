import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:royal_mobile_pos/core/constant/shared_preference.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/model/get_item_description_response_model.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/model/get_qty_uom_response_model.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/model/po_receipt_new_param_modal.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/model/po_receipt_param_model.dart';
import 'package:royal_mobile_pos/feature/po_receipt/data/repository/po_receipt_repository.dart';
// import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'po_receipt_state.dart';
part 'po_receipt_event.dart';

class PoReceiptBloc extends Bloc<PoReceiptEvent, PoReceiptState> {
  // final _logger = Logger();
  final PoReceiptRepository poReceiptRepository;

  PoReceiptBloc({@required this.poReceiptRepository});

  @override
  Stream<PoReceiptState> mapEventToState(
    PoReceiptEvent event,
  ) async* {
    if (event is PoEntry) {
      print('Entry');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "NomorSuratJalan", value: event.noSurat),
        Input(name: "Driver", value: event.driver),
        Input(name: "Container ID", value: event.containerID),
        Input(name: "NomorKendaraan", value: event.noKendaraan),
        Input(name: "PO Number", value: event.poNumber),
        Input(name: "Lot Serial Number", value: event.lotNumber),
        Input(name: "Item Number", value: event.itemNumber),
        Input(name: "Quantity", value: event.quantity),
        Input(name: "UOM", value: event.uom),
      ];
      print('NomorSuratJalan: ${event.noSurat}');
      print('Driver: ${event.driver}');
      print('Container ID: ${event.containerID}');
      print('NomorKendaraan: ${event.noKendaraan}');
      print('PO Number: ${event.poNumber}');
      print('Lot Serial Number: ${event.lotNumber}');
      print('Item Number: ${event.itemNumber}');
      print('Quantity: ${event.quantity}');
      print('UOM: ${event.uom}');

      final listParam = PoReceiptParam(token: _token, inputs: paramList);
      String statusCode;
      if (event.noSurat != null) {
        try {
          statusCode = await poReceiptRepository.ccEntry(listParam.toJson());
          print(statusCode);
          if (statusCode == "200") {
            print('Success');
            yield SuccessEntry(message: 'Nomor Surat Updated');
          } else {
            print('Failed');
            yield FailedEntry(message: 'Update Failed');
          }
        } catch (e) {
          yield FailedEntry(message: 'Update Failed');
        }
      }
    } else if (event is NewPoEntry) {
      print('new Entry');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<GridDatum> gridData = [];
      print(gridData);

      // gridData.add(GridDatum(
      //   poNumber: event.poNumber,
      //   lotSerialNumber: event.lotNumber,
      //   itemNumber: event.itemNumber,
      //   quantity: event.quantity,
      //   uom: event.uom,
      // ));

      final listParam = PoReceiptNewParam(
        token: _token,
        nomorSuratJalan: event.noSurat,
        driver: event.driver,
        containerId: event.containerID,
        nomorKendaraan: event.noKendaraan,
        gridData: event.gridData,
      );

      String statusCode;
      if (event.noSurat != null) {
        try {
          statusCode = await poReceiptRepository.ccEntry(listParam.toJson());
          print(statusCode);
          if (statusCode == "200") {
            print('Success');
            yield SuccessEntry(message: 'Nomor Surat Entered');
          } else {
            print('Failed');
            yield FailedEntry(message: 'Update Failed');
          }
        } catch (e) {
          yield FailedEntry(message: 'Update Failed');
        }
      }
    } else if (event is LotCheck) {
      print('PO Check');
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Lot Serial Number 1", value: event.lotNumber),
      ];
      print('Lot Serial Number: ${event.lotNumber}');

      final listParam = PoReceiptParam(token: _token, inputs: paramList);

      if (event.lotNumber != null) {
        try {
          final parentNumber =
              await poReceiptRepository.checkLot(listParam.toJson());
          print(parentNumber);
          if (parentNumber == 0) {
            print('Success');
            yield LotNotFound(message: '');
          } else {
            print('Failed');
            yield LotFound(message: 'Lot Number Already Defined');
          }
        } catch (e) {
          yield LotFound(message: 'Update Failed');
        }
      }
    } else if (event is GetQtyUom) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Lot Serial Number 1", value: event.lotNumber),
      ];
      print('Lot Serial Number: ${event.lotNumber}');

      final listParam = PoReceiptParam(token: _token, inputs: paramList);
      List<QtyUom> rowset1 = [];
      List<QtyUom> rowset2 = [];

      if (event.lotNumber != null) {
        try {
          print('No data ${event.lotNumber}');
          rowset2.clear();
          rowset1 = await poReceiptRepository.getQty(listParam.toJson());
          print('qty: ${rowset1.first.quantity}');
          print('uom: ${rowset1.first.uom}');
          print('No data1 $rowset1');
          yield QtyUomLoaded(qtyuoms: rowset1);
        } catch (e) {
          yield QtyNotFound(message: "Not Found");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await poReceiptRepository.getQty(listParam.toJson());
          if (rowset1 != null) {
            yield QtyUomLoaded(qtyuoms: rowset1);
            print('data1');
          } else {
            yield QtyNotFound(message: 'Not Found');
          }
        } catch (e) {
          yield QtyNotFound(message: "Not Found");
        }
      }
    } else if (event is UpdateItem) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "Lot Serial Number 1", value: event.lotNumber),
        Input(name: "2nd Item Number 1", value: event.itemNumber),
      ];
      print('Lot Serial Number: ${event.lotNumber}');

      final listParam = PoReceiptParam(token: _token, inputs: paramList);
      List<QtyUom> rowset1 = [];
      List<QtyUom> rowset2 = [];

      if (event.lotNumber != null) {
        try {
          print('No data ${event.lotNumber}');
          rowset2.clear();
          rowset1 = await poReceiptRepository.updateItem(listParam.toJson());
          print('qty: ${rowset1.first.quantity}');
          print('uom: ${rowset1.first.uom}');
          print('No data1 $rowset1');
          yield QtyUomLoaded(qtyuoms: rowset1);
        } catch (e) {
          yield QtyNotFound(message: "Not Found");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await poReceiptRepository.getQty(listParam.toJson());
          if (rowset1 != null) {
            yield QtyUomLoaded(qtyuoms: rowset1);
            print('data1');
          } else {
            yield QtyNotFound(message: 'Not Found');
          }
        } catch (e) {
          yield QtyNotFound(message: "Not Found");
        }
      }
    } else if (event is GetItemDesc) {
      final sharedPreferences = await SharedPreferences.getInstance();
      final _token = sharedPreferences.get(SharedPref.token);
      List<Input> paramList = [
        Input(name: "2nd Item Number 1", value: event.itemDesc),
      ];
      print('Lot Serial Number: ${event.itemDesc}');

      final listParam = PoReceiptParam(token: _token, inputs: paramList);
      List<ItemDesc> rowset1 = [];
      List<ItemDesc> rowset2 = [];

      if (event.itemDesc != null) {
        try {
          print('No data ${event.itemDesc}');
          rowset2.clear();
          rowset1 = await poReceiptRepository.getDesc(listParam.toJson());
          print('data: ${rowset1.first.description}');
          print('No data1 $rowset1');
          yield ItemDescLoaded(descs: rowset1);
        } catch (e) {
          yield ItemDescNotFound(message: "Not Found");
        }
      } else {
        try {
          rowset1.clear();
          rowset1 = await poReceiptRepository.getDesc(listParam.toJson());
          if (rowset1 != null) {
            yield ItemDescLoaded(descs: rowset1);
            print('data1');
          } else {
            yield ItemDescNotFound(message: 'Not Found');
          }
        } catch (e) {
          yield ItemDescNotFound(message: "Not Found");
        }
      }
    }
  }

  @override
  PoReceiptState get initialState => PoReceiptInitial();
}
