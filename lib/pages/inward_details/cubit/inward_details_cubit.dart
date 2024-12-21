import 'package:bloc/bloc.dart';
import 'package:erpvc/model/rack_list.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../api_hleper/api_helper.dart';
import '../../../model/inward_deatils_model_data.dart';
import '../../add_to_rack/cubit/add_to_rack_cubit.dart';
import '../../dashboard/cubit/dashboard_cubit.dart';
import 'inward_details_state.dart';

class InwardDetailsCubit extends Cubit<InwardDetailsState> {
  /* InwardDetailsCubit()
      : super(InwardDetailsState.init(
          isProcessing: false,
          isAddRackVisible: false,
          isAddRackCount: 1,
        ));

  void init() async {
    print("call DashboardInitial");
  }
*/
  InwardDetailsCubit()
      : super(InwardDetailsState.init(
          isProcessing: false,
          isProcessingVar: false,
          isAddRackVisible: false,
          isAddRackCount: 1,
        ));

  getProgressBar(bool verData) {
    emit(state.copyWith(isProcessing: verData));
  }

  getRackAssign(int id) {


    if(navigatorKey.currentState!.context
        .read<AddToRackCubit>()
        .state
        .isProcessingVar!)
      {
        if (state.isProcessingVar!) {
        } else {
          if (navigatorKey.currentState!.context
              .read<AddToRackCubit>()
              .state
              .inputDataList !=
              null &&
              navigatorKey.currentState!.context
                  .read<AddToRackCubit>()
                  .state
                  .inputDataList!
                  .isNotEmpty &&
              navigatorKey.currentState!.context
                  .read<AddToRackCubit>()
                  .state
                  .inputDataList!
                  .any((element) => element['id'] == id)) {
            int indexV = navigatorKey.currentState!.context
                .read<AddToRackCubit>()
                .state
                .inputDataList!
                .indexWhere((element) => element['id'] == id);
            if (indexV != -1) {
              navigatorKey.currentState!.context
                  .read<AddToRackCubit>()
                  .isProgressBar(true);

              emit(state.copyWith(isProcessingVar: true));
            }
          } else {
            navigatorKey.currentState!.context
                .read<AddToRackCubit>()
                .isProgressBar(false);
            emit(state.copyWith(isProcessingVar: false));
          }
        }
      }

  }

  getRackAssignFastTime(bool isProcessingVar) {
    navigatorKey.currentState!.context
        .read<AddToRackCubit>()
        .isProgressBar(false);

    emit(state.copyWith(isProcessingVar: isProcessingVar));
  }

  Future<void> getInwardDetails(String? id) async {
    emit(state.copyWith(inwardDetailsModelVar: null));
    getProgressBar(false);
    Map<String, dynamic>? response = await APIHelper().getInwardDetails("$id");
    getProgressBar(true);
    if (response != null) {
      InwardDeatilsModelData? loginResponse =
          InwardDeatilsModelData.fromJson(response);
      if (response != null) {
        emit(state.copyWith(inwardDetailsModelVar: loginResponse));
        if (state.inwardDetailsModelVar!.data!.itemslist!.isNotEmpty) {}
      } else {}
    } else {
      Fluttertoast.showToast(msg: "some error");
    }
  }
}

/*
class InwardDetailsCubit extends Cubit<InwardDetailsState> {
  InwardDetailsCubit()
      : super(InwardDetailsState.init(
          isProcessing: false,
        ));

  void init() async {
    print("call DashboardInitial");
  }

  getProgressBar(bool verData) {
    emit(state.copyWith(isProcessing: verData));
  }

  Future<void> getInwardDetails(String? id) async {
    emit(state.copyWith(inwardDetailsModelVar: null));

    Map<String, dynamic>? response = await APIHelper().getInwardDetails("$id");
    if (response != null) {
      InwardDeatilsModelData? loginResponse =
          InwardDeatilsModelData.fromJson(response);

      if (response != null) {
        emit(state.copyWith(inwardDetailsModelVar: loginResponse));
      } else {}
    } else {
      Fluttertoast.showToast(msg: "some error");
    }
  }



  Future<void> getRackList() async {
    emit(state.copyWith(inwardDetailsModelVar: null));

    Map<String, dynamic>? response = await APIHelper().getRackList();
    if (response != null) {
      RackList? loginResponse =
      RackList.fromJson(response);

      if (response != null) {
        emit(state.copyWith(rackList: loginResponse));
      } else {}
    } else {
      Fluttertoast.showToast(msg: "some error");
    }
  }
  Future<void> getAddItems(var map) async {
    emit(state.copyWith(inwardDetailsModelVar: null));

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
  }

}
*/
