import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:royal_mobile_pos/feature/customer/data/model/add_customer_params.dart';
import 'package:royal_mobile_pos/feature/customer/data/model/get_customer_response.dart';
import 'package:royal_mobile_pos/feature/customer/data/repository/customer_repository.dart';

part 'customer_event.dart';
part 'customer_state.dart';

class GetCustomerBloc extends Bloc<GetCustomerEvent, GetCustomerState> {
  final GetCustomerRepository getCustomerRepository;

  GetCustomerBloc({this.getCustomerRepository});

  @override
  Stream<GetCustomerState> mapEventToState(
    GetCustomerEvent event,
  ) async* {
    if (event is GetCustomerEntry) {
      try {
        List<GetCustomerResponse> data =
            await getCustomerRepository.getCustomer();
        print(data);
        yield CustomerLoaded(articles: data);
      } catch (e) {
        yield CustomerFailed(message: 'Failed');
      }
    } else if (event is AddCustomerEvent) {
      final listParam = AddCustomerParams(
        nama: event.nama,
        alamat: event.alamat,
        noHp: event.noHp,
        idNumber: event.idNumber,
      );
      try {
        String statusCode =
            await getCustomerRepository.postCustomerData(listParam.toJson());
        print(statusCode);
        if (statusCode == "200") {
          print('Success');
          print(listParam);
          yield AddCustomerSuccess(message: 'Customer Saved');
        } else {
          print('Failed');
          yield AddCustomerFailed(message: 'Customer Failed');
        }
      } catch (e) {
        yield AddCustomerFailed(message: 'Customer Failed');
      }
    }
  }

  @override
  GetCustomerState get initialState => GetCustomerInitial();
}
