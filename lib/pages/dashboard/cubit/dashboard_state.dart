import 'package:equatable/equatable.dart';

import '../../../model/inward_deatils_model_data.dart';
import '../../../model/inword_model.dart';
import '../../../model/party_name_model.dart';
import '../../../model/user_profile_data.dart';
/*
class DashboardInitial extends Equatable {
  @override
  List<Object> get props => [];
}*/

class DashboardState extends Equatable {
  final bool isProcessing;
  final String? filterDate;
  final List<InwardData>? inwardListData;
  InwardModelData? inwardModelVar;
  InwardDeatilsModelData? inwardDetailsModelVar;
  UserProfileData? userProfileDataV;
  final int totalPages;

  PartyModel? partyList;

  final String? startDate;
  final String? endDate;
  final String? selectSupplier;
  final String? selectItem;



  DashboardState(
      {required this.isProcessing,
      this.inwardModelVar,
      this.inwardListData = const [],
      this.filterDate,
      this.userProfileDataV,
      this.totalPages = 0,
        this.partyList,
        this.endDate,
        this.startDate,
        this.selectItem,
        this.selectSupplier,

      this.inwardDetailsModelVar});

  DashboardState.init(
      {required this.isProcessing,
      this.inwardModelVar,
      this.filterDate,
      this.userProfileDataV,
      this.inwardListData = const [],
      this.totalPages = 0,
        this.partyList,
        this.endDate,
        this.startDate,
        this.selectItem,
        this.selectSupplier,
      this.inwardDetailsModelVar});

  DashboardState copyWith(
      {bool? isProcessing,
      InwardModelData? inwardModelVar,
      String? filterDate,
      List<InwardData>? inwardListData,
      UserProfileData? userProfileDataV,
      InwardDeatilsModelData? inwardDetailsModelVar,
        PartyModel? partyList,
         String? startDate,
         String? endDate,
         String? selectSupplier,
         String? selectItem,
      int? totalPages}) {
    return DashboardState(
        isProcessing: isProcessing ?? this.isProcessing,
        inwardModelVar: inwardModelVar ?? this.inwardModelVar,
        inwardDetailsModelVar:
            inwardDetailsModelVar ?? this.inwardDetailsModelVar,
        filterDate: filterDate ?? this.filterDate,
        totalPages: totalPages ?? this.totalPages,
        startDate:startDate??this.startDate,
        partyList:partyList??this.partyList,
        endDate:endDate??this.endDate,
        selectSupplier:selectSupplier??this.selectSupplier,
        selectItem:selectItem??this.selectItem,
        userProfileDataV: userProfileDataV ?? this.userProfileDataV,
        inwardListData: inwardListData ?? this.inwardListData);
  }

  @override
  List<Object?> get props => [
        isProcessing,
        inwardModelVar,
        inwardDetailsModelVar,
        filterDate,
        inwardListData,
        userProfileDataV,
    partyList,
        totalPages
      ];
}
