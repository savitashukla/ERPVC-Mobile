import 'package:erpvc/model/inventory_list.dart';
import 'package:erpvc/model/inventory_list.dart';
import 'package:erpvc/pages/inventory/view/inventory_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../model/inventory_list.dart';
import '../../../model/inventory_list.dart';
import '../../../model/inventory_list.dart';
import '../../../model/inventory_list.dart';
import '../../../repos/authentication_repository.dart';

class InventoryElements {
  static final InventoryElements _createInwardElement =
  InventoryElements.instance();

  factory InventoryElements() {
    return _createInwardElement;
  }

  InventoryElements.instance();

  Widget appBar(context,) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppConfig(context).appWidth(1)),
              bottomRight: Radius.circular(AppConfig(context).appWidth(1)))),
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
                  "Inventory",
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
    );
  }

  Widget InventoryListMethod(InventoryList? inventoryList) {
    return Expanded(
      child: ListView.separated(shrinkWrap: true,itemCount:inventoryList!.data!.length ,physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: ()
            {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>InventoryDetails(inventoryListDe:inventoryList!.data![index]))) ;
            },
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Inward No: 1235",
                          style: GoogleFonts.inter(
                              color:  AppColors().textColor(1),
                              fontSize: AppConfig(context).appWidth(4.5),
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(width: AppConfig(context).appWidth(2),),
                        Icon(Icons.warning,color: Color(0xFFDC1919),size: AppConfig(context).appWidth(4),)
                      ],
                    ),
                    Text(
                      "14/09/2023",
                      style: GoogleFonts.inter(
                          color: AppColors().textColor(1),
                          fontSize: AppConfig(context).appWidth(3.5),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: AppConfig(context).appHeight(1),),
                Text(
                  "Real Gas Chemical Pvt. Ltd",
                  style: GoogleFonts.inter(
                      color: AppColors().textColor(1),
                      fontSize: AppConfig(context).appWidth(3.5),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: AppConfig(context).appHeight(1),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "No of Prodcuts",
                      style: GoogleFonts.inter(
                          color:  AppColors().textColor(1),
                          fontSize: AppConfig(context).appWidth(3.5),
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "View Details",
                      style: GoogleFonts.inter(

                          color: AppColors().colorPrimary(1),
                          fontSize: AppConfig(context).appWidth(4.5),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          );

        },
        separatorBuilder: (context,index){
          return Column(
            children: [
              Divider(color: AppColors().textColor(1),),
              SizedBox(height: AppConfig(context).appHeight(2),)
            ],
          );
        },),
    );
  }
}
