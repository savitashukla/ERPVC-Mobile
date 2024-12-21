part of 'inward_create_cubit.dart';

class InwardCreateState/* extends Equatable*/{
  InwardCreateState(
      {this.partyList = const [],
      this.selectedParty,
      this.vendorId,
      this.searchText = "",
      this.invoiceNo = 0,
      this.productQty = 0,
      this.totalPages = 0,
      this.currentPage = 0,
      this.offset = 0,
      this.selectedPage = 1,
      this.productListModel,
      this.addedProducts = const [],
      this.tempraryAddedProducts = const [],
      this.validationStatus = false,
      this.productsListStatus = FormzSubmissionStatus.initial,
      this.createInwardStatus = FormzSubmissionStatus.initial,
      this.addTransporterStatus = FormzSubmissionStatus.initial,
      this.packageTypeStatus = FormzSubmissionStatus.initial,
      this.dateTime,
      this.invoiceDate,
      this.mrirDate,
      this.gr_rrDate,
      this.invoiceNumber = const TextInputData.pure(),
      this.mrirNum = const TextInputData.pure(),
      this.vehicleNo = const TextInputData.pure(),
      this.grrrNo = const TextInputData.pure(),
      this.freightCost = const TextInputData.pure(),
      this.perUnit = const TextInputData.pure(),
      this.inwardNumber = const TextInputData.pure(),
      this.amount = const TextInputData.pure(),
      this.unitNo = const TextInputData.pure(),
      this.batchNumber = const TextInputData.pure(),
      this.selectedItem,
      this.clearFields = false,
      this.cenvatPaper = false,
      this.isEdit = true,
      this.selectedTransporterModel,
      this.transporterModel = const [],
      this.COACheck,
      this.COACheckGate="",
      this.inwardNumberV = 0,
      this.packageCapacity = 0,
      this.packageQuantity = 0,
      this.onReceivedQuantity = 0,
      this.onShortQuantity = 0,
      this.packageTypeList = const [],
      this.selectedDoc,
      this.uploadedDocName,
      this.selectedPackageType,
      this.documentData,
      this.inwardCreateSubCubitList = const [],
      this.inwardItemSubCubitList = const [],
      this.attachmentLength = 1,
      this.refreshUi = false,
      this.storeEditPermission = false,
      this.inwardItemsList = const [],
      this.tempInwardItemsList = const [],
      this.onBillQuantity = 0});

  final bool? clearFields;
  final List<PartyData>? partyList;
  final List<DataTransporterModel> transporterModel;
  final PartyData? selectedParty;
  final DataTransporterModel? selectedTransporterModel;
  final String? vendorId;
  final int? invoiceNo;
  final int? inwardNumberV;
  final String searchText;
  final String? dateTime;
  final String? invoiceDate;
  final String? mrirDate;
  final String? gr_rrDate;

  final int productQty;
  final int totalPages;
  final int currentPage;
  final int offset;
  final int selectedPage;
  final bool validationStatus;
  final TextInputData invoiceNumber;
  final TextInputData mrirNum;
  final TextInputData vehicleNo;
  final TextInputData grrrNo;
  final TextInputData freightCost;
  final TextInputData perUnit;
  final TextInputData inwardNumber;
  final TextInputData amount;
  final TextInputData unitNo;
  final TextInputData batchNumber;
  final FormzSubmissionStatus? createInwardStatus;
  final List<Map<String, dynamic>> addedProducts;
  final List<Map<String, dynamic>> tempraryAddedProducts;
  final FormzSubmissionStatus productsListStatus;
  final ProductListModel? productListModel;
  final ProductData? selectedItem;
  final bool cenvatPaper;
  final bool isEdit;
  final bool storeEditPermission;
  final bool? COACheck;
  final int packageQuantity;
  final int packageCapacity;
  final int onBillQuantity;
  final int onReceivedQuantity;
  final int onShortQuantity;
  final List<PackageTypeList> packageTypeList;
  final DocumentData? selectedDoc;
  final String? uploadedDocName;
  final List<DocumentData>? documentData;
  final PackageTypeList? selectedPackageType;
  final FormzSubmissionStatus packageTypeStatus;
  final FormzSubmissionStatus? addTransporterStatus;
  final List<InwardCreateSubCubit> inwardCreateSubCubitList;
  final List<InwardItemSubCubit> inwardItemSubCubitList;
  final int attachmentLength;
  final String COACheckGate;
  final bool refreshUi;
  final List<Itemslist>? inwardItemsList;
  final List<Itemslist>? tempInwardItemsList;

