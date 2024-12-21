
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../api_hleper/api_helper.dart';
import '../../../helper/helper.dart';
import '../../../model/inword_model.dart';
import '../../../model/party_name_model.dart';
import '../../../model/user_profile_data.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit()
      : super(DashboardState.init(
    isProcessing: false,
  ));


  void init() async {
    print("call DashboardInitial");
    //getUserDeals();
  }

  Future<void> getInwardList([String? dateStart,String? dateEnd,String? itemSearch]) async {

    emit(state.copyWith(inwardModelVar: null));
    getProgressBar(false);
    Map<String, dynamic> mapData = {};
    mapData['date_start'] = dateStart ?? "${DateTime.now()}";
    mapData['date_end'] = dateEnd ?? "";
    mapData['keyword'] = itemSearch ?? "";
   // mapData['limit'] = "10";
   // mapData['offset'] = "0";


    print("inward params");
    print(mapData.toString());
    Map<String, dynamic>? response = await APIHelper().getInwardList(mapData);
    getProgressBar(true);

    if (response != null) {
      print("response data${response!["data"]}");
      if (response["status"]) {
        InwardModelData? inwardModelData = InwardModelData.fromJson(response);
        if (response != null) {
          emit(state.copyWith(
              inwardModelVar: inwardModelData,
              inwardListData: inwardModelData.data));
        } else {}
      }
    } else {
      Fluttertoast.showToast(msg: "something Went wrong");
    }
  }

  onSelectFilterDate(String? value) {
    List<InwardData>? inwardListData = [];
    state.inwardModelVar!.data!.forEach((element) {
      if (value == element.poDate) {
        inwardListData.add(element);
      }
    });

    emit(state.copyWith(
      inwardListData: inwardListData,
    ));
  }

  getProgressBar(bool verData) {
    emit(state.copyWith(isProcessing: verData));
  }


  Future<void> getUserProfile() async {
    emit(state.copyWith(userProfileDataV: null));

    Map<String, dynamic>? response = await APIHelper().getProfileData();

    if (response != null) {
      if (response["status"]) {
        UserProfileData? userProfileData = UserProfileData.fromJson(response);

        if (response != null) {
          emit(state.copyWith(
              userProfileDataV: userProfileData));
        } else {}
      }
    } else {
      Fluttertoast.showToast(msg: "some error");
    }
  }


/*  Future<void> getPartyData() async {
    Map<String, dynamic>? response = await APIHelper().getPartyList();


    if (response!=null) {
      PartyModel? partyModel = PartyModel.fromJson(response);
      emit(state.copyWith(
          partyList:partyModel
          ));
      print("response.toString()");
      print(partyModel.toString());
      print(state.partyList!.data![0].company);
    } else {
      Helper.showToast("Something went wrong...");
      //emit(state.copyWith(partyList: []));
    }
  }*/




/*  Future<void> getStartData(String ? startDate) async {
      emit(state.copyWith(
          startDate:startDate
      ));

  }
  Future<void> getEndData(String ? endDate) async {
    emit(state.copyWith(
        endDate:endDate
    ));

  }


  Future<void> getSupplier(String ? selectSupplierV) async {
    emit(state.copyWith(
        selectSupplier:selectSupplierV
    ));

  }



  Future<void> getItem(String ? item) async {
    emit(state.copyWith(
       selectItem :item
    ));

  }*/
}
