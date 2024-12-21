import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:erpvc/helper/helper.dart';
import 'package:erpvc/helper/route_arguments.dart';
import 'package:erpvc/model/item_data_model.dart';
import 'package:erpvc/model/party_name_model.dart';
import 'package:erpvc/model/product_list_model.dart';
import 'package:erpvc/model/transporter_model.dart';
import 'package:erpvc/pages/create_inward/cubit/inward_item_subcubit/inward_item_sub_cubit.dart';
import 'package:erpvc/pages/create_inward/cubit/sub_cubit/inward_create_sub_cubit.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:erpvc/repos/inventory_repo.dart';
import 'package:erpvc/repos/user_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

import '../../../api_hleper/api_helper.dart';
import '../../../model/add_package_model.dart';
import '../../../model/attached_document_type_model.dart';
import '../../../model/inward_deatils_model_data.dart';
import '../../../model/text_input.dart';
import '../elements/create_inward_page1.dart';

part 'inward_create_state.dart';

class InwardCreateCubit extends Cubit<InwardCreateState> {
  InwardCreateCubit(
      {this.inventoryRepo,
      this.authenticationRepository,
      this.routeArguments,
      this.userRepository})
      : super(
          InwardCreateState(
              dateTime: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
              //mrirDate: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
              gr_rrDate: DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()),
              invoiceDate:
                  DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())),
        ) {
    getInvoiceNo();
    getPartyData();
    getAttachmentTypeList();
  }

  onClearTap() {
    emit(state.copyWith(clearFields: !state.clearFields!));
  }

  final InventoryRepo? inventoryRepo;
  final AuthenticationRepository? authenticationRepository;
  final RouteArguments? routeArguments;
  final UserRepository? userRepository;



  onDateChange({String? dateTime}) {
    emit(state.copyWith(dateTime: dateTime.toString()));
  }
  getPermission()async{
      bool isEdit=await Helper().getDataEntryEditDPer();
      emit(state.copyWith(storeEditPermission:isEdit ));
  }

  onInvoiceDateChange({String? dateTime}) {
    emit(state.copyWith(invoiceDate: dateTime.toString()));
  }

  onPODateChange({String? dateTime}) {
    emit(state.copyWith(mrirDate: dateTime.toString()));
  }

  setCOACheck({bool? value}) {
    emit(state.copyWith(COACheck: value));
  }

  setCOACheckGate({String? value}) {
    emit(state.copyWith(COACheckGate: value));
  }

  onGRRRDateChange({String? dateTime}) {
    emit(state.copyWith(gr_rrDate: dateTime.toString()));
  }

  onSearch({String? value}) {
    emit(state.copyWith(searchText: value));
  }

  onEnterPackageQuantity({int? value}) {
    emit(state.copyWith(packageQuantity: value));
  }

  onEnterPackageCapacity({int? value}) {
    emit(state.copyWith(packageCapacity: value));
  }

  onEnterOnBillCapacity({int? quantity, int? capacity}) {
    if (quantity != null && capacity != null) {
      emit(state.copyWith(
          onBillQuantity: quantity * capacity,
          onReceivedQuantity: quantity * capacity));
    }
  }

  onEnterReceivedQuantity({int? quantity}) {
    if (quantity != null && quantity <= state.onBillQuantity) {
      emit(state.copyWith(
        onShortQuantity: state.onBillQuantity - quantity,
      ));
    }
  }

  onPartyChange({PartyData? selectedParty}) {
    emit(state.copyWith(
        selectedParty: selectedParty, vendorId: selectedParty!.userid));
  }

  onPackegeTypeChange({PackageTypeList? selectedPackageType}) {
    emit(state.copyWith(
        selectedPackageType: selectedPackageType,
        vendorId: selectedPackageType!.id!));
  }

  onChangeAttachedDoc(DocumentData? selectedDoc) {
    emit(state.copyWith(selectedDoc: selectedDoc));
  }

  onTransporterModel({DataTransporterModel? selectedParty}) {
    emit(state.copyWith(selectedTransporterModel: selectedParty));
  }

  void onInvoiceNoChanged({String? value}) {
    emit(state.copyWith(
        invoiceNumber: TextInputData.dirty(value: value.toString()),
        validationStatus: Formz.validate([
          TextInputData.dirty(value: value.toString()),
          state.vehicleNo,
          state.grrrNo,
          state.freightCost,
          state.perUnit,
          state.amount,
          state.unitNo,

          if(userRepository!.user!.data!.role == "Storekeeper") state.mrirNum

        ])));
  }



  void onVehicleNumberChanged({String? value}) {
    emit(state.copyWith(
        vehicleNo: TextInputData.dirty(value: value.toString()),
        validationStatus: Formz.validate([
          TextInputData.dirty(value: value.toString()),
          state.invoiceNumber,
          state.grrrNo,
          state.freightCost,
          state.perUnit,
          state.amount,
          state.unitNo,
          if(userRepository!.user!.data!.role == "Storekeeper") state.mrirNum
        ])));
  }

  void onamountNumberChanged({String? value}) {
    emit(state.copyWith(
        amount: TextInputData.dirty(value: value.toString()),
        validationStatus: Formz.validate([
          TextInputData.dirty(value: value.toString()),
          state.invoiceNumber,
          state.grrrNo,
          state.freightCost,
          state.perUnit,
          state.vehicleNo,
          state.unitNo,
          if(userRepository!.user!.data!.role == "Storekeeper") state.mrirNum
        ])));
  }

  void onUnitNumberChanged({String? value}) {
    emit(state.copyWith(
        unitNo: TextInputData.dirty(value: value.toString()),
        validationStatus: Formz.validate([
          TextInputData.dirty(value: value.toString()),
          state.invoiceNumber,
          state.grrrNo,
          state.freightCost,
          state.perUnit,
          state.vehicleNo,
          state.amount,
          if(userRepository!.user!.data!.role == "Storekeeper") state.mrirNum
        ])));
  }

  void onFreightCostChanged({String? value}) {
    emit(state.copyWith(
        freightCost: TextInputData.dirty(value: value.toString()),
        validationStatus: Formz.validate([
          TextInputData.dirty(value: value.toString()),
          state.invoiceNumber,
          state.grrrNo,
          state.unitNo,
          state.perUnit,
          state.vehicleNo,
          state.amount,
          if(userRepository!.user!.data!.role == "Storekeeper") state.mrirNum
        ])));
  }

  void onperUnitChanged({String? value}) {
    emit(state.copyWith(
        perUnit: TextInputData.dirty(value: value.toString()),
        validationStatus: Formz.validate([
          TextInputData.dirty(value: value.toString()),
          state.invoiceNumber,
          state.grrrNo,
          state.unitNo,
          state.freightCost,
          state.vehicleNo,
          state.amount,
          if(userRepository!.user!.data!.role == "Storekeeper") state.mrirNum
        ])));
  }
  void onMrirChanged({String? value}) {
    if(routeArguments!.fromScreen=="Edit Entry"){
      emit(state.copyWith(
          mrirNum: TextInputData.dirty(value: value.toString()),
          validationStatus: Formz.validate([
            TextInputData.dirty(value: value.toString()),
            state.invoiceNumber,
            state.grrrNo,
            state.unitNo,
            state.freightCost,
            state.vehicleNo,
            state.amount,
            state.perUnit,

          ])));
    }
  }

  void onGrrrNumberChanged({String? value}) {
    emit(state.copyWith(
        grrrNo: TextInputData.dirty(value: value.toString()),
        validationStatus: Formz.validate([
          TextInputData.dirty(value: value.toString()),
          state.vehicleNo,
          state.invoiceNumber,
          state.freightCost,
          state.perUnit,
          state.amount,
          state.unitNo,
          if(userRepository!.user!.data!.role == "Storekeeper") state.mrirNum
        ])));
  }

  /* void onBatchNumberChanged({String? value}) {
    emit(state.copyWith(
        batchNumber: TextInputData.dirty(value: value.toString()),
        validationStatus: Formz.validate([
          TextInputData.dirty(value: value.toString()),

          state.vehicleNo,
          state.invoiceNumber,
          state.freightCost,
          state.perUnit,
          state.amount,
          state.unitNo,
          state.grrrNo,
          //state.inwardNumber
        ])));
  }*/

  onUpdateProductQty({String? type}) {
    if (type == "sub") {
      if (state.productQty > 0) {
        emit(state.copyWith(productQty: state.productQty - 1));
      }
    } else {
      emit(state.copyWith(productQty: state.productQty + 1));
    }
  }

  onUpdateProductList(Itemslist data, {bool? isEdit, int? index}) {
    print("temp product list ${state.tempInwardItemsList!.length}");
    List<Itemslist>? inwardItemsList = [];
    inwardItemsList.addAll(state.tempInwardItemsList!);
    if (isEdit!) {
      print("item index $index");
      inwardItemsList.removeAt(index!);
      inwardItemsList.insert(index, data);
    } else {
      inwardItemsList.add(data);
    }
    print("state product list1 ${inwardItemsList.length}");
    emit(state.copyWith(tempInwardItemsList: inwardItemsList));
  }

  onUpdateProducts({
    List<Itemslist>? itemslist,
  }) {
    List<InwardItemSubCubit>? inwardItemSubCubitList = [];
    List<Itemslist>? inwardItemsList = [];
    inwardItemsList.addAll(itemslist!);
    emit(state.copyWith(tempInwardItemsList: inwardItemsList));
    inwardItemsList!.forEach((element) {
      inwardItemSubCubitList.add(InwardItemSubCubit(itemslist: element));
    });
    emit(state.copyWith(inwardItemSubCubitList: inwardItemSubCubitList));
/*    List<Map<String, dynamic>>? listData = [];
    listData.addAll(state.addedProducts);
    data.forEach((element) {
      listData.add(element);
    });
    emit(state.copyWith(addedProducts: listData));
    print("state products repeat ${state.addedProducts}");*/
  }

  removeItemFromList(int? index) {
    List<InwardItemSubCubit>? inwardItemSubCubitList = [];
    List<Itemslist>? inwardItemsList = [];
    inwardItemSubCubitList.addAll(state.inwardItemSubCubitList);
    inwardItemsList.addAll(state.tempInwardItemsList!);
    inwardItemSubCubitList.removeAt(index!);
    inwardItemsList.removeAt(index!);
    emit(state.copyWith(inwardItemSubCubitList: inwardItemSubCubitList,tempInwardItemsList:inwardItemsList,inwardItemsList: inwardItemsList));
  }

  onEditdata(
    List<Itemslist> data,
  ) {
    print("itemslistData ${jsonEncode(data)}");
    List<InwardItemSubCubit>? inwardItemSubCubitList = [];
    data.forEach((element) {
      inwardItemSubCubitList.add(InwardItemSubCubit(itemslist: element));
      print("on edit data ${jsonEncode(element)}");
    });
    emit(state.copyWith(
        inwardItemsList: data,
        tempInwardItemsList: data,
        inwardItemSubCubitList: inwardItemSubCubitList));
     print("state products repeat ${state.inwardItemSubCubitList}");
  }

  onResetUi() {
    emit(state.copyWith(refreshUi: !state.refreshUi));
  }

  GetSupplierData({String? id, String? partyName}) {
    print("data=>  $id$partyName");
    PartyData? supplierData = PartyData(company: partyName, userid: id);
    emit(state.copyWith(selectedParty: supplierData));
  }

  resetList() {
    emit(state.copyWith(tempInwardItemsList: [],));
  }

  onChangePage({int? page}) {
    emit(state.copyWith(selectedPage: page));
  }

  onSelectProduct({ProductData? item}) {
    emit(state.copyWith(
      selectedItem: item,
    ));
  }

  onChangeCenvatPaper(bool value) {
    emit(state.copyWith(cenvatPaper: value));
  }

  onChangeIsEdit(bool value) {
    emit(state.copyWith(isEdit: value));
  }

  Future<void> getTransporterList() async {
    var data = {};
    data["limit"] = "30";
    Map<String, dynamic>? response =
        await APIHelper().getTransporterList(data: data);

    if (response != null) {
      TransporterModel? transporterModel = TransporterModel.fromJson(response);
      if (response != null) {
        if (transporterModel.data!.isNotEmpty) {
          emit(state.copyWith(
              transporterModel: transporterModel.data,
              selectedTransporterModel: transporterModel.data!.first));
        }
        if (routeArguments!.fromScreen == "Edit Entry") {
          transporterModel.data!.forEach((element) {
            if (element.id ==
                routeArguments!.inwardDetailsModelData!.data!.transporter) {
              emit(state.copyWith(selectedTransporterModel: element));
            }
          });
        }
      } else {}
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<bool> addTransporter({Map<String, dynamic>? transporterData}) async {
    emit(
        state.copyWith(addTransporterStatus: FormzSubmissionStatus.inProgress));
    Map<String, dynamic>? data = {};
    data['t_name'] = transporterData!["name"];
    data['t_address'] = transporterData["address"];
    data['t_number'] = transporterData["number"];
    data['city'] = transporterData["city"];
    data['state'] = transporterData["state"];
    data['zip'] = transporterData["zip_code"];
    data['country'] = transporterData["country"];
    Map<String, dynamic>? response = await APIHelper().addTransporter(data);
    emit(state.copyWith(transporterModel: []));
    if (response != null) {
      emit(state.copyWith(addTransporterStatus: FormzSubmissionStatus.success));
      navigatorKey.currentState!.pop();
      print("trasporter list data ${state.transporterModel.last.tName}");
    } else {
      emit(state.copyWith(addTransporterStatus: FormzSubmissionStatus.failure));
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    return true;
  }

  Future<void> getPackageTypeList({bool? isEdit, String? packageId}) async {
/*    var data={};
    data["limit"]="30";*/
    Map<String, dynamic>? response = await APIHelper().getPackageTypeList();

    if (response != null) {
      AddPackegeTypeModel? addPackegeTypeModel =
          AddPackegeTypeModel.fromJson(response);
      if (response != null) {
        emit(state.copyWith(
            packageTypeList: addPackegeTypeModel.data,
            selectedPackageType: addPackegeTypeModel.data!.first));

        if (isEdit!) {
          addPackegeTypeModel.data!.forEach((element) {
            if (packageId == element.id) {
              emit(state.copyWith(selectedPackageType: element));
            }
          });
        }
        /*      if(routeArguments!.fromScreen=="Edit Entry"){
          addPackegeTypeModel.data!.forEach((element) {
            if(element.id==routeArguments!.inwardDetailsModelData!.data!.transporter){
              emit(state.copyWith(selectedPackageType:element ));
            }
          });
        }*/
      } else {}
    }
    else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<bool> addPackageType({Map<String, dynamic>? packageTypeData}) async {
    emit(state.copyWith(packageTypeStatus: FormzSubmissionStatus.inProgress));

    Map<String, dynamic>? data = {};
    data['name'] = packageTypeData!["name"];

    Map<String, dynamic>? response = await APIHelper().addPackageType(data);
    emit(state.copyWith(transporterModel: []));
    if (response != null) {
      emit(state.copyWith(packageTypeStatus: FormzSubmissionStatus.success));
      navigatorKey.currentState!.pop();

      print("package type list data ${state.transporterModel.last.tName}");
    } else {
      emit(state.copyWith(packageTypeStatus: FormzSubmissionStatus.failure));
      Fluttertoast.showToast(msg: "Something went wrong");
    }
    return true;
  }

  getInvoiceNo() async {
    Response response = await inventoryRepo!.getInwatdNumber();
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["data"]["inwardno"];
      emit(state.copyWith(invoiceNo: int.parse(data.toString())));
      if (routeArguments!=null&&routeArguments!.fromScreen == "Edit Entry") {
        emit(state.copyWith(
            invoiceNo: int.parse(
                routeArguments!.inwardDetailsModelData!.data!.inwardNo!)));
      }
    } else if (response.statusCode == 403) {
      authenticationRepository!.controller
          .add(AuthenticationStatus.unauthenticated);
    } else {
      Helper.showToast("Something went wrong...");
      emit(state.copyWith(invoiceNo: 0));
    }
  }

  Future<bool> onUpadteOffset(String? type) async {
    if (type == "inc") {
      emit(state.copyWith(offset: state.offset + 10));
    } else {
      emit(state.copyWith(offset: state.offset - 10));
    }
    return Future.value(true);
  }

  Future getProductList(
      {String? type,
      String? barcodeScanNumber,
      String? searchText,
      String? productId,
      bool? isEdit}) async {
    emit(state.copyWith(productsListStatus: FormzSubmissionStatus.inProgress));
    Map<String, dynamic> map = {};
    map["barcode_no"] = barcodeScanNumber ?? "";
    print("mapData  $map");
    Response response = await inventoryRepo!.searchProduct(data: map);
    if (response.statusCode == 200) {
      ProductListModel productListModel =
          ProductListModel.fromJson(jsonDecode(response.body));
      emit(state.copyWith(
        productsListStatus: FormzSubmissionStatus.success,
        productListModel: productListModel,
        selectedItem: productListModel.data!.first,
      ));
      if (isEdit!) {
        productListModel!.data!.forEach((element) {
          if (productId == element.id) {
            emit(state.copyWith(
              selectedItem: element,
            ));
          }
        });
      }
    }
    else if (response.statusCode == 403) {
      authenticationRepository!.controller
          .add(AuthenticationStatus.unauthenticated);
    }
    else {
      emit(state.copyWith(productsListStatus: FormzSubmissionStatus.failure));
      Helper.showToast("Something went wrong...");
    }
  }

  Future createInward() async {
    emit(state.copyWith(createInwardStatus: FormzSubmissionStatus.inProgress));
    List<Itemslist> itemList = [];
    state.tempInwardItemsList!.forEach((element) {
      itemList.add(element);
      print("item data ${itemList}");
    });
    Map<String, String> map = {};
    if (routeArguments!.fromScreen == "Edit Entry") {
      map["data_entry_id"] = routeArguments!.inwardDetailsModelData!.data!.id!;
    }
    map["mrir_no"] = state.mrirNum.value;
    map["mrir_date"] = state.mrirDate ?? "";
    map["batch_number"] = state.batchNumber.value;
    map["coa_option"] = state.COACheckGate;
    map["inward_no"] = state.invoiceNo.toString();
    map["inward_date"] = state.dateTime!;
    map["vendor_id"] = state.vendorId!;
    map["invoice_no"] = state.invoiceNumber.value;
    map["invoice_date"] = state.invoiceDate!;
    map["amount"] = state.amount.value;
    map["unit_no"] = state.unitNo.value;
    map["freight_cost"] = state.freightCost.value;
    map["per_unit"] = state.perUnit.value;
    map["transporter"] = state.selectedTransporterModel!.id!;
    map["vehicle_no"] = state.vehicleNo.value;
    map["gr_rr_no"] = state.grrrNo.value;
    map["gt_rr_date"] = state.gr_rrDate!;
    map["cenvat_paper"] = state.cenvatPaper ? "1" : "0";
    map["item_data"] = jsonEncode(itemList);
    List<DocumentData> documentDataList = [];
    Map<String, String> filePath = {};
    state.inwardCreateSubCubitList.forEach((element) {
      if (element.state.selectedDoc != null) {
        documentDataList.add(DocumentData(
            id: element.state.selectedDoc!.id,
            name: element.state.selectedDoc!.name,
            fileName: element.state.uploadedDocName));
        if (element.state.uploadedDocPath != null) {
          filePath[element.state.uploadedDocPath.toString()] =
              element.state.selectedDoc!.id.toString();
        }
      }
    });
    print("filePath $filePath");
    map["attachment_type"] = jsonEncode(documentDataList);
    print("mapData  $map");
    var response = await inventoryRepo!.createInward(
        data: map, type: routeArguments!.fromScreen, fileData: filePath);
    if (response.statusCode == 200) {
      //  ProductListModel productListModel=ProductListModel.fromJson(jsonDecode(response.body));
      emit(state.copyWith(createInwardStatus: FormzSubmissionStatus.success));
      navigatorKey.currentState!
          .pushNamedAndRemoveUntil("/DashboardPage", (route) => false);
    }
    else if (response.statusCode == 403) {
      authenticationRepository!.controller
          .add(AuthenticationStatus.unauthenticated);
    }
    else {
      emit(state.copyWith(createInwardStatus: FormzSubmissionStatus.failure));
      Helper.showToast("Something went wrong...");
    }
  }

  getPartyData() async {
    Response response = await inventoryRepo!.getPartyList();
    if (response.statusCode == 200) {
      PartyModel partyModel = PartyModel.fromJson(jsonDecode(response.body));
      emit(state.copyWith(
          selectedParty: partyModel.data![0],
          partyList: partyModel.data,
          vendorId: partyModel.data![0].userid));
      if(routeArguments!=null){
        if (routeArguments!.fromScreen == "Edit Entry") {
          partyModel.data!.forEach((element) {
            if (element.userid ==
                routeArguments!.inwardDetailsModelData!.data!.partyid) {
              emit(state.copyWith(selectedParty: element));
            }
          });
        }
      }

    } else if (response.statusCode == 403) {
      authenticationRepository!.controller
          .add(AuthenticationStatus.unauthenticated);
    } else {
      Helper.showToast("Something went wrong...");
      emit(state.copyWith(partyList: []));
    }
  }

  getAttachmentTypeList() async {
    var response = await inventoryRepo!
        .readJsonData(path: "assets/json_file/attachment_type.json");
    DocumentTypeModel documentTypeModel = DocumentTypeModel.fromJson(response);
    emit(state.copyWith(documentData: documentTypeModel.data));
    List<InwardCreateSubCubit> inwardCreateSubCubitList = [];
    List<DocumentData>? documentData = [];
    if(routeArguments!=null){
      if (routeArguments!.fromScreen == "Edit Entry") {
        routeArguments!.inwardDetailsModelData!.data!.attachmentlist!
            .forEach((element) {
          state.documentData!.forEach((element1) {
            if (element1.id == element.typeId) {
              inwardCreateSubCubitList.add(InwardCreateSubCubit(
                  uploadedDocName: element.attachment, selectedDoc: element1));
            }
          });
        });
      }
    }
    emit(state.copyWith(
      inwardCreateSubCubitList: inwardCreateSubCubitList,
    ));
  }

  addNewDoc(String? type, {int? index}) {
    List<InwardCreateSubCubit> inwardCreateSubCubitList = [];
    inwardCreateSubCubitList.addAll(state.inwardCreateSubCubitList);
    if (type == "add") {
      inwardCreateSubCubitList.add(InwardCreateSubCubit());
    } else {
      print("inward Cubit list ${state.inwardCreateSubCubitList.length}");
      print("inward Cubit list ${index}");
      inwardCreateSubCubitList.removeAt(index!);
    }
    emit(state.copyWith(inwardCreateSubCubitList: inwardCreateSubCubitList));
  }
}
