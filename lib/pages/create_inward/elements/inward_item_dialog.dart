import 'package:cached_network_image/cached_network_image.dart';
import 'package:erpvc/model/product_list_model.dart';
import 'package:erpvc/pages/create_inward/elements/add_package_dialog.dart';
import 'package:erpvc/pages/create_inward/elements/package_dropdown.dart';
import 'package:erpvc/pages/create_inward/elements/party_dropdown.dart';
import 'package:erpvc/pages/create_inward/elements/product_list_dropdown.dart';
import 'package:erpvc/pages/create_inward/elements/unit_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../helper/app_config.dart';
import '../../../helper/helper.dart';
import '../../../helper/route_arguments.dart';
import '../../../model/inward_deatils_model_data.dart';
import '../../../repos/authentication_repository.dart';
import '../cubit/inward_create_cubit.dart';
import 'create_inward_elements.dart';

class InwardItemDialog extends StatefulWidget {
  InwardItemDialog(
      {Key? key,
      this.isEdit = false,
      this.itemslist,
      this.index,
      this.inwardItemsList = const []})
      : super(key: key);
  bool isEdit;
  Itemslist? itemslist;
  int? index;
  final List<Itemslist>? inwardItemsList;

  @override
  _InwardItemDialogState createState() => _InwardItemDialogState();
}

class _InwardItemDialogState extends State<InwardItemDialog> {
  final TextEditingController onBillQuantityController =
      TextEditingController(text: "0");
  final TextEditingController receivedQuantityController =
      TextEditingController(text: "0");
  final TextEditingController shortageQuantityController =
      TextEditingController(text: "0");
  final TextEditingController packageQuantityController =
      TextEditingController(text: "0");
  final TextEditingController packageCapacityController =
      TextEditingController(text: "0");
  final TextEditingController lfController = TextEditingController();
  final TextEditingController poController = TextEditingController();
  TextEditingController? manufacturingDateController = TextEditingController();
  TextEditingController? expiryDateController = TextEditingController();
  TextEditingController? batchNumController = TextEditingController();
  var getGateKeeperPer = true;
  List<Itemslist> inwardItemsList = [];

