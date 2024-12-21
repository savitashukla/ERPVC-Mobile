import 'package:erpvc/pages/inventory/cubit/inventory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../helper/app_constant.dart';
import '../../../model/inventory_list.dart';
import '../../../repos/authentication_repository.dart';
import '../elements/inventory_elements.dart';

class InventoryDetails extends StatelessWidget {
  InventoryDetails({super.key, this.inventoryListDe});

  DataInventory? inventoryListDe;

  @override
  Widget build(BuildContext context) {
    String name = "${AppConstant.image_url}${inventoryListDe!.id}";

    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SizedBox(
            height: AppConfig(context).appHeight(2),
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppConfig(context).appWidth(1)),
                    bottomRight:
                        Radius.circular(AppConfig(context).appWidth(1)))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        navigatorKey.currentState!.pop();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors().colorPrimary(1),
                        size: AppConfig(context).appWidth(5),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Product Details",
                        style: GoogleFonts.inter(
                            color: AppColors().colorPrimary(1),
                            fontSize: AppConfig(context).appWidth(5),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: AppConfig(context).appWidth(10),
                    )
                  ],
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(0.5),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            margin: const EdgeInsets.only(bottom: 5, top: 5, right: 4, left: 4),
            padding:
                const EdgeInsets.only(bottom: 10, top: 10, right: 10, left: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors().colorPrimaryLightS(1),
                border:
                    Border.all(width: 1, color: AppColors().colorPrimary(1))),
            child: Row(
              children: [
                inventoryListDe!.fileName != null
                    ? inventoryListDe!.fileName != ""
                        ? Container(
                            padding: const EdgeInsets.only(
                                right: 10, bottom: 5, top: 5),
                            child: Image.network(
                              "$name/${inventoryListDe!.fileName}",
                              height: 120,
                              fit: BoxFit.fill,
                              width: 120,
                            ),
                          )
                        : const SizedBox(
                            height: 120,
                            width: 120,
                          )
                    : const SizedBox(
                        height: 120,
                        width: 120,
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    inventoryListDe!.pname!.length > 15
                        ? Text(
                            inventoryListDe!.pname!.substring(0, 15),
                            style: GoogleFonts.inter(
                                color: AppColors().accentColor(1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )
                        : Text(
                            "${inventoryListDe!.pname}",
                            style: GoogleFonts.inter(
                                color: AppColors().accentColor(1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                    const SizedBox(
                      height: 3,
                    ),
                    inventoryListDe!.pdescription!.length > 7
                        ? Text(
                            inventoryListDe!.pdescription!.substring(0, 10),
                            style: GoogleFonts.inter(
                                color: AppColors().accentColor(1),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        : Text(
                            "${inventoryListDe!.pdescription}",
                            style: GoogleFonts.inter(
                                color: AppColors().accentColor(1),
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      "Product Code",
                      style: GoogleFonts.inter(
                          color: AppColors().accentColor(1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Code Here....",
                      style: GoogleFonts.inter(
                          color: AppColors().accentColor(1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Text(
                      "Rack No.",
                      style: GoogleFonts.inter(
                          color: AppColors().accentColor(1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Rack no. here",
                      style: GoogleFonts.inter(
                          color: AppColors().accentColor(1),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "In Stock",
                      style: GoogleFonts.inter(
                          color: AppColors().accentColor(1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${inventoryListDe!.quantity ?? 0}",
                      style: GoogleFonts.inter(
                          color: AppColors().accentColor(1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    )));
  }
}
