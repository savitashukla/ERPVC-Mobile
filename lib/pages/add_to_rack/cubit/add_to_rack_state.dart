part of 'add_to_rack_cubit.dart';

class AddToRackState extends Equatable {
  final bool? isProcessing;
  final bool? isProcessingVar;


  List<Itemslist>? rackItemList;
  late final bool isAddRackVisible;
  final int isAddRackCount;
  RackList? rackList;
  RackData? selectRackData;
  List<Map<String, dynamic>>? selectedRackItem;
  final List<Map<String, dynamic>>? inputDataList;
  final List<Map<String, dynamic>>? inputDataListVar;
  final List<Map<String, dynamic>>? inputDataListAddMoreItem;
  final List<Map<String, dynamic>>? inputDataListAddMoreItemVar;
  final Map<String, dynamic>? mapDataMain;
  final Map<String, dynamic>? totalReceiveQnt;

  AddToRackState(
      {
        this.inputDataListAddMoreItem,
        this.inputDataListAddMoreItemVar,
      this.selectedRackItem,
      this.inputDataList,
      this.inputDataListVar,
        required  this.isProcessingVar,
      this.mapDataMain,
      required this.isProcessing,
       this.totalReceiveQnt,
      this.selectRackData,
      this.rackList,
      this.rackItemList,
      required this.isAddRackVisible,
      required this.isAddRackCount});

  AddToRackState.init(
      {
        this.inputDataListAddMoreItem,
        this.inputDataListAddMoreItemVar,
      this.inputDataList,
      this.inputDataListVar,
      this.mapDataMain,
        required   this.isProcessingVar,
           this.totalReceiveQnt,
      required this.isProcessing,
      this.selectRackData,
      this.rackList,
      this.rackItemList,
      required this.isAddRackVisible,
      required this.isAddRackCount,
      this.selectedRackItem});

  AddToRackState copyWith({
    bool? isProcessing,
    bool? isProcessingVar,
    RackList? rackList,
    List<Itemslist>? rackItemList,
    bool? isAddRackVisible,
    int? isAddRackCount,
    RackData? selectRackData,
    List<Map<String, dynamic>>? selectedRackItem,
    List<Map<String, dynamic>>? inputDataListAddMoreItem,
    List<Map<String, dynamic>>? inputDataListAddMoreItemVar,
    List<Map<String, dynamic>>? inputDataList,
    List<Map<String, dynamic>>? inputDataListVar,
    Map<String, dynamic>? mapDataMain,
    Map<String, dynamic>? totalReceiveQnt,
  }) {
    return AddToRackState(
        isProcessing: isProcessing ?? this.isProcessing,
        isProcessingVar: isProcessingVar ?? this.isProcessingVar,
        inputDataList: inputDataList ?? this.inputDataList,
        inputDataListVar: inputDataListVar ?? this.inputDataListVar,
        mapDataMain: mapDataMain ?? this.mapDataMain,
        rackItemList: rackItemList ?? this.rackItemList,
        totalReceiveQnt: totalReceiveQnt ?? this.totalReceiveQnt,

        inputDataListAddMoreItem: inputDataListAddMoreItem ?? this.inputDataListAddMoreItem,
        inputDataListAddMoreItemVar: inputDataListAddMoreItemVar ?? this.inputDataListAddMoreItemVar,
        rackList: rackList ?? this.rackList,
        isAddRackVisible: isAddRackVisible ?? this.isAddRackVisible,
        isAddRackCount: isAddRackCount ?? this.isAddRackCount,
        selectRackData: selectRackData ?? this.selectRackData,
        selectedRackItem: selectedRackItem ?? this.selectedRackItem);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        inputDataListAddMoreItem,
        inputDataListAddMoreItemVar,
        isProcessing,
    isProcessingVar,
        rackItemList,

        rackList,
        selectRackData,
        inputDataList,
        inputDataListVar,
        mapDataMain,
    totalReceiveQnt,
        selectedRackItem
      ];
}
