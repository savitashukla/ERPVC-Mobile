import 'package:erpvc/helper/app_config.dart';
import 'package:erpvc/helper/helper.dart';
import 'package:erpvc/pages/add_to_rack/elements/add_to_rack_elements.dart';
import 'package:erpvc/pages/add_to_rack/view/add_to_rack_screen.dart';
import 'package:erpvc/pages/inward_details/cubit/inward_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../repos/authentication_repository.dart';
import '../../../repos/inventory_repo.dart';
import '../../add_to_rack/cubit/add_to_rack_cubit.dart';
import '../../create_inward/elements/create_inward_elements.dart';
import '../cubit/inward_details_state.dart';
import '../elements/Elements.dart';

import '../../../model/inward_deatils_model_data.dart';
import '../../../repos/authentication_repository.dart';
import '../../dashboard/cubit/dashboard_cubit.dart';
import '../../dashboard/cubit/dashboard_state.dart';

class InwardDetails extends StatefulWidget {
  String? idC;


  InwardDetails([String? idC1]) {
    idC = idC1;

  }

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (context) => InwardDetailsCubit(),
        child: InwardDetails(),
      );
    });
  }

  @override
  State<InwardDetails> createState() => _InwardDetailsState();
}

class _InwardDetailsState extends State<InwardDetails> {
  InwardDetailsCubit? createStoriesCubit;
  AddToRackCubit? addRackStoriesCubit;

  bool racksCreate = false;
  bool dataEntryEdit = false;

