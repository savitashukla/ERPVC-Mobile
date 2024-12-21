import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erpvc/helper/route_arguments.dart';
import 'package:erpvc/model/rack_list.dart';
import 'package:erpvc/pages/inward_details/cubit/inward_details_cubit.dart';
import 'package:erpvc/pages/inward_details/cubit/inward_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../helper/helper.dart';
import '../../../model/inward_deatils_model_data.dart';
import '../../../repos/authentication_repository.dart';
import '../../create_inward/cubit/inward_create_cubit.dart';
import '../../create_inward/elements/create_inward_elements.dart';
import '../../inventory/view/inventory_view.dart';

class Elements {
  final TextEditingController quantityController =
      TextEditingController(text: "0");
  Map<String, TextEditingController> textControllers = new Map();

  InwardDetailsCubit? createStoriesCubit;

  Widget appBar(
    context, {

    String? invoiceNo,
  }) {
    return BlocBuilder<InwardDetailsCubit, InwardDetailsState>(
      builder: (context, state) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppConfig(context).appWidth(1)),
                  bottomRight:
                      Radius.circular(AppConfig(context).appWidth(1)))),
          child: Padding(
            padding: EdgeInsets.all(AppConfig(context).appWidth(4)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppConfig(context).appWidth(10),
                  child: InkWell(
                    onTap: () {

                        navigatorKey.currentState!.pop();

                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors().colorPrimary(1),
                      size: AppConfig(context).appWidth(5),
                    ),
                  ),
                ),
                Center(
                  child: Center(
                    child: Text(
                      "Inward No: ${invoiceNo ?? ""}",
                      style: GoogleFonts.inter(
                          color: AppColors().colorPrimary(1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                    InkWell(
                  onTap: () {
                    navigatorKey.currentState!.pushNamed('/CreateInwardPage',
                        arguments: RouteArguments(fromScreen: "Edit Entry",inwardDetailsModelData: state.inwardDetailsModelVar));
                  },
                  child: SizedBox(height:  AppConfig(context).appWidth(6),width:  AppConfig(context).appWidth(6),
                    child: Icon(
                      Icons.edit,
                      color: AppColors().colorPrimary(1),
                      size: AppConfig(context).appWidth(5),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void showBottomSheetEditUPI(
    BuildContext context,
    var selectedParty,
    List<Itemslist>? itemslist,
    List<RackData>? partyNameModelList,
  ) {
    createStoriesCubit = context.read<InwardDetailsCubit>();

    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                SizedBox(
                  width: double.infinity,
                  //       height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Assigned Rack",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: AppColors().accentColor(1),
                              fontSize: AppConfig(context).appWidth(4)),
                        ),
                      ),
                      ListView.builder(
                          itemCount: itemslist!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return getIteamListData(
                                partyNameModelList, index, context, itemslist);
                            /*  return Elements().getRowData(
                                index,
                                state.inwardDetailsModelVar!
                                    .data!.itemslist!);*/
                          }),

                      //   getListViewData(itemslist![0].itemQuantity),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Helper.commonButton(
                                context: context,
                                onTap: () {},
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
                                  //       Map<String,String> mapData={"rack_id":"${partyNameModelList.l}","inward_id":"","cell_used":"","item_id":""};

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const InventoryScreen()));
                                  // navigatorKey.currentState!.pushNamed("'/InventoryScreen");
                                },
                                label: "Save",
                                backgroundColor: AppColors().colorPrimary(1),
                                textColor: Colors.white,
                                borderColor: Colors.white,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget QuantityAddSubWidget(BuildContext context,
      {VoidCallback? onTapAdd,
      VoidCallback? onTapSubtract,
      TextEditingController? controller}) {
    return Row(
      children: [
        InkWell(
          onTap: onTapAdd,
          child: Container(
            height: AppConfig(context).appHeight(4),
            width: AppConfig(context).appHeight(4),
            decoration: BoxDecoration(
                color: AppColors().colorPrimary(1),
                borderRadius:
                    BorderRadius.circular(AppConfig(context).appHeight(0.5))),
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: AppConfig(context).appHeight(2),
              ),
            ),
          ),
        ),
        SizedBox(
          width: AppConfig(context).appWidth(2),
        ),
        SizedBox(
          height: AppConfig(context).appHeight(5),
          width: AppConfig(context).appWidth(12),
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.center,
            maxLength: 4,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
            ],
            decoration: InputDecoration(counterText: ""),
          ),
        ),
        SizedBox(
          width: AppConfig(context).appWidth(2),
        ),
        InkWell(
          onTap: onTapSubtract,
          child: Container(
            height: AppConfig(context).appHeight(4),
            width: AppConfig(context).appHeight(4),
            decoration: BoxDecoration(
                color: AppColors().colorPrimary(1),
                borderRadius:
                    BorderRadius.circular(AppConfig(context).appHeight(0.5))),
            child: Center(
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: AppConfig(context).appHeight(2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getRowData(int index, List<Itemslist> partyNameModelList) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "${partyNameModelList[index].itemName}",
              style: GoogleFonts.inter(
                  color: AppColors().textColor(1),
                  fontSize:
                      14,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            width: AppConfig(navigatorKey.currentState!.context).appWidth(2),
          ),
          SizedBox(
            width: AppConfig(navigatorKey.currentState!.context).appWidth(37),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    children: [
                      Text(
                        "${partyNameModelList[index].onRecieveQty}",
                        style: GoogleFonts.inter(
                            color: AppColors().textColor(1),
                            fontSize: AppConfig(navigatorKey.currentState!.context)
                                .appWidth(4),
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(width: 3,),
                      Text(
                        "${partyNameModelList[index].unit}",
                        style: GoogleFonts.inter(
                            color: AppColors().textColor(1),
                            fontSize: AppConfig(navigatorKey.currentState!.context)
                                .appWidth(4),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget callListAddItem(String? quT, BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          "Enter Quantity",
          style: GoogleFonts.inter(
              color: AppColors().accentColor(1),
              fontSize: AppConfig(context).appWidth(4)),
        ),
        const SizedBox(
          height: 15,
        ),
        CreateInwardElement().QuantityAddSubWidget(context,
            controller: textControllers["$index"], onTapAdd: () {
          if (textControllers["$index"]!.text.isNotEmpty) {
            if (int.parse(textControllers["$index"]!.text) > 0 &&
                int.parse(textControllers["$index"]!.text) < int.parse(quT!)) {
              {
                textControllers["$index"]!.text =
                    (int.parse(textControllers["$index"]!.text) + 1).toString();
              }
            }
          }
        }, onTapSubtract: () {
          if (textControllers["$index"]!.text.isNotEmpty) {
            if (int.parse(textControllers["$index"]!.text) > 0 &&
                int.parse(textControllers["$index"]!.text) < int.parse(quT!)) {
              textControllers["$index"]!.text =
                  (int.parse(textControllers["$index"]!.text) - 1).toString();
            }
          }
        }),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget getListViewData(String? qnT) {
    print("call here data getListViewData");
    return BlocBuilder<InwardDetailsCubit, InwardDetailsState>(
        builder: (context, state) {
      return Visibility(
          visible: state.isAddRackVisible,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: state.isAddRackCount,
              itemBuilder: (context, index) {
                print("call herre data acall");
                return callListAddItem(
                    qnT, navigatorKey.currentState!.context, index);
              }));
    });
  }

  Widget getIteamListData(
      var partyNameModelList, int index, BuildContext context, var itemslist) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12, width: 1)),
      child: Column(
        children: [
          const SizedBox(height: 23),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Item Quantity",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: AppColors().accentColor(1),
                    fontSize: AppConfig(context).appWidth(4)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Text(
                  "${itemslist![0].itemQuantity}",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      color: AppColors().accentColor(1),
                      fontSize: AppConfig(context).appWidth(4)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 23),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select Rack",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: AppColors().accentColor(1),
                    fontSize: AppConfig(context).appWidth(4)),
              ),
            ],
          ),
          DropdownButton2<RackData>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: partyNameModelList!
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        "${item.locationName}",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: partyNameModelList![0],
            onChanged: (value) {
              //   myDateSetter(value!);
            },
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.zero,
              // height: 40,
              width: AppConfig(context).appWidth(100),
            ),
            iconStyleData: IconStyleData(
                icon: Padding(
              padding: EdgeInsets.all(AppConfig(context).appWidth(2)),
              child: Icon(
                Icons.keyboard_arrow_down_sharp,
                color: AppColors().colorPrimary(1),
                size: AppConfig(context).appWidth(9),
              ),
            )),

            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                //  textEditingController.clear();
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Enter Quantity",
            style: GoogleFonts.inter(
                color: AppColors().accentColor(1),
                fontSize: AppConfig(context).appWidth(4)),
          ),
          const SizedBox(
            height: 15,
          ),
          CreateInwardElement().QuantityAddSubWidget(context,
              controller: quantityController, onTapAdd: () {
                if (quantityController.text.isNotEmpty &&
                    int.parse("${itemslist[0].itemQuantity}")! >
                        int.parse("${quantityController.text}")) {
                  quantityController.text =
                      (int.parse(quantityController.text) + 1).toString();
                }
                else {
                  Fluttertoast.showToast(msg: "You Can Not Increase");
                }
              }, onTapSubtract: () {
                if (quantityController.text.isNotEmpty) {
                  if (int.parse(quantityController.text) > 0) {
                    quantityController.text =
                        (int.parse(quantityController.text) - 1).toString();
                  }
                }
              }),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
