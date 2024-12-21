import 'package:erpvc/helper/helper.dart';
import 'package:erpvc/helper/route_arguments.dart';
import 'package:erpvc/pages/create_inward/cubit/inward_create_cubit.dart';
import 'package:erpvc/pages/create_inward/cubit/sub_cubit/inward_create_sub_cubit.dart';
import 'package:erpvc/pages/create_inward/elements/add_transporter_dialog.dart';
import 'package:erpvc/pages/create_inward/elements/attach_doc_dropdown.dart';
import 'package:erpvc/pages/create_inward/elements/create_inward_elements.dart';
import 'package:erpvc/pages/create_inward/elements/party_dropdown.dart';
import 'package:erpvc/pages/create_inward/elements/transporter_dro_down.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../helper/app_config.dart';

class CreateInwardPageFirst extends StatefulWidget {
  CreateInwardPageFirst({Key? key, this.routeArguments, this.clear})
      : super(key: key);
  RouteArguments? routeArguments;
  VoidCallback? clear;

  @override
  State<CreateInwardPageFirst> createState() => CreateInwardPageFirstState();
}

class CreateInwardPageFirstState extends State<CreateInwardPageFirst> {
  TextEditingController? dateController = TextEditingController();
  TextEditingController? mrirDateController = TextEditingController();
  TextEditingController? gRRRDateController = TextEditingController();
  TextEditingController? invoiceDateController = TextEditingController();
  TextEditingController? invoiceController = TextEditingController();
  TextEditingController? vehicleNoController = TextEditingController();
  TextEditingController? gRRRValueController = TextEditingController();
  TextEditingController? inwardController = TextEditingController();
  TextEditingController? mrrController = TextEditingController();
  TextEditingController? unitNoController = TextEditingController();
  TextEditingController? amountController = TextEditingController();
  TextEditingController? freightCostController = TextEditingController();
  TextEditingController? perUnitController = TextEditingController();
  TextEditingController? attachmentController = TextEditingController();

  var getGateKeeperPer = false;
  String? selectedOption;

  var _site;

  InwardCreateCubit? inwardCreateCubit;

