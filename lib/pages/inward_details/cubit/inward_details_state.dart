import 'package:equatable/equatable.dart';

import '../../../model/inward_deatils_model_data.dart';
import '../../../model/inword_model.dart';
import '../../../model/rack_list.dart';
import 'inward_details_state.dart';

class InwardDetailsState extends Equatable {
  final bool isProcessing;

  InwardDeatilsModelData? inwardDetailsModelVar;

  final bool isAddRackVisible;
  final int isAddRackCount;
  RackList? rackList;
  final bool isProcessingVar;

  InwardDetailsState(
      {required this.isProcessingVar,
      required this.isProcessing,
      this.rackList,
      this.inwardDetailsModelVar,
      required this.isAddRackVisible,
      required this.isAddRackCount});

  InwardDetailsState.init(
      {required this.isProcessingVar,
      required this.isProcessing,
      this.inwardDetailsModelVar,
      this.rackList,
      required this.isAddRackVisible,
      required this.isAddRackCount});

  InwardDetailsState copyWith({
    bool? isProcessing,
    InwardModelData? inwardModelVar,
    InwardDeatilsModelData? inwardDetailsModelVar,
    RackList? rackList,
    bool? isAddRackVisible,
    int? isAddRackCount,
    bool? isProcessingVar,
  }) {
    return InwardDetailsState(
        isProcessing: isProcessing ?? this.isProcessing,
        inwardDetailsModelVar:
            inwardDetailsModelVar ?? this.inwardDetailsModelVar,
        rackList: rackList ?? this.rackList,
        isAddRackVisible: isAddRackVisible ?? this.isAddRackVisible,
        isProcessingVar: isProcessingVar ?? this.isProcessingVar,
        isAddRackCount: isAddRackCount ?? this.isAddRackCount);
  }

  @override
  // TODO: implement props

  List<Object?> get props => [
        isProcessing,
        inwardDetailsModelVar,
        rackList,
        isAddRackVisible,
        isAddRackCount,
        isProcessingVar
      ];
}