  @override
  void initState() {
    context.read<InwardCreateCubit>().getPermission();
    context.read<InwardCreateCubit>().setCOACheckGate(value: "");
    inwardItemsList.addAll(widget.inwardItemsList!);
    if (widget.isEdit) {
      print("package type ${widget.itemslist!.itemId}");
      context.read<InwardCreateCubit>().getPackageTypeList(
          isEdit: true, packageId: widget.itemslist!.packageType);
      context
          .read<InwardCreateCubit>()
          .getProductList(isEdit: true, productId: widget.itemslist!.itemId);
    } else {
      context.read<InwardCreateCubit>().getPackageTypeList(isEdit: false);
      context.read<InwardCreateCubit>().getProductList(isEdit: false);
      //  context.read<InwardCreateCubit>().resetList();
    }

    packageQuantityController.addListener(() {
      context.read<InwardCreateCubit>().onEnterOnBillCapacity(
          quantity: int.parse(packageQuantityController.text),
          capacity: int.parse(
            packageCapacityController.text,
          ));
      onBillQuantityController.text =
          context.read<InwardCreateCubit>().state.onBillQuantity.toString();
      receivedQuantityController.text =
          context.read<InwardCreateCubit>().state.onReceivedQuantity.toString();
    });
    packageCapacityController.addListener(() {
      context.read<InwardCreateCubit>().onEnterOnBillCapacity(
          capacity: int.parse(
            packageCapacityController.text,
          ),
          quantity: int.parse(packageQuantityController.text));
      onBillQuantityController.text =
          context.read<InwardCreateCubit>().state.onBillQuantity.toString();
      receivedQuantityController.text =
          context.read<InwardCreateCubit>().state.onReceivedQuantity.toString();
    });

    receivedQuantityController.addListener(() {
      context.read<InwardCreateCubit>().onEnterReceivedQuantity(
          quantity: int.parse(receivedQuantityController.text));
      shortageQuantityController.text =
          context.read<InwardCreateCubit>().state.onShortQuantity.toString();
    });
/*    setState(() {
      packageCapacityController.addListener(() {
        onBillQuantityController.text="${ int.parse(packageCapacityController.text,)* int.parse(packageQuantityController.text,)}";
      });
    });*/
    if (widget.isEdit) {
      lfController.text = widget.itemslist!.lfNo!;
      poController.text = widget.itemslist!.poNo!;
      manufacturingDateController!.text = widget.itemslist!.manufacturingDate!;
      expiryDateController!.text = widget.itemslist!.expiryDate!;
      batchNumController!.text = widget.itemslist!.batchNumber!;
      packageQuantityController.text = widget.itemslist!.packageQuantity!;
      packageCapacityController.text = widget.itemslist!.packageCapacity!;
      onBillQuantityController.text = widget.itemslist!.onBillQty!;
      receivedQuantityController.text = widget.itemslist!.onRecieveQty!;
      shortageQuantityController.text = widget.itemslist!.onShortQty!;
      context
          .read<InwardCreateCubit>()
          .setCOACheckGate(value: widget.itemslist!.coaOption);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InwardCreateCubit, InwardCreateState>(
      builder: (context, state) {
        return state.productsListStatus.isInProgress
            ? SizedBox(
                width: AppConfig(context).appWidth(100),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )))
            : AlertDialog(
                insetPadding: const EdgeInsets.all(10),
                contentPadding: const EdgeInsets.all(0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                content: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConfig(context).appHeight(1)),
                    child: Container(
                      width: AppConfig(context).appWidth(100),
                      padding: EdgeInsets.all(AppConfig(context).appHeight(1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              /* navigatorKey.currentState!
                                  .pop(state.tempInwardItemsList);*/
                              navigatorKey.currentState!.pop(inwardItemsList);
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                  height: AppConfig(context).appHeight(3),
                                  width: AppConfig(context).appHeight(3),
                                  child: Icon(Icons.close)),
                            ),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(1),
                          ),
                          Text(
                            "Item name",
                            style: GoogleFonts.inter(
                                color: AppColors().textColor(0),
                                fontSize: AppConfig(context).appWidth(4),
                                fontWeight: FontWeight.w600),
                          ),
                          ProductListDropdown(
                            partyNameModelList: state.productListModel!.data,
                            selectedParty: state.selectedItem,
                            textEditingController: TextEditingController(),
                            myDateSetter: (value) {
                              context
                                  .read<InwardCreateCubit>()
                                  .onSelectProduct(item: value);
                            },
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(1),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: AppConfig(context).appWidth(40),
                                child: CreateInwardElement().textFieldCommon(
                                    labelTittle: "L/F No.*",
                                    textColor: AppColors().textColor(0),
                                    textEditingController: lfController,
                                    context: context),
                              ),
                              SizedBox(
                                width: AppConfig(context).appWidth(3),
                              ),
                              SizedBox(
                                width: AppConfig(context).appWidth(40),
                                child: CreateInwardElement().textFieldCommon(
                                    labelTittle: "P.O No.*",
                                    textColor: AppColors().textColor(0),
                                    textEditingController: poController,
                                    context: context),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: AppConfig(context).appWidth(40),
                                child: CreateInwardElement().dateFieldCommon(
                                    context: context,
                                    myDateSetter: (DateTime? value) {
                                      manufacturingDateController!.text =
                                          DateFormat('dd-MM-yyyy HH:mm')
                                              .format(value!);
                                    },
                                    textEditingController:
                                        manufacturingDateController,
                                    labelTittle: !state.storeEditPermission
                                        ? "MFG Date"
                                        : "MFG Date *"),
                              ),
                              SizedBox(
                                width: AppConfig(context).appWidth(3),
                              ),
                              SizedBox(
                                width: AppConfig(context).appWidth(40),
                                child: CreateInwardElement().dateFieldCommon(
                                    context: context,
                                    myDateSetter: (DateTime? value) {
                                      expiryDateController!.text =
                                          DateFormat('dd-MM-yyyy HH:mm')
                                              .format(value!);
                                    },
                                    textEditingController: expiryDateController,
                                    labelTittle: !state.storeEditPermission
                                        ? "Expiry Date"
                                        : "Expiry Date *"),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: AppConfig(context).appWidth(40),
                                child: CreateInwardElement().textFieldCommon(
                                    labelTittle: !state.storeEditPermission
                                        ? "Batch Number"
                                        : "Batch Number *",
                                    // isValid: state.invoiceNumber.isNotValid,
                                    textEditingController: batchNumController,
                                    context: context),
                              ),
                              SizedBox(
                                width: AppConfig(context).appWidth(3),
                              ),
                              SizedBox(
                                height: AppConfig(context).appHeight(10),
                                width: AppConfig(context).appWidth(40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      !state.storeEditPermission
                                          ? "COA Option"
                                          : "COA Option *",
                                      style: GoogleFonts.inter(
                                          color: AppColors().textColor(1),
                                          fontSize:
                                              AppConfig(context).appWidth(4),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Container(
                                      width: AppConfig(context).appWidth(40),
                                      height: AppConfig(context).appHeight(5.5),
                                      alignment: Alignment.bottomCenter,
                                      child: getGateKeeperPer
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Yes",
                                                  style: GoogleFonts.inter(
                                                      color: AppColors()
                                                          .blackColor(1),
                                                      fontSize:
                                                          AppConfig(context)
                                                              .appWidth(4),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: AppConfig(context)
                                                      .appWidth(4),
                                                  height: AppConfig(context)
                                                      .appWidth(4),
                                                  child: Radio(
                                                    value: "1",
                                                    groupValue:
                                                        state.COACheckGate,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            AppColors()
                                                                .colorPrimary(
                                                                    1)),
                                                    activeColor: AppColors()
                                                        .colorPrimary(1),
                                                    onChanged: (value) {
                                                      context
                                                          .read<
                                                              InwardCreateCubit>()
                                                          .setCOACheckGate(
                                                              value: "1");
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                  "No",
                                                  style: GoogleFonts.inter(
                                                      color: AppColors()
                                                          .blackColor(1),
                                                      fontSize:
                                                          AppConfig(context)
                                                              .appWidth(4),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: AppConfig(context)
                                                      .appWidth(4),
                                                  height: AppConfig(context)
                                                      .appWidth(4),
                                                  child: Radio(
                                                    value: "0",
                                                    groupValue:
                                                        state.COACheckGate,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            AppColors()
                                                                .colorPrimary(
                                                                    1)),
                                                    activeColor: AppColors()
                                                        .colorPrimary(1),
                                                    onChanged: (value) {
                                                      context
                                                          .read<
                                                              InwardCreateCubit>()
                                                          .setCOACheckGate(
                                                              value: "0");
                                                    },
                                                  ),
                                                )
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Yes",
                                                  style: GoogleFonts.inter(
                                                      color: AppColors()
                                                          .blackColor(1),
                                                      fontSize:
                                                          AppConfig(context)
                                                              .appWidth(4),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: AppConfig(context)
                                                      .appWidth(4),
                                                  height: AppConfig(context)
                                                      .appWidth(4),
                                                  child: Radio(
                                                    value: true,
                                                    groupValue: state.COACheck,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            AppColors()
                                                                .colorPrimary(
                                                                    1)),
                                                    activeColor: AppColors()
                                                        .colorPrimary(1),
                                                    onChanged: (value) {
                                                      context
                                                          .read<
                                                              InwardCreateCubit>()
                                                          .setCOACheck(
                                                              value: true);
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                  "No",
                                                  style: GoogleFonts.inter(
                                                      color: AppColors()
                                                          .blackColor(1),
                                                      fontSize:
                                                          AppConfig(context)
                                                              .appWidth(4),
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: AppConfig(context)
                                                      .appWidth(4),
                                                  height: AppConfig(context)
                                                      .appWidth(4),
                                                  child: Radio(
                                                    value: false,
                                                    groupValue: state.COACheck,
                                                    fillColor: MaterialStateColor
                                                        .resolveWith((states) =>
                                                            AppColors()
                                                                .colorPrimary(
                                                                    1)),
                                                    activeColor: AppColors()
                                                        .colorPrimary(1),
                                                    onChanged: (value) {
                                                      context
                                                          .read<
                                                              InwardCreateCubit>()
                                                          .setCOACheck(
                                                              value: false);
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(1),
                          ),
                          Text(
                            "U/M",
                            style: GoogleFonts.inter(
                                color: AppColors().textColor(0),
                                fontSize: AppConfig(context).appWidth(4),
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "${state.selectedItem!.unit}",
                            style: GoogleFonts.inter(
                                color: AppColors().textColor(0),
                                fontSize: AppConfig(context).appWidth(4),
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            children: [
                              Text(
                                "Package Type",
                                style: GoogleFonts.inter(
                                    color: AppColors().textColor(1),
                                    fontSize: AppConfig(context).appWidth(4),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: AppConfig(context).appWidth(2),
                              ),
                              InkWell(
                                  onTap: () {
                                    addTransporterDialogue(context: context)
                                        .then((value) {
                                      print('returned data $value');
                                      context
                                          .read<InwardCreateCubit>()
                                          .getPackageTypeList(isEdit: false);
                                    });
                                  },
                                  child: Icon(
                                    Icons.add_circle_rounded,
                                    color: AppColors().colorPrimary(1),
                                  ))
                            ],
                          ),
                          PackageDropDown(
                            selectedPackageName: state.selectedPackageType,
                            packageTypeNameList: state.packageTypeList,
                            textEditingController: TextEditingController(),
                            myDateSetter: (value) {
                              context
                                  .read<InwardCreateCubit>()
                                  .onPackegeTypeChange(
                                      selectedPackageType: value);
                            },
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "package Quantity",
                                style: GoogleFonts.inter(
                                    color: AppColors().textColor(1),
                                    fontSize: AppConfig(context).appWidth(4),
                                    fontWeight: FontWeight.w500),
                              ),
                              CreateInwardElement().QuantityAddSubWidget(
                                  context,
                                  controller: packageQuantityController,
                                  onTapAdd: () {
                                if (packageQuantityController.text.isEmpty) {
                                  packageQuantityController.text = "0";
                                }

                                packageQuantityController.text =
                                    (int.parse(packageQuantityController.text) +
                                            1)
                                        .toString();
                              }, onTapSubtract: () {
                                if (packageQuantityController.text.isEmpty) {
                                  packageQuantityController.text = "0";
                                }

                                if (int.parse(packageQuantityController.text) >
                                    0) {
                                  packageQuantityController.text = (int.parse(
                                              packageQuantityController.text) -
                                          1)
                                      .toString();
                                }
                              }),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "package Capacity",
                                style: GoogleFonts.inter(
                                    color: AppColors().textColor(1),
                                    fontSize: AppConfig(context).appWidth(4),
                                    fontWeight: FontWeight.w500),
                              ),
                              CreateInwardElement().QuantityAddSubWidget(
                                  context,
                                  controller: packageCapacityController,
                                  onTapAdd: () {
                                if (packageCapacityController.text.isEmpty) {
                                  packageCapacityController.text = "0";
                                }

                                packageCapacityController.text =
                                    (int.parse(packageCapacityController.text) +
                                            1)
                                        .toString();
                              }, onTapSubtract: () {
                                if (packageCapacityController.text.isEmpty) {
                                  packageCapacityController.text = "0";
                                }

                                if (int.parse(packageCapacityController.text) >
                                    0) {
                                  packageCapacityController.text = (int.parse(
                                              packageCapacityController.text) -
                                          1)
                                      .toString();
                                }
                              }),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Text(
                            "Quantity",
                            style: GoogleFonts.inter(
                                color: AppColors().textColor(1),
                                fontSize: AppConfig(context).appWidth(4),
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "On Bill",
                                style: GoogleFonts.inter(
                                    color: AppColors().textColor(1),
                                    fontSize: AppConfig(context).appWidth(4),
                                    fontWeight: FontWeight.w500),
                              ),
                              CreateInwardElement().QuantityAddSubWidget(
                                  context,
                                  readOnly: true,
                                  controller: onBillQuantityController,
                                  onTapAdd: () {
                                /* if (onBillQuantityController.text.isEmpty) {
                                  onBillQuantityController.text = "0";
                                }

                                onBillQuantityController.text =
                                    (int.parse(onBillQuantityController.text) +
                                            1)
                                        .toString();*/
                              }, onTapSubtract: () {
                                /*  if (onBillQuantityController.text.isEmpty) {
                                  onBillQuantityController.text = "0";
                                }

                                if (int.parse(onBillQuantityController.text) >
                                    0) {
                                  onBillQuantityController.text = (int.parse(
                                              onBillQuantityController.text) -
                                          1)
                                      .toString();
                                }*/
                              }),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recieved",
                                style: GoogleFonts.inter(
                                    color: AppColors().textColor(1),
                                    fontSize: AppConfig(context).appWidth(4),
                                    fontWeight: FontWeight.w500),
                              ),
                              CreateInwardElement().QuantityAddSubWidget(
                                  context,
                                  controller: receivedQuantityController,
                                  onTapAdd: () {
                                if (receivedQuantityController.text.isEmpty) {
                                  receivedQuantityController.text = "0";
                                }
                                if (int.parse(receivedQuantityController.text) <
                                    state.onBillQuantity) {
                                  receivedQuantityController.text = (int.parse(
                                              receivedQuantityController.text) +
                                          1)
                                      .toString();
                                }
                              }, onTapSubtract: () {
                                if (receivedQuantityController.text.isEmpty) {
                                  receivedQuantityController.text = "0";
                                }

                                if (int.parse(receivedQuantityController.text) >
                                    0) {
                                  receivedQuantityController.text = (int.parse(
                                              receivedQuantityController.text) -
                                          1)
                                      .toString();
                                }
                              }),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Short",
                                style: GoogleFonts.inter(
                                    color: AppColors().textColor(1),
                                    fontSize: AppConfig(context).appWidth(4),
                                    fontWeight: FontWeight.w500),
                              ),
                              CreateInwardElement().QuantityAddSubWidget(
                                  context,
                                  readOnly: true,
                                  controller: shortageQuantityController,
                                  onTapAdd: () {
                                /* if (shortageQuantityController.text.isEmpty) {
                                  shortageQuantityController.text = "0";
                                }

                                shortageQuantityController.text = (int.parse(
                                            shortageQuantityController.text) +
                                        1)
                                    .toString();*/
                              }, onTapSubtract: () {
                                /*  if (shortageQuantityController.text.isEmpty) {
                                  shortageQuantityController.text = "0";
                                }

                                if (int.parse(shortageQuantityController.text) >
                                    0) {
                                  shortageQuantityController.text = (int.parse(
                                              shortageQuantityController.text) -
                                          1)
                                      .toString();
                                }*/
                              }),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Helper.commonButton(
                                    context: context,
                                    onTap: () {
                                      /* navigatorKey.currentState!
                                            .pop(state.tempInwardItemsList);*/
                                      navigatorKey.currentState!
                                          .pop(inwardItemsList);
                                    },
                                    label: "Discard",
                                    backgroundColor: Colors.white,
                                    textColor: AppColors().colorPrimary(1),
                                    borderColor: AppColors().colorPrimary(1)),
                              ),
                              SizedBox(
                                width: AppConfig(context).appWidth(2),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Helper.commonButton(
                                    context: context,
                                    onTap: () {
                                      if (state.storeEditPermission) {
                                        if (lfController.text.isNotEmpty &&
                                            poController.text.isNotEmpty &&
                                            manufacturingDateController!
                                                .text.isNotEmpty &&
                                            expiryDateController!
                                                .text.isNotEmpty &&
                                            batchNumController!
                                                .text.isNotEmpty &&
                                            (onBillQuantityController.text !=
                                                    "0" &&
                                                receivedQuantityController
                                                        .text !=
                                                    "0" &&
                                                state.COACheckGate != "")) {
                                          if ((int.parse(
                                                  receivedQuantityController
                                                      .text) >
                                              int.parse(onBillQuantityController
                                                  .text))) {
                                            Helper.showToast(
                                                "received items should be less than or equal to on bill items");
                                          } else {
                                            if (widget.isEdit) {
                                              inwardItemsList
                                                  .removeAt(widget.index!);
                                              inwardItemsList.insert(
                                                  widget.index!,
                                                  Itemslist.fromJson({
                                                    'item_id':
                                                        state.selectedItem!.id,
                                                    'unit': state
                                                        .selectedItem!.unit,
                                                    'item_name': state
                                                        .selectedItem!
                                                        .productname,
                                                    'on_bill_qty': int.parse(
                                                      onBillQuantityController
                                                          .text,
                                                    ).toString(),
                                                    'lf_no': lfController.text,
                                                    'po_no': poController.text,
                                                    'on_recieve_qty': int.parse(
                                                      receivedQuantityController
                                                          .text,
                                                    ).toString(),
                                                    'on_short_qty': int.parse(
                                                      shortageQuantityController
                                                          .text,
                                                    ).toString(),
                                                    'manufacturing_date':
                                                        manufacturingDateController!
                                                            .text,
                                                    'expiry_date':
                                                        expiryDateController!
                                                            .text,
                                                    'batch_number':
                                                        batchNumController!
                                                            .text,
                                                    'coa_option':
                                                        state.COACheckGate,
                                                    'package_type': state
                                                        .selectedPackageType!
                                                        .id,
                                                    'package_quantity':
                                                        packageQuantityController
                                                            .text,
                                                    'package_capacity':
                                                        packageCapacityController
                                                            .text,
                                                  }));
                                              Helper.showToast(
                                                "Item updated",
                                              );
                                              /*context
                                                .read<InwardCreateCubit>()
                                                .onUpdateProductList(isEdit: widget.isEdit,index: widget.index,Itemslist.fromJson({
                                              'item_id': state.selectedItem!.id,
                                              'unit': state.selectedItem!.unit,
                                              'item_name':
                                              state.selectedItem!.productname,
                                              'on_bill_qty': int.parse(
                                                onBillQuantityController.text,
                                              ).toString(),
                                              'lf_no': lfController.text,
                                              'po_no': poController.text,
                                              'on_recieve_qty': int.parse(
                                                receivedQuantityController.text,
                                              ).toString(),
                                              'on_short_qty': int.parse(
                                                shortageQuantityController.text,
                                              ).toString(),
                                              'manufacturing_date':
                                              manufacturingDateController!
                                                  .text,
                                              'expiry_date':
                                              expiryDateController!.text,
                                              'batch_number':
                                              batchNumController!.text,
                                              'coa_option':
                                              state.COACheckGate==null? "":state.COACheckGate! ? "1" : "0",
                                              'package_type': state.selectedPackageType!.id,
                                              'package_quantity':
                                              packageQuantityController!.text,
                                              'package_capacity':
                                              packageCapacityController!.text,
                                            }));*/
                                            } else {
                                              inwardItemsList!
                                                  .add(Itemslist.fromJson({
                                                'item_id':
                                                    state.selectedItem!.id,
                                                'unit':
                                                    state.selectedItem!.unit,
                                                'item_name': state
                                                    .selectedItem!.productname,
                                                'on_bill_qty': int.parse(
                                                  onBillQuantityController.text,
                                                ).toString(),
                                                'lf_no': lfController.text,
                                                'po_no': poController.text,
                                                'on_recieve_qty': int.parse(
                                                  receivedQuantityController
                                                      .text,
                                                ).toString(),
                                                'on_short_qty': int.parse(
                                                  shortageQuantityController
                                                      .text,
                                                ).toString(),
                                                'manufacturing_date':
                                                    manufacturingDateController!
                                                        .text,
                                                'expiry_date':
                                                    expiryDateController!.text,
                                                'batch_number':
                                                    batchNumController!.text,
                                                'coa_option':
                                                    state.COACheckGate!,
                                                'package_type': state
                                                    .selectedPackageType!.id,
                                                'package_quantity':
                                                    packageQuantityController!
                                                        .text,
                                                'package_capacity':
                                                    packageCapacityController!
                                                        .text,
                                              }));
                                              Helper.showToast(
                                                "Item added to list",
                                              );
                                            }
                                            reset();
                                          }
                                        } else {
                                          Helper.showToast(
                                              "please fill all the fields or add atleast 1 item");
                                        }
                                      }
                                      else if (lfController.text.isNotEmpty &&
                                          poController.text.isNotEmpty &&
                                          (onBillQuantityController.text !=
                                                  "0" &&
                                              receivedQuantityController.text !=
                                                  "0")) {
                                        if ((int.parse(
                                                receivedQuantityController
                                                    .text) >
                                            int.parse(onBillQuantityController
                                                .text))) {
                                          Helper.showToast(
                                              "received items should be less than or equal to on bill items");
                                        } else {
                                          if (widget.isEdit) {
                                            inwardItemsList
                                                .removeAt(widget.index!);
                                            inwardItemsList.insert(
                                                widget.index!,
                                                Itemslist.fromJson({
                                                  'item_id':
                                                      state.selectedItem!.id,
                                                  'unit':
                                                      state.selectedItem!.unit,
                                                  'item_name': state
                                                      .selectedItem!
                                                      .productname,
                                                  'on_bill_qty': int.parse(
                                                    onBillQuantityController
                                                        .text,
                                                  ).toString(),
                                                  'lf_no': lfController.text,
                                                  'po_no': poController.text,
                                                  'on_recieve_qty': int.parse(
                                                    receivedQuantityController
                                                        .text,
                                                  ).toString(),
                                                  'on_short_qty': int.parse(
                                                    shortageQuantityController
                                                        .text,
                                                  ).toString(),
                                                  'manufacturing_date':
                                                      manufacturingDateController!
                                                          .text,
                                                  'expiry_date':
                                                      expiryDateController!
                                                          .text,
                                                  'batch_number':
                                                      batchNumController!.text,
                                                  'coa_option':
                                                      state.COACheckGate!,
                                                  'package_type': state
                                                      .selectedPackageType!.id,
                                                  'package_quantity':
                                                      packageQuantityController!
                                                          .text,
                                                  'package_capacity':
                                                      packageCapacityController!
                                                          .text,
                                                }));
                                            Helper.showToast(
                                              "Item updated",
                                            );
                                            /*context
                                                .read<InwardCreateCubit>()
                                                .onUpdateProductList(isEdit: widget.isEdit,index: widget.index,Itemslist.fromJson({
                                              'item_id': state.selectedItem!.id,
                                              'unit': state.selectedItem!.unit,
                                              'item_name':
                                              state.selectedItem!.productname,
                                              'on_bill_qty': int.parse(
                                                onBillQuantityController.text,
                                              ).toString(),
                                              'lf_no': lfController.text,
                                              'po_no': poController.text,
                                              'on_recieve_qty': int.parse(
                                                receivedQuantityController.text,
                                              ).toString(),
                                              'on_short_qty': int.parse(
                                                shortageQuantityController.text,
                                              ).toString(),
                                              'manufacturing_date':
                                              manufacturingDateController!
                                                  .text,
                                              'expiry_date':
                                              expiryDateController!.text,
                                              'batch_number':
                                              batchNumController!.text,
                                              'coa_option':
                                              state.COACheckGate==null? "":state.COACheckGate! ? "1" : "0",
                                              'package_type': state.selectedPackageType!.id,
                                              'package_quantity':
                                              packageQuantityController!.text,
                                              'package_capacity':
                                              packageCapacityController!.text,
                                            }));*/
                                          } else {
                                            inwardItemsList!
                                                .add(Itemslist.fromJson({
                                              'item_id': state.selectedItem!.id,
                                              'unit': state.selectedItem!.unit,
                                              'item_name': state
                                                  .selectedItem!.productname,
                                              'on_bill_qty': int.parse(
                                                onBillQuantityController.text,
                                              ).toString(),
                                              'lf_no': lfController.text,
                                              'po_no': poController.text,
                                              'on_recieve_qty': int.parse(
                                                receivedQuantityController.text,
                                              ).toString(),
                                              'on_short_qty': int.parse(
                                                shortageQuantityController.text,
                                              ).toString(),
                                              'manufacturing_date':
                                                  manufacturingDateController!
                                                      .text,
                                              'expiry_date':
                                                  expiryDateController!.text,
                                              'batch_number':
                                                  batchNumController!.text,
                                              'coa_option': state.COACheckGate!,
                                              'package_type':
                                                  state.selectedPackageType!.id,
                                              'package_quantity':
                                                  packageQuantityController!
                                                      .text,
                                              'package_capacity':
                                                  packageCapacityController!
                                                      .text,
                                            }));
                                            Helper.showToast(
                                              "Item added to list",
                                            );
                                          }

                                          /*context
                                              .read<InwardCreateCubit>()
                                              .onUpdateProductList(isEdit: widget.isEdit,index: widget.index,Itemslist.fromJson({
                                            'item_id': state.selectedItem!.id,
                                            'unit': state.selectedItem!.unit,
                                            'item_name':
                                            state.selectedItem!.productname,
                                            'on_bill_qty': int.parse(
                                              onBillQuantityController.text,
                                            ).toString(),
                                            'lf_no': lfController.text,
                                            'po_no': poController.text,
                                            'on_recieve_qty': int.parse(
                                              receivedQuantityController.text,
                                            ).toString(),
                                            'on_short_qty': int.parse(
                                              shortageQuantityController.text,
                                            ).toString(),
                                            'manufacturing_date':
                                            manufacturingDateController!
                                                .text,
                                            'expiry_date':
                                            expiryDateController!.text,
                                            'batch_number':
                                            batchNumController!.text,
                                            'coa_option':
                                            state.COACheckGate==null? "":state.COACheckGate! ? "1" : "0",
                                            'package_type': state.selectedPackageType!.id,
                                            'package_quantity':
                                            packageQuantityController!.text,
                                            'package_capacity':
                                            packageCapacityController!.text,
                                          }));*/

                                          reset();
                                        }
                                      }
                                      else {
                                        Helper.showToast(
                                            "please fill all the fields or add atleast 1 item");
                                      }
                                    },
                                    label: widget.isEdit ? "Save" : "Add Item",
                                    backgroundColor:
                                        AppColors().colorPrimary(1),
                                    textColor: Colors.white,
                                    borderColor: Colors.white,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }

  reset() {
    lfController.clear();
    poController.clear();
    batchNumController!.clear();
    manufacturingDateController!.clear();
    expiryDateController!.clear();
    poController.clear();
    expiryDateController!.clear();
    manufacturingDateController!.clear();
    packageQuantityController.text = "0";
    packageCapacityController.text = "0";
    onBillQuantityController.text = "0";
    receivedQuantityController.text = "0";
    shortageQuantityController.text = "0";
  }

  Future addTransporterDialogue({
    BuildContext? context,
  }) {
    return showDialog(
      context: context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AddPackageDialog();
      },
    );
  }
}
