part of 'inventory_cubit.dart';

class InventoryState extends Equatable {
  final bool isProcessing;

  InventoryList? inventoryList;
  FormzSubmissionStatus? status;

  var currentPage;
  var totalLimit;
  var offset;
  List<DataInventory>? dataInventoryListArray;

  InventoryState(
      {required this.isProcessing,
      this.dataInventoryListArray,
      required this.currentPage,
      required this.offset,
      this.totalLimit,
      this.inventoryList,
      this.status});

  InventoryState.init(
      {required this.isProcessing,
      this.dataInventoryListArray,
      this.inventoryList,
      this.status,
      required this.offset,
      required this.currentPage,
      this.totalLimit});

  InventoryState copyWith({
    bool? isProcessing,
    InventoryList? inventoryList,
    FormzSubmissionStatus? status,
    var currentPage,
    var totalLimit,
    var offset,
    List<DataInventory>? dataInventoryListArray,
  }) {
    return InventoryState(
      isProcessing: isProcessing ?? this.isProcessing,
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      totalLimit: totalLimit ?? this.totalLimit,
      offset: offset ?? this.offset,
      dataInventoryListArray:
          dataInventoryListArray ?? this.dataInventoryListArray,
      inventoryList: inventoryList ?? this.inventoryList,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        isProcessing,
        inventoryList,
        status,
        totalLimit,
        currentPage,
        offset,
        dataInventoryListArray
      ];
}