  InwardCreateState copyWith(
      {int? invoiceNo,
      int? inwardNumberV,
      bool? clearFields,
      String? searchText,
      TextInputData? invoiceNumber,
      TextInputData? mrirNum,
      TextInputData? vehicleNo,
      TextInputData? grrrNo,
      TextInputData? freightCost,
      TextInputData? perUnit,
      TextInputData? inwardNumber,
      TextInputData? amount,
      TextInputData? unitNo,
      String? invoiceDate,
      String? mrirDate,
      String? vendorId,
      String? gr_rrDate,
      String? dateTime,
      List<PartyData>? partyList,
      int? productQty,
      int? totalPages,
      int? currentPage,
      int? offset,
      int? selectedPage,
      List<Map<String, dynamic>>? addedProducts,
      List<Map<String, dynamic>>? tempraryAddedProducts,
      FormzSubmissionStatus? productsListStatus,
      FormzSubmissionStatus? createInwardStatus,
      ProductListModel? productListModel,
      PartyData? selectedParty,
      bool? validationStatus,
      bool? cenvatPaper,
      bool? isEdit,
      bool? storeEditPermission,
      FormzSubmissionStatus? addTransporterStatus,
      FormzSubmissionStatus? packageTypeStatus,
      bool? COACheck,
        String? COACheckGate,
      TextInputData? batchNumber,
      DataTransporterModel? selectedTransporterModel,
      List<DataTransporterModel>? transporterModel,
      List<PackageTypeList>? packageTypeList,
      PackageTypeList? selectedPackageType,
      ProductData? selectedItem,
      int? packageQuantity,
      int? packageCapacity,
      int? onBillQuantity,
      int? onReceivedQuantity,
      int? onShortQuantity,
      int? attachmentLength,
      DocumentData? selectedDoc,
      String? uploadedDocName,
      List<DocumentData>? documentData,
      List<InwardCreateSubCubit>? inwardCreateSubCubitList,
      List<InwardItemSubCubit>? inwardItemSubCubitList,
      List<Itemslist>? inwardItemsList,
      List<Itemslist>? tempInwardItemsList,
      bool? refreshUi}) {
    return InwardCreateState(
        clearFields: clearFields ?? this.clearFields,
        dateTime: dateTime ?? this.dateTime,
        invoiceDate: invoiceDate ?? this.invoiceDate,
        mrirDate: mrirDate ?? this.mrirDate,
        vendorId: vendorId ?? this.vendorId,
        gr_rrDate: gr_rrDate ?? this.gr_rrDate,
        invoiceNo: invoiceNo ?? this.invoiceNo,
        inwardNumberV: inwardNumberV ?? this.inwardNumberV,
        partyList: partyList ?? this.partyList,
        addedProducts: addedProducts ?? this.addedProducts,
        tempraryAddedProducts:
            tempraryAddedProducts ?? this.tempraryAddedProducts,
        productQty: productQty ?? this.productQty,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        selectedPage: selectedPage ?? this.selectedPage,
        offset: offset ?? this.offset,
        selectedParty: selectedParty ?? this.selectedParty,
        productsListStatus: productsListStatus ?? this.productsListStatus,
        searchText: searchText ?? this.searchText,
        productListModel: productListModel ?? this.productListModel,
        invoiceNumber: invoiceNumber ?? this.invoiceNumber,
        mrirNum: mrirNum ?? this.mrirNum,
        vehicleNo: vehicleNo ?? this.vehicleNo,
        grrrNo: grrrNo ?? this.grrrNo,
        freightCost: freightCost ?? this.freightCost,
        perUnit: perUnit ?? this.perUnit,
        validationStatus: validationStatus ?? this.validationStatus,
        selectedItem: selectedItem ?? this.selectedItem,
        inwardNumber: inwardNumber ?? this.inwardNumber,
        amount: amount ?? this.amount,
        unitNo: unitNo ?? this.unitNo,
        cenvatPaper: cenvatPaper ?? this.cenvatPaper,
        isEdit: isEdit ?? this.isEdit,
        transporterModel: transporterModel ?? this.transporterModel,
        batchNumber: batchNumber ?? this.batchNumber,
        COACheck: COACheck ?? this.COACheck,
        addTransporterStatus: addTransporterStatus ?? this.addTransporterStatus,
        COACheckGate: COACheckGate ?? this.COACheckGate,
        selectedTransporterModel:
            selectedTransporterModel ?? this.selectedTransporterModel,
        createInwardStatus: createInwardStatus ?? this.createInwardStatus,
        packageQuantity: packageQuantity ?? this.packageQuantity,
        packageCapacity: packageCapacity ?? this.packageCapacity,
        onBillQuantity: onBillQuantity ?? this.onBillQuantity,
        onShortQuantity: onShortQuantity ?? this.onShortQuantity,
        onReceivedQuantity: onReceivedQuantity ?? this.onReceivedQuantity,
        packageTypeList: packageTypeList ?? this.packageTypeList,
        selectedPackageType: selectedPackageType ?? this.selectedPackageType,
        packageTypeStatus: packageTypeStatus ?? this.packageTypeStatus,
        selectedDoc: selectedDoc ?? this.selectedDoc,
        uploadedDocName: uploadedDocName ?? this.uploadedDocName,
        documentData: documentData ?? this.documentData,
        attachmentLength: attachmentLength ?? this.attachmentLength,
        inwardCreateSubCubitList:
            inwardCreateSubCubitList ?? this.inwardCreateSubCubitList,
        inwardItemSubCubitList:
            inwardItemSubCubitList ?? this.inwardItemSubCubitList,
        inwardItemsList: inwardItemsList ?? this.inwardItemsList,
        tempInwardItemsList: tempInwardItemsList ?? this.tempInwardItemsList,
        refreshUi: refreshUi ?? this.refreshUi,
        storeEditPermission: storeEditPermission ?? this.storeEditPermission);
  }

