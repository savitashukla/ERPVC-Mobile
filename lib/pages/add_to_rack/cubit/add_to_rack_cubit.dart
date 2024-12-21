import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api_hleper/api_helper.dart';
import '../../../model/inward_deatils_model_data.dart';
import '../../../model/rack_list.dart';

part 'add_to_rack_state.dart';

class AddToRackCubit extends Cubit<AddToRackState> {
  AddToRackCubit()
      : super(AddToRackState.init(
          isProcessing: false,
          isProcessingVar: false,

          isAddRackVisible: false,
          isAddRackCount: 1,
        ));




  getProgressBar(bool verData) {
    emit(state.copyWith(isProcessingVar: verData));
  }
  Future<void> getAddItems(String inwardId) async {
    Map<String, String> allItemAdd = {};
    allItemAdd["inward_id"] = inwardId;


    emit(state.copyWith(isProcessing:false,isProcessingVar:false));
    final List<Map<String, dynamic>>? inputDataList1=[];

    debugPrint("inputDataList");
    debugPrint(state.inputDataListVar.toString());

    inputDataList1!.addAll(state.inputDataListVar!);

    if (state.inputDataListAddMoreItemVar!=null && state.inputDataListAddMoreItemVar!.isNotEmpty) {

      inputDataList1!.addAll(state.inputDataListAddMoreItemVar!);
    }


    allItemAdd["rack_data"] = jsonEncode(inputDataList1);
    debugPrint("allItemAdd");
    debugPrint(allItemAdd.toString());


    debugPrint("inputDataList");
    debugPrint(state.inputDataListVar.toString());

    Map<String, dynamic>? response = await APIHelper().getAddItems(allItemAdd);

    emit(state.copyWith(isProcessing:true,isProcessingVar:true));

    if (response != null) {
      //   Fluttertoast.showToast(msg: "");
    } else {
      //    Fluttertoast.showToast(msg: "some error");
    }
  }




  Future<void> getRackItemListData(List<Itemslist>? rackListData) async {
    print("rackListData![0].itemId");
    print(rackListData![0].itemId);
    emit(state.copyWith(rackItemList: rackListData));
  }



  Future<void> setTotalReceiveValues(int? totalReceiveValues,String id) async {
    Map<String, dynamic>?  currentData = {...state.totalReceiveQnt ?? {}};
    Map<String, dynamic>? chec={"$id":totalReceiveValues
    };


    if(currentData.containsKey("${id}"))
      {
        currentData["${id}"]=totalReceiveValues;
      }
    {
      currentData.addAll(chec);
    }





    emit(state.copyWith(totalReceiveQnt: currentData));
  }

  void addMoreRackListVisible(bool? addMoreRackVisible) async {
    emit(state.copyWith(isAddRackVisible: addMoreRackVisible));
  }

  void isProgressBar(bool? addMoreRackVisible) async {
    emit(state.copyWith(isProcessing: addMoreRackVisible));
  }

  Future<void> addMoreRackListCount(int? addMoreRackCount) async {
    emit(state.copyWith(isAddRackCount: addMoreRackCount));
  }

  void selectedRackItem(Map<String, dynamic> selectedRackItem) async {
    List<Map<String, dynamic>> currentData = [...state.selectedRackItem ?? []];

    if (currentData.isNotEmpty &&
        currentData.any((element) =>
            element['itemDataId'] == selectedRackItem['itemDataId'])) {
      int indexV = currentData.indexWhere(
          (element) => element['itemDataId'] == selectedRackItem['itemDataId']);
      if (indexV != -1) {
        currentData[indexV] = selectedRackItem;
      }
    } else {
      currentData.add(selectedRackItem);
    }

    emit(state.copyWith(selectedRackItem: currentData));
  }

 void  onInputDataChangeSetEmpty()
  {
    emit(state.copyWith(inputDataListVar:[],inputDataListAddMoreItemVar:[]));
  }

  void onInputDataChange(Map<String, dynamic> rackData) async {
    List<Map<String, dynamic>> currentData = [...state.inputDataList ?? []];

    if (currentData.isNotEmpty &&
        currentData.any((element) => element['id'] == rackData['id'])) {
      int indexV =
          currentData.indexWhere((element) => element['id'] == rackData['id']);
      if (indexV != -1) {
        currentData[indexV] = rackData;
      }
    } else {
      currentData.add(rackData);
    }

    emit(state.copyWith(inputDataList: currentData!));
  }
  void onInputDataChangeVar(Map<String, dynamic> rackData) async {
    List<Map<String, dynamic>> currentData = [...state.inputDataListVar ?? []];

    if (currentData.isNotEmpty &&
        currentData.any((element) => element['id'] == rackData['id'])) {
      int indexV =
      currentData.indexWhere((element) => element['id'] == rackData['id']);
      if (indexV != -1) {
        currentData[indexV] = rackData;
      }
    } else {
      currentData.add(rackData);
    }

    emit(state.copyWith(inputDataListVar: currentData!));
  }



  void onInputDataChangeAddMoreRack(Map<String, int> rackData) async {
    List<Map<String, dynamic>> currentData = [
      ...state.inputDataListAddMoreItem ?? []
    ];

    if (currentData.isNotEmpty &&
        currentData.any((element) => element['id'] == rackData['id'])) {
      int indexV =
          currentData.indexWhere((element) => element['id'] == rackData['id']);
      if (indexV != -1) {
        currentData[indexV] = rackData;
      }
    } else {
      currentData.add(rackData);
    }

    emit(state.copyWith(inputDataListAddMoreItem: currentData!));
  }
  void onInputDataChangeAddMoreRackVar(Map<String, int> rackData) async {
    List<Map<String, dynamic>> currentData = [
      ...state.inputDataListAddMoreItemVar ?? []
    ];

    if (currentData.isNotEmpty &&
        currentData.any((element) => element['id'] == rackData['id'])) {
      int indexV =
      currentData.indexWhere((element) => element['id'] == rackData['id']);
      if (indexV != -1) {
        currentData[indexV] = rackData;
      }
    } else {
      currentData.add(rackData);
    }

    emit(state.copyWith(inputDataListAddMoreItemVar: currentData!));
  }

  Future<void> getRackList() async {
    Map<String, dynamic>? response = await APIHelper().getRackList();
    emit(state.copyWith(
        rackList: null,
        selectRackData: null));
    if (response != null) {
      RackList? loginResponse = RackList.fromJson(response);

      if (response != null) {

        if(loginResponse.data!=null && loginResponse.data!.isNotEmpty)
          {
            emit(state.copyWith(
                rackList: loginResponse,
                selectRackData: loginResponse.data!.first));
          }
        else
          {
            emit(state.copyWith(
                rackList: null,
                selectRackData: null));
          }

      } else {}
    } else {
      Fluttertoast.showToast(msg: "Rack list api not working");
    }
  }

  Future<void> getSelectedRack(RackData? rackData) async {
    emit(state.copyWith(selectRackData: rackData));
  }
/*Future<void> getAddItems(var map) async {
    // emit(state.copyWith(inwardDetailsModelVar: null));

    Map<String, dynamic>? response = await APIHelper().getAddItems(map);
    if (response != null) {
      InwardDeatilsModelData? loginResponse =
      InwardDeatilsModelData.fromJson(response);

      if (response != null) {
        emit(state.copyWith(inwardDetailsModelVar: loginResponse));
      } else {}
    } else {
      Fluttertoast.showToast(msg: "some error");
    }
  }*/
}
