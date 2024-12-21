import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../helper/app_constant.dart';
import '../../../helper/helper.dart';
import '../../../model/inventory_list.dart';
import '../cubit/inventory_cubit.dart';
import '../elements/inventory_elements.dart';
import 'inventory_details.dart';

class InventoryListViewSec extends StatefulWidget {
  const InventoryListViewSec({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (context) => InventoryCubit(),
        child: const InventoryListViewSec(),
      );
    });
  }

  @override
  State<InventoryListViewSec> createState() => _InventoryListViewSecState();
}

class _InventoryListViewSecState extends State<InventoryListViewSec> {
  InventoryCubit? createStoriesCubit;
  var scrollcontroller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //walletCubit = context.read<WalletCubit>();
    createStoriesCubit = context.read<InventoryCubit>();
    getApiData();
    scrollcontroller.addListener(() {
      if (scrollcontroller.position.atEdge &&
          scrollcontroller.position.pixels != 0) {
        if (createStoriesCubit!.state.totalLimit >
            createStoriesCubit!.state.currentPage) {
          print("check datta call ${createStoriesCubit!.state.currentPage}");
          createStoriesCubit!.getInventoryList(
              currentPage: createStoriesCubit!.state.currentPage + 10);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: BlocBuilder<InventoryCubit, InventoryState>(
          builder: (context, state) {
        return SingleChildScrollView(
          controller: scrollcontroller,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25,),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: AppConfig(context).appHeight(2),
                    ),
                    InventoryElements().appBar(
                      context,
                    ),
                    SizedBox(
                      height: AppConfig(context).appHeight(2),
                    ),
                    state.isProcessing
                        ? state.dataInventoryListArray!.isNotEmpty
                            ? ListView.builder(
                                itemCount: state.dataInventoryListArray!.length,
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return listInventory(
                                      state.dataInventoryListArray, index);
                                })
                            : Center(
                                child: Text('No Data Found',
                                    style: GoogleFonts.roboto(
                                        fontSize:
                                            AppConfig(context).appWidth(4.0),
                                        color: AppColors().colorPrimary(1),
                                        fontWeight: FontWeight.w700)),
                              )
                        : const Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          )
                  ],
                ),
               /* Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Helper.commonButton(
                            context: context,
                            onTap: () {
                              Navigator.pop(context);
                            },
                            label: "Back",
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
                            onTap: () async {},
                            label: "Save Note",
                            backgroundColor: AppColors().colorPrimary(1),
                            textColor: Colors.white,
                            borderColor: Colors.white,
                          )),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        );
      }),
    ));
  }

  Widget listInventory(List<DataInventory>? data, int index) {
    String name = "${AppConstant.image_url}${data![index].id}";
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    InventoryDetails(inventoryListDe: data![index])));
      },
      child: Container(
        height: 63,
        margin: const EdgeInsets.only(bottom: 5, top: 5, right: 4, left: 4),
        padding:
            const EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors().colorPrimaryLightS(1),
            border: Border.all(width: 1, color: AppColors().colorPrimary(1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                data![index].fileName != null
                    ? data![index].fileName != ""
                        ? Container(
                            padding: const EdgeInsets.only(
                                right: 10, bottom: 5, top: 5),
                            child: Image.network(
                              "$name/${data![index].fileName}",
                              height: 43,
                              width: 43,
                            ),
                          )
                        : const SizedBox(
                            height: 43,
                            width: 43,
                          )
                    : const SizedBox(
                        height: 43,
                        width: 43,
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    data![index].pname!.length > 15
                        ? Text(
                            data![index].pname!.substring(0, 15),
                            style: GoogleFonts.inter(
                                color: AppColors().accentColor(1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )
                        : Text(
                            "${data![index].pname}",
                            style: GoogleFonts.inter(
                                color: AppColors().accentColor(1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                    data![index].pdescription != null &&
                            data![index].pdescription!.length > 7
                        ? Text(
                            data![index].pdescription!.substring(0, 7),
                            style: GoogleFonts.inter(
                                color: AppColors().accentColor(1),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        : Text(
                            "${data![index].pdescription}",
                            style: GoogleFonts.inter(
                                color: AppColors().accentColor(1),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                  ],
                ),
              ],
            ),
            Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "In Stock",
                  style: GoogleFonts.inter(
                      color: AppColors().accentColor(1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "${data![index].quantity ?? 0}",
                  style: GoogleFonts.inter(
                      color: AppColors().accentColor(1),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getApiData() async {
    await createStoriesCubit!.getInventoryList(currentPage: 14);
  }
}
