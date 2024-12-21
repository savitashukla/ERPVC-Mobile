import 'package:erpvc/helper/route_arguments.dart';
import 'package:erpvc/model/product_list_model.dart';
import 'package:erpvc/pages/create_inward/cubit/inward_item_subcubit/inward_item_sub_cubit.dart';
import 'package:erpvc/pages/create_inward/cubit/sub_cubit/inward_create_sub_cubit.dart';
import 'package:erpvc/pages/create_inward/elements/search_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/app_config.dart';
import '../../../helper/helper.dart';
import '../../../model/inward_deatils_model_data.dart';
import '../../../repos/authentication_repository.dart';
import '../cubit/inward_create_cubit.dart';
import 'create_inward_elements.dart';
import 'inward_item_dialog.dart';

class CreateInwardPage2 extends StatefulWidget {
  CreateInwardPage2({Key? key, this.routeArguments}) : super(key: key);

  RouteArguments? routeArguments;

  @override
  State<CreateInwardPage2> createState() => _CreateInwardPage2State();
}

class _CreateInwardPage2State extends State<CreateInwardPage2> {

  @override
  void initState() {

    if (widget.routeArguments!.inwardDetailsModelData != null) {
      print("on edit data ${widget.routeArguments!.inwardDetailsModelData!.data!.inwardNo}");
      context.read<InwardCreateCubit>().onEditdata(
            widget.routeArguments!.inwardDetailsModelData!.data!.itemslist!,
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InwardCreateCubit, InwardCreateState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppConfig(context).appWidth(3)),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppConfig(context).appHeight(2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConfig(context).appHeight(2)),
                  child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>QRViewExample()));
                        // showScannerDialog(context: context);
                        scanBarcodeNormal();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return AppColors().colorPrimary(1);
                        }),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppConfig(context).appWidth(4)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code,
                              color: Colors.white,
                              size: AppConfig(context).appWidth(7),
                            ),
                            SizedBox(
                              width: AppConfig(context).appWidth(3),
                            ),
                            Text(
                              "Scan QR code",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: AppConfig(context).appWidth(5),
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(5),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConfig(context).appHeight(2.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: AppConfig(context).appWidth(55),
                        child: Text(
                          "Item name",
                          style: GoogleFonts.inter(
                              color: AppColors().colorPrimary(1),
                              fontSize: AppConfig(context).appWidth(4),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: AppConfig(context).appWidth(20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Quantity",
                            style: GoogleFonts.inter(
                                color: AppColors().colorPrimary(1),
                                fontSize: AppConfig(context).appWidth(4),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(3),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppConfig(context).appHeight(2.5)),
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.inwardItemSubCubitList.length,
                    itemBuilder: (context, index) {
                      print(
                          "added products length:${state.inwardItemSubCubitList.length}");
                      return BlocProvider(
                        key: Key(state.hashCode.toString()),
                        create: (context) =>
                            state.inwardItemSubCubitList[index],
                        child:
                            BlocBuilder<InwardItemSubCubit, InwardItemSubState>(
                          builder: (context, state1) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: AppConfig(context).appWidth(55),
                                  child: Text(
                                    state1.itemslist!.itemName!,
                                    // "Item name",
                                    style: GoogleFonts.inter(
                                        color: Colors.black54,
                                        fontSize:
                                            AppConfig(context).appWidth(4),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  width: AppConfig(context).appWidth(11),
                                  child: Text(
                                    "${state1.itemslist!.onRecieveQty} ${state1.itemslist!.unit}",
                                    //"Quantity",
                                    style: GoogleFonts.inter(
                                        color: Colors.black54,
                                        fontSize:
                                            AppConfig(context).appWidth(4),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      showScannerDialog(
                                              context: context,
                                              isEdit: true,
                                              index: index,
                                              inwardItemsList: state.tempInwardItemsList,
                                              itemslist: state.inwardItemSubCubitList[index].state.itemslist)
                                          .then((value) {
                                        if (value != null || value != []) {
                                          context
                                              .read<InwardCreateCubit>()
                                              .onUpdateProducts(
                                                  itemslist: value);
                                        }
                                      }); /*.then((value) {
                                  if (value != null || value != []) {
                                    context
                                        .read<InwardCreateCubit>()
                                        .onUpdateProducts(value);
                                    print("data on pop ${state.addedProducts}");
                                  }
                                });*/
                                    },
                                    child: SizedBox(
                                        height: AppConfig(context).appWidth(6),
                                        width: AppConfig(context).appWidth(6),
                                        child: Icon(
                                          Icons.edit,
                                          size: AppConfig(context).appWidth(5),
                                          color: AppColors().colorPrimary(1),
                                        ))),
                                SizedBox(width: AppConfig(context).appWidth(3)),
                                InkWell(
                                    onTap: () {
                                      confirmDeleteItemDialog(context).then((value) {
                                        if(value){
                                          context
                                              .read<InwardCreateCubit>()
                                              .removeItemFromList(index);
                                        }
                                      });

                                    },
                                    child: SizedBox(
                                        height: AppConfig(context).appWidth(7),
                                        width: AppConfig(context).appWidth(7),
                                        child: Icon(
                                          Icons.close,
                                          color: AppColors().colorPrimary(1),
                                          size: AppConfig(context).appWidth(5),
                                        )))
                              ],
                            );
                          },
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: AppConfig(context).appHeight(2),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(3),
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(6),
                  width: AppConfig(context).appWidth(40),
                  child: ElevatedButton(
                      onPressed: () {
                        showScannerDialog(
                          context: context,
                          isEdit: false,
                          inwardItemsList: state.tempInwardItemsList
                        ).then((value) {
                          if (value != null || value != []) {
                            context
                                .read<InwardCreateCubit>()
                                .onUpdateProducts(itemslist: value);
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          return AppColors().colorPrimary(1);
                        }),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Add Items",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: AppConfig(context).appWidth(4),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(1),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future showScannerDialog(
      {BuildContext? context, bool? isEdit, Itemslist? itemslist, int? index, List<Itemslist>? inwardItemsList}) {
    return showDialog(
      context: context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return InwardItemDialog(
          itemslist: itemslist,
          isEdit: isEdit!,
          index: index,
          inwardItemsList: inwardItemsList,
        );
      },
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#3C99EF',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      print('data_scanner ${barcodeScanRes.toString()}');
      context
          .read<InwardCreateCubit>()
          .getProductList(barcodeScanNumber: barcodeScanRes)
          .then((value) {
        if (barcodeScanRes.toString() != "-1") {
          showScannerDialog(context: context);
        }
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }
  Future confirmDeleteItemDialog(BuildContext context) async {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        elevation: 24,
        content: const Text("Do you want to Delete Item?"),

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
}