  @override
  List<Object?> get props => [
        clearFields,
        dateTime,
        mrirDate,
        invoiceDate,
        gr_rrDate,
        invoiceNo,
        partyList,
        selectedParty,
        productQty,
        productsListStatus,
        productListModel,
        searchText,
        addedProducts,
        selectedPage,
        invoiceNumber,
        mrirNum,
        validationStatus,
        createInwardStatus,
        vehicleNo,
        grrrNo,
        vendorId,
        totalPages,
        currentPage,
        offset,
        selectedItem,
        freightCost,
        perUnit,
        inwardNumber,
        amount,
        unitNo,
        cenvatPaper,
        batchNumber,
        tempraryAddedProducts,
        transporterModel,
        selectedTransporterModel,
        COACheck,
        isEdit,
        addTransporterStatus,
        COACheck,
        COACheckGate,
        inwardNumberV,
        isEdit,
        packageQuantity,
        packageCapacity,
        onBillQuantity,
        onReceivedQuantity,
        onShortQuantity,
        packageTypeList,
        selectedPackageType,
        packageTypeStatus,
        selectedDoc,
        uploadedDocName,
        inwardCreateSubCubitList,
        documentData,
        attachmentLength,
        inwardItemSubCubitList,
        inwardItemsList,
        tempInwardItemsList,
        refreshUi,
        storeEditPermission
      ];
}
