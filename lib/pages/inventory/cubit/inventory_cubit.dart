import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erpvc/repos/inventory_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';

import '../../../api_hleper/api_helper.dart';
import '../../../helper/helper.dart';
import '../../../model/inventory_list.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  // InventoryCubit({this.inventoryRepo,}) : super(InventoryState());

  InventoryCubit()
      : super(InventoryState.init(
            isProcessing: false, currentPage: 10, offset: 0));

  InventoryRepo? inventoryRepo;

  Future getProductList({String? barcodeScanNumber}) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    Map<String, dynamic> map = {};

    Response response = await inventoryRepo!.getInventoryProducts();

    if (response.statusCode == 200) {
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    }
    else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
      Helper.showToast("Something went wrong...");
    }
  }

  void paginationCurrentPage(var currentPageCount) {
    emit(state.copyWith(currentPage: currentPageCount));
  }

  Future<void> getInventoryList({int? currentPage}) async {
    if (currentPage! <= 10) {
      getProgressBar(false);
      emit(state.copyWith(
          inventoryList: null,
          currentPage: currentPage,
          dataInventoryListArray: []));
    }


    Map<String, dynamic> mapData = {"limit": "$currentPage", "offset": "0"};

    Map<String, dynamic>? response =
        await APIHelper().getInventoryList(mapData);

    //print("call limit data ${response!["totalrows"]}");
    getProgressBar(true);
    if (response != null) {
      InventoryList? loginResponse = InventoryList.fromJson(response);
      List<DataInventory>? listHistoryData = <DataInventory>[];

      listHistoryData = loginResponse!.data;
      if (state!.dataInventoryListArray != null &&
          state!.dataInventoryListArray!.length > 0) {
        print(
            "call history data ${state!.dataInventoryListArray ?? state!.dataInventoryListArray!.length}");

        for (int index = 0;
            state.dataInventoryListArray!.length > index;
            index++) {
          listHistoryData!.add(state!.dataInventoryListArray![index]);
        }
        ;
      }

      if (response != null) {
        emit(state.copyWith(
            inventoryList: loginResponse,
            currentPage: currentPage,
            totalLimit: response!["totalrows"],
            dataInventoryListArray: listHistoryData));
      } else {}
    } else {
      Fluttertoast.showToast(msg: "some error");
    }
  }

  getProgressBar(bool verData) {
    emit(state.copyWith(isProcessing: verData));
  }
}