  bool? getGateKeeperPer=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: BlocBuilder<InwardDetailsCubit, InwardDetailsState>(
        builder: (context, state) {
          return  SingleChildScrollView(
                  child: state.isProcessing
                      ?Column(
                    children: [
                      Elements().appBar(
                        context,

                        invoiceNo:
                            state.inwardDetailsModelVar!.data!.inwardNo! ?? "",
                      ),
                       Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 30, top: 1),
                            height: MediaQuery.of(context).size.height - 101,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        !dataEntryEdit? SizedBox(height: 0,) :Column(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "MRIR No.",
                                                        style: GoogleFonts.inter(
                                                            color: AppColors()
                                                                .colorPrimary(1),
                                                            fontSize: AppConfig(context)
                                                                .appWidth(4),
                                                            fontWeight:
                                                                FontWeight.w600),
                                                      ),
                                                      Text(
                                                        state.inwardDetailsModelVar!.data!.mrirNo??"---",
                                                        style: GoogleFonts.inter(
                                                            color: AppColors()
                                                                .colorPrimary(1),
                                                            fontSize: AppConfig(context)
                                                                .appWidth(4),
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: AppConfig(context).appWidth(2),
                                                ),
                                                SizedBox(
                                                  //  flex: 1,
                                                  width:
                                                      AppConfig(context).appWidth(37),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Date",
                                                        style: GoogleFonts.inter(
                                                            color: AppColors()
                                                                .colorPrimary(1),
                                                            fontSize: AppConfig(context)
                                                                .appWidth(4),
                                                            fontWeight:
                                                                FontWeight.w600),
                                                      ),
                                                      Text(
                                                          state.inwardDetailsModelVar!.data!.mrirDate!=null && state.inwardDetailsModelVar!.data!.mrirDate!="null" ?  Helper().getFormatedDate(state.inwardDetailsModelVar!.data!.mrirDate):"---",

                                                        style: GoogleFonts.inter(
                                                            color: AppColors()
                                                                .colorPrimary(1),
                                                            fontSize: AppConfig(context)
                                                                .appWidth(4),
                                                            fontWeight:
                                                                FontWeight.w400),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: AppConfig(context).appHeight(3),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Inward No.",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.inwardNo}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppConfig(context).appWidth(2),
                                            ),
                                            SizedBox(
                                              //  flex: 1,
                                              width:
                                                  AppConfig(context).appWidth(37),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                      state.inwardDetailsModelVar!.data!.inwardDate !=null  && state.inwardDetailsModelVar!.data!.inwardDate!.isNotEmpty? Helper().getFormatedDate(state.inwardDetailsModelVar!.data!.inwardDate):"",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                        Text(
                                          "Supplier",
                                          style: GoogleFonts.inter(
                                              color: AppColors().colorPrimary(1),
                                              fontSize:
                                                  AppConfig(context).appWidth(4),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "${state.inwardDetailsModelVar!.data!.partyname}",
                                          style: GoogleFonts.inter(
                                              color: AppColors().colorPrimary(1),
                                              fontSize:
                                                  AppConfig(context).appWidth(4),
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Invoice",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.invoiceNo}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppConfig(context).appWidth(2),
                                            ),
                                            SizedBox(
                                              width:
                                                  AppConfig(context).appWidth(37),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Invoice Date",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    state.inwardDetailsModelVar!.data!.invoiceDate!,


                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              //  width: AppConfig(context).appWidth(45),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Amount",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.amount}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppConfig(context).appWidth(2),
                                            ),
                                            SizedBox(
                                              width:
                                                  AppConfig(context).appWidth(37),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Unit No.",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.unitNo}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "GR/RR No.",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.grRrNo}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppConfig(context).appWidth(2),
                                            ),
                                            SizedBox(
                                              width:
                                                  AppConfig(context).appWidth(37),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                   state.inwardDetailsModelVar!.data!.gtRrDate!,

                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Transporter",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.transporterName}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppConfig(context).appWidth(2),
                                            ),
                                            SizedBox(
                                              //  flex: 1,
                                              width:
                                                  AppConfig(context).appWidth(37),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Vehicle No.",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.vehicleNo}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              //  width: AppConfig(context).appWidth(45),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Freight Cost(Total)",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.freightCost}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppConfig(context).appWidth(2),
                                            ),
                                            SizedBox(
                                              width:
                                                  AppConfig(context).appWidth(37),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Per Unit",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    "${state.inwardDetailsModelVar!.data!.perUnit}",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Cenvat Paper",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    state.inwardDetailsModelVar!
                                                                .data!.cenvatPaper ==
                                                            "0"
                                                        ? "No"
                                                        : "Yes",
                                                    style: GoogleFonts.inter(
                                                        color: AppColors()
                                                            .colorPrimary(1),
                                                        fontSize: AppConfig(context)
                                                            .appWidth(4),
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Items",
                                                style: GoogleFonts.inter(
                                                    color:
                                                        AppColors().colorPrimary(1),
                                                    fontSize: AppConfig(context)
                                                        .appWidth(4),
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              width: AppConfig(context).appWidth(2),
                                            ),
                                            SizedBox(
                                              width:
                                                  AppConfig(context).appWidth(37),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 50),
                                                    child: Text(
                                                      "Quantity",
                                                      style: GoogleFonts.inter(
                                                          color: AppColors()
                                                              .colorPrimary(1),
                                                          fontSize:
                                                              AppConfig(context)
                                                                  .appWidth(4),
                                                          fontWeight:
                                                              FontWeight.w600),
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
                                        Wrap(
                                          children: [
                                            state.inwardDetailsModelVar!.data!
                                                    .itemslist!.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount: state
                                                        .inwardDetailsModelVar!
                                                        .data!
                                                        .itemslist!
                                                        .length,
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemBuilder: (context, index) {

                                                      createStoriesCubit!.getRackAssign(int.parse("${state
                                                          .inwardDetailsModelVar!
                                                          .data!
                                                          .itemslist![index].id}"));

                                                      return Elements().getRowData(
                                                          index,
                                                          state
                                                              .inwardDetailsModelVar!
                                                              .data!
                                                              .itemslist!);
                                                    })
                                                : Text(""),
                                          ],
                                        ),
                                        SizedBox(
                                          height: AppConfig(context).appHeight(3),
                                        ),
                                      ],
                                    ),
                                  ),
                                  racksCreate
                                      ? state.inwardDetailsModelVar!.data!
                                                  .rackAssign ==
                                              0
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.only(right: 10),
                                              //height: AppConfig(context).appHeight(8),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: AppConfig(context)
                                                      .appHeight(2)),
                                              width:
                                                  AppConfig(context).appWidth(100),
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child:context.read<AddToRackCubit>().state.isProcessing!?
                                                    Container(
                                                      height: 50,
                                                      width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          1.8,
                                                      child: ElevatedButton(
                                                          onPressed: () {},
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .resolveWith(
                                                                          (states) {
                                                                return  Colors.green;
                                                              }),
                                                              side: MaterialStateProperty
                                                                  .resolveWith(
                                                                      (states) {})),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom: 4),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color:
                                                                      Colors.white,
                                                                  size: AppConfig(
                                                                          context)
                                                                      .appWidth(7),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: AppConfig(
                                                                        context)
                                                                    .appWidth(1),
                                                              ),
                                                              Text(
                                                                "Rack assigned",
                                                                style: GoogleFonts.inter(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: AppConfig(
                                                                            context)
                                                                        .appWidth(
                                                                            4)),
                                                              )
                                                            ],
                                                          )),
                                                    )
                                                        :Container(
                                                      height: 50,
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          1.8,
                                                      child: ElevatedButton(
                                                          onPressed: () {},
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      (states) {
                                                                    return  Colors.red;
                                                                  }),
                                                              side: MaterialStateProperty
                                                                  .resolveWith(
                                                                      (states) {})),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom: 4),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color:
                                                                  Colors.white,
                                                                  size: AppConfig(
                                                                      context)
                                                                      .appWidth(7),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: AppConfig(
                                                                    context)
                                                                    .appWidth(1),
                                                              ),
                                                              Text(
                                                                "Rack not assigned",
                                                                style: GoogleFonts.inter(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: AppConfig(
                                                                        context)
                                                                        .appWidth(
                                                                        4)),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Helper.commonButton(
                                                            context: context,
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            label: "Back",
                                                            backgroundColor:
                                                                Colors.white,
                                                            textColor: AppColors()
                                                                .colorPrimary(1),
                                                            borderColor: AppColors()
                                                                .colorPrimary(1)),
                                                      ),
                                                      SizedBox(
                                                        width: AppConfig(context)
                                                            .appWidth(2),
                                                      ),
                                                      Expanded(
                                                          flex: 2,
                                                          child:
                                                              Helper.commonButton(
                                                            context: context,
                                                            onTap: () async {


                                                              addRackStoriesCubit!
                                                                  .getRackItemListData(state
                                                                      .inwardDetailsModelVar!
                                                                      .data!
                                                                      .itemslist);

                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => AddToRack(
                                                                          invoiceNo: state
                                                                              .inwardDetailsModelVar!
                                                                              .data!
                                                                              .invoiceNo,
                                                                          inwardId:
                                                                              widget
                                                                                  .idC)));
                                                            },
                                                            label: "Assign Rack",
                                                            backgroundColor:
                                                                AppColors()
                                                                    .colorPrimary(
                                                                        1),
                                                            textColor: Colors.white,
                                                            borderColor:
                                                                Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              margin:
                                                  const EdgeInsets.only(right: 10),
                                              //height: AppConfig(context).appHeight(8),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: AppConfig(context)
                                                      .appHeight(2)),
                                              width:
                                                  AppConfig(context).appWidth(100),
                                              child: Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      height: 50,

                                                      child: ElevatedButton(
                                                          onPressed: () {},
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStateProperty
                                                                      .resolveWith(
                                                                          (states) {
                                                                return Colors.green;
                                                              }),
                                                              side: MaterialStateProperty
                                                                  .resolveWith(
                                                                      (states) {})),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom: 4),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color:
                                                                      Colors.white,
                                                                  size: AppConfig(
                                                                          context)
                                                                      .appWidth(7),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: AppConfig(
                                                                        context)
                                                                    .appWidth(1),
                                                              ),
                                                              Text(
                                                                "Rack Assigned Successfully",
                                                                style: GoogleFonts.inter(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: AppConfig(
                                                                            context)
                                                                        .appWidth(
                                                                            4)),
                                                              )
                                                            ],
                                                          )),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Helper.commonButton(
                                                            context: context,
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            label: "Back",
                                                            backgroundColor:
                                                            Colors.white,
                                                            textColor: AppColors()
                                                                .colorPrimary(1),
                                                            borderColor: AppColors()
                                                                .colorPrimary(1)),
                                                      ),
                                                      SizedBox(
                                                        width: AppConfig(context)
                                                            .appWidth(2),
                                                      ),
                                                      Expanded(
                                                          flex: 2,
                                                          child:
                                                          Helper.commonButton(
                                                            context: context,
                                                            onTap: () async {
                                                              addRackStoriesCubit!
                                                                  .getRackItemListData(state
                                                                  .inwardDetailsModelVar!
                                                                  .data!
                                                                  .itemslist);

                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => AddToRack(
                                                                          invoiceNo: state
                                                                              .inwardDetailsModelVar!
                                                                              .data!
                                                                              .invoiceNo,
                                                                          inwardId:
                                                                          widget
                                                                              .idC)));
                                                            },
                                                            label: "Assign Rack",
                                                            backgroundColor:
                                                            AppColors()
                                                                .colorPrimary(
                                                                1),
                                                            textColor: Colors.white,
                                                            borderColor:
                                                            Colors.white,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                      : const SizedBox(height: 0),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ) :
                  Container(height:AppConfig(
                      context).appHeight(80),
                    child: Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(color: AppColors().colorPrimary(1),),
                      ),
                    ),
                  )
                );
        },
      ),
    ));
  }

  Future<void> getApiData() async {

    addRackStoriesCubit = context.read<AddToRackCubit>();
    createStoriesCubit = context.read<InwardDetailsCubit>();
    createStoriesCubit!.getInwardDetails(widget.idC);
    racksCreate = await Helper().getDataRacksPer();
    dataEntryEdit = await Helper().getDataEntryEditDPer();
    getGateKeeperPer = await Helper().getGateKeeperPermission();


    addRackStoriesCubit!.getRackList();

  }
}