  @override
  void initState() {
    inwardCreateCubit = context.read<InwardCreateCubit>();
    getGateKepperPer();
    invoiceController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onInvoiceNoChanged(value: invoiceController!.text);
    });
    inwardController!.addListener(() {
      inwardController!.text =
          context.read<InwardCreateCubit>().state.invoiceNo!.toString();
    });
    mrrController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onMrirChanged(value: mrrController!.text);
    });

    vehicleNoController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onVehicleNumberChanged(value: vehicleNoController!.text);
    });

    gRRRValueController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onGrrrNumberChanged(value: gRRRValueController!.text);
    });

    dateController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onDateChange(dateTime: dateController!.text);
    });
    invoiceDateController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onInvoiceDateChange(dateTime: invoiceDateController!.text);
    });
    gRRRDateController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onGRRRDateChange(dateTime: gRRRDateController!.text);
    });
    mrirDateController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onPODateChange(dateTime: mrirDateController!.text);
    });

    amountController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onamountNumberChanged(value: amountController!.text);
    });
    unitNoController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onUnitNumberChanged(value: unitNoController!.text);
    });
    freightCostController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onFreightCostChanged(value: freightCostController!.text);
    });
    perUnitController!.addListener(() {
      context
          .read<InwardCreateCubit>()
          .onperUnitChanged(value: perUnitController!.text);
    });

    if (widget.routeArguments!.fromScreen == "Edit Entry" &&
        context.read<InwardCreateCubit>().state.isEdit) {
      dateController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.inwardDate!;
      invoiceDateController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.invoiceDate!;
      mrirDateController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.mrirDate ??
              DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
      gRRRDateController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.gtRrDate!;

      invoiceController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.invoiceNo!;
      mrrController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.mrirNo ?? "";
      vehicleNoController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.vehicleNo!;
      gRRRValueController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.grRrNo!;
      inwardController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.inwardNo!;
      amountController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.amount!;
      unitNoController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.unitNo!;
      freightCostController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.freightCost!;
      perUnitController!.text =
          widget.routeArguments!.inwardDetailsModelData!.data!.perUnit!;

      context.read<InwardCreateCubit>().onChangeCenvatPaper(
          widget.routeArguments!.inwardDetailsModelData!.data!.cenvatPaper ==
                  "0"
              ? false
              : true);
      context.read<InwardCreateCubit>().onChangeIsEdit(false);
      // widget.routeArguments!.fromScreen = "New Entry";
    }
    ////////
    else {
      dateController!.text =
          context.read<InwardCreateCubit>().state.dateTime.toString();
      invoiceDateController!.text =
          context.read<InwardCreateCubit>().state.invoiceDate.toString();
      mrirDateController!.text =
          context.read<InwardCreateCubit>().state.mrirDate.toString();
      gRRRDateController!.text =
          context.read<InwardCreateCubit>().state.gr_rrDate.toString();

      invoiceController!.text =
          context.read<InwardCreateCubit>().state.invoiceNumber.value;
      mrrController!.text =
          context.read<InwardCreateCubit>().state.mrirNum.value;
      vehicleNoController!.text =
          context.read<InwardCreateCubit>().state.vehicleNo.value;
      gRRRValueController!.text =
          context.read<InwardCreateCubit>().state.grrrNo.value;
      inwardController!.text =
          "${context.read<InwardCreateCubit>().state.invoiceNo!}";
      amountController!.text =
          context.read<InwardCreateCubit>().state.amount.value;
      unitNoController!.text =
          context.read<InwardCreateCubit>().state.unitNo.value;
      freightCostController!.text =
          context.read<InwardCreateCubit>().state.freightCost.value;
      perUnitController!.text =
          context.read<InwardCreateCubit>().state.perUnit.value;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InwardCreateCubit, InwardCreateState>(
      listenWhen: (p, c) => p.clearFields != c.clearFields,
      listener: (context, state) {
        if (state.clearFields!) {
          inwardController!.text = "${state.invoiceNo!}";
          resetControllers();
          context.read<InwardCreateCubit>().onClearTap();
        }
      },
      builder: (contexta, state) {
        debugPrint("check:listner123 ${state.hashCode.toString()}");
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppConfig(context).appWidth(7)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppConfig(context).appHeight(2)),
              context
                          .read<InwardCreateCubit>()
                          .userRepository!
                          .user!
                          .data!
                          .role ==
                      "Storekeeper"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: AppConfig(context).appWidth(40),
                            child: CreateInwardElement().textFieldCommon(
                                labelTittle: "MRIR No. *",
                                // isValid: state.mrirNum.isNotValid,
                                textEditingController: mrrController,
                                context: context)),
                        SizedBox(
                          width: AppConfig(context).appWidth(2),
                        ),
                        SizedBox(
                          width: AppConfig(context).appWidth(40),
                          child: CreateInwardElement().dateFieldCommon(
                              context: context,
                              myDateSetter: (DateTime? value) {
                                mrirDateController!.text =
                                    DateFormat('dd-MM-yyyy HH:mm')
                                        .format(value!);
                              },
                              textEditingController: mrirDateController,
                              labelTittle: "Date"),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: AppConfig(context).appWidth(40),
                      child: SizedBox(
                        height: AppConfig(context).appHeight(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Inward No *",
                              //  state.invoiceNo.toString(),
                              style: GoogleFonts.inter(
                                  color: AppColors().textColor(1),
                                  fontSize: AppConfig(context).appWidth(4),
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              height: AppConfig(context).appHeight(5),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                state.invoiceNo.toString(),
                                style: GoogleFonts.inter(
                                    color: AppColors().textColor(1),
                                    fontSize: AppConfig(context).appWidth(4),
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Divider(
                              color: Color(0xffD3D8DD),
                              thickness: 1,
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: AppConfig(context).appWidth(2),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().dateFieldCommon(
                        context: context,
                        myDateSetter: (DateTime? value) {
                          dateController!.text =
                              DateFormat('dd-MM-yyyy HH:mm').format(value!);
                        },
                        textEditingController: dateController,
                        labelTittle: "Date"),
                  ),
                ],
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              PartyDropDown(
                selectedParty: state.selectedParty,
                partyNameModelList: state.partyList,
                textEditingController: TextEditingController(),
                myDateSetter: (value) {
                  context
                      .read<InwardCreateCubit>()
                      .onPartyChange(selectedParty: value);
                },
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().textFieldCommon(
                        labelTittle: "Invoice No. *",
                        // isValid: state.invoiceNumber.isNotValid,
                        textEditingController: invoiceController,
                        context: context),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(3),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().dateFieldCommon(
                        context: context,
                        myDateSetter: (DateTime? value) {
                          invoiceDateController!.text =
                              DateFormat('dd-MM-yyyy HH:mm').format(value!);
                        },
                        textEditingController: invoiceDateController,
                        labelTittle: "Invoice Date"),
                  ),
                ],
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().textFieldCommon(
                        labelTittle: "Amount *",
                        // isValid: state.amount.isNotValid,
                        textInputType: TextInputType.number,
                        textEditingController: amountController,
                        context: context),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(2),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().textFieldCommon(
                        labelTittle: "Unit No. *",
                        // isValid: state.unitNo.isNotValid,
                        textInputType: TextInputType.number,
                        textEditingController: unitNoController,
                        context: context),
                  ),
                ],
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().textFieldCommon(
                        labelTittle: "GR/RR No. *",

                        //  isValid: state.grrrNo.isNotValid,
                        textEditingController: gRRRValueController,
                        context: context),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(2),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().dateFieldCommon(
                        context: context,
                        myDateSetter: (DateTime? value) {
                          gRRRDateController!.text =
                              DateFormat('dd-MM-yyyy HH:mm').format(value!);
                        },
                        textEditingController: gRRRDateController,
                        labelTittle: "Date"),
                  ),
                ],
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Row(
                children: [
                  Text(
                    "Select Transporter *",
                    style: GoogleFonts.inter(
                        color: AppColors().textColor(1),
                        fontSize: AppConfig(context).appWidth(4),
                        fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                      onTap: () {
                        addTransporterDialogue(context: context).then((value) {
                          print('returned data $value');
                          context
                              .read<InwardCreateCubit>()
                              .getTransporterList();
                        });
                      },
                      child: Icon(
                        Icons.add_circle_rounded,
                        color: AppColors().colorPrimary(1),
                      ))
                ],
              ),
              SizedBox(
                  width: AppConfig(context).appWidth(100),

                  /*   child: TransporterDropDown(
                  selectedParty: state.selectedTransporterModel,
                  partyNameModelList: state.transporterModel!,
                  textEditingController: TextEditingController(),
                  myDateSetter: (value) {
                    context
                        .read<InwardCreateCubit>()
                        .onTransporterModel(selectedParty: value);
                  },
                )*/

                  child: TransporterDropDown(
                    selectedParty: state.selectedTransporterModel,
                    partyNameModelList: state.transporterModel,
                    textEditingController: TextEditingController(),
                    myDateSetter: (value) {
                      context
                          .read<InwardCreateCubit>()
                          .onTransporterModel(selectedParty: value);
                    },
                  )),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              SizedBox(
                width: AppConfig(context).appWidth(100),
                child: CreateInwardElement().textFieldCommon(
                    labelTittle: "Vehicle No. *",
                    // isValid: state.vehicleNo.isNotValid,
                    textEditingController: vehicleNoController,
                    context: context),
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().textFieldCommon(
                        labelTittle: "Freight Cost(Total) *",
                        //   isValid: state.freightCost.isNotValid,
                        textInputType: TextInputType.number,
                        textEditingController: freightCostController,
                        context: context),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(2),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: CreateInwardElement().textFieldCommon(
                        labelTittle: "Per Unit *",
                        //  isValid: state.perUnit.isNotValid,
                        textInputType: TextInputType.number,
                        textEditingController: perUnitController,
                        context: context),
                  ),
                ],
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Text(
                "Cenvat Paper",
                style: GoogleFonts.inter(
                    color: AppColors().textColor(1),
                    fontSize: AppConfig(context).appWidth(4),
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: Row(
                      children: [
                        SizedBox(
                          height: AppConfig(context).appWidth(6),
                          width: AppConfig(context).appWidth(6),
                          child: Radio(
                              value: true,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => AppColors().colorPrimary(1)),
                              activeColor: AppColors().colorPrimary(1),
                              groupValue: state.cenvatPaper,
                              onChanged: (value) {
                                context
                                    .read<InwardCreateCubit>()
                                    .onChangeCenvatPaper(value!);
                              }),
                        ),
                        SizedBox(
                          width: AppConfig(context).appWidth(3),
                        ),
                        Text(
                          "Yes",
                          style: GoogleFonts.inter(
                              color: AppColors().blackColor(1),
                              fontSize: AppConfig(context).appWidth(4),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: Row(
                      children: [
                        SizedBox(
                          height: AppConfig(context).appWidth(6),
                          width: AppConfig(context).appWidth(6),
                          child: Radio(
                              value: false,
                              groupValue: state.cenvatPaper,
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => AppColors().colorPrimary(1)),
                              activeColor: AppColors().colorPrimary(1),
                              onChanged: (value) {
                                context
                                    .read<InwardCreateCubit>()
                                    .onChangeCenvatPaper(value!);
                              }),
                        ),
                        SizedBox(
                          width: AppConfig(context).appWidth(3),
                        ),
                        Text(
                          "No",
                          style: GoogleFonts.inter(
                              color: AppColors().blackColor(1),
                              fontSize: AppConfig(context).appWidth(4),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Text(
                "Attachments *",
                style: GoogleFonts.inter(
                    color: AppColors().textColor(1),
                    fontSize: AppConfig(context).appWidth(4),
                    fontWeight: FontWeight.w600),
              ),
              ListView.builder(
                  itemCount: state.inwardCreateSubCubitList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return BlocProvider(
                      create: (context) =>
                          state.inwardCreateSubCubitList[index],
                      child: BlocBuilder<InwardCreateSubCubit,
                          InwardCreateSubState>(
                        builder: (context, subState) {
                          print(
                              "HashKey value ${Key(state.hashCode.toString())} ${subState.uploadedDocName}");
                          return Card(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  AppConfig(context).appWidth(4)),
                              child: Column(
                                children: [
                                  AttachDocumentDropDown(
                                    attachedDocList: state.documentData!,
                                    selectedDoc: subState.selectedDoc,
                                    myDateSetter: (value) {
                                      context
                                          .read<InwardCreateSubCubit>()
                                          .onChangeAttachedDoc(value);
                                    },
                                  ),
                                  SizedBox(
                                    height: AppConfig(context).appHeight(3),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        if (subState.selectedDoc != null) {
                                          context
                                              .read<InwardCreateSubCubit>()
                                              .selectFile();
                                        } else {
                                          Helper.showToast(
                                              "please select a attachment type");
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          return AppColors().colorPrimary(1);
                                        }),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical:
                                                AppConfig(context).appWidth(4)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.upload,
                                              color: Colors.white,
                                              size: AppConfig(context)
                                                  .appWidth(6),
                                            ),
                                            SizedBox(
                                              width: AppConfig(context)
                                                  .appWidth(3),
                                            ),
                                            Text(
                                              "Upload Document",
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: AppConfig(context)
                                                      .appWidth(4.5),
                                                  fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        ),
                                      )),
                                  SizedBox(
                                    height: AppConfig(context).appHeight(3),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      subState.uploadedDocName != null
                                          ? SizedBox(
                                              width: AppConfig(context)
                                                  .appWidth(65),
                                              child: Text(
                                                subState.uploadedDocName!,
                                                style: GoogleFonts.inter(
                                                    color: AppColors()
                                                        .textColor(1),
                                                    fontSize: AppConfig(context)
                                                        .appWidth(4),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          : SizedBox(),
                                      InkWell(
                                          onTap: () {
                                            confirmDeleteItemDialog(context)
                                                .then((value) {
                                              if (value) {
                                                context
                                                    .read<InwardCreateCubit>()
                                                    .addNewDoc(
                                                      "remove",
                                                      index: index,
                                                    );
                                              }
                                            });
                                          },
                                          child: Icon(
                                            Icons.close,
                                            size:
                                                AppConfig(context).appHeight(2),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Center(
                child: SizedBox(
                  height: AppConfig(context).appHeight(6),
                  width: AppConfig(context).appWidth(40),
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<InwardCreateCubit>().addNewDoc("add");
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return AppColors().colorPrimary(1);
                        }),
                      ),
                      child: Text(
                        "Add New Document",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: AppConfig(context).appWidth(4),
                            fontWeight: FontWeight.w500),
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  resetControllers() {
    dateController!.text =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    mrirDateController!.text =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    gRRRDateController!.text =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    invoiceDateController!.text =
        DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now());
    invoiceController!.clear();
    vehicleNoController!.clear();
    gRRRValueController!.clear();
    mrrController!.clear();
    unitNoController!.clear();
    amountController!.clear();
    freightCostController!.clear();
    perUnitController!.clear();
  }

  Future<void> getGateKepperPer() async {
    getGateKeeperPer = await Helper().getGateKeeperPermission();
    inwardCreateCubit!.getTransporterList();
  }

  Future addTransporterDialogue({
    BuildContext? context,
  }) {
    return showDialog(
      context: context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AddTransporter();
      },
    );
  }

  Future confirmDeleteItemDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 24,
            content: const Text("Do you want to Delete Document?"),
            actions: [
              TextButton(
                  onPressed: () {
                    navigatorKey.currentState!.pop(true);
                  },
                  child: Text("Yes",
                      style: GoogleFonts.inter(
                          color: AppColors().textColor(1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400))),
              TextButton(
                  onPressed: () {
                    navigatorKey.currentState!.pop(false);
                  },
                  child: Text("No",
                      style: GoogleFonts.inter(
                          color: AppColors().textColor(1),
                          fontSize: 14,
                          fontWeight: FontWeight.w400))),
            ],
          );
        });
  }

  @override
  void dispose() {
    print("Dispose called");
    super.dispose();
  }
}
