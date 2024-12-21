import 'package:erpvc/pages/add_to_rack/cubit/add_to_rack_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../helper/app_config.dart';
import '../../../../repos/authentication_repository.dart';

class AddToRackElements {
  static final AddToRackElements _createInwardElement =
      AddToRackElements.instance();

  factory AddToRackElements() {
    return _createInwardElement;
  }



  AddToRackElements.instance();

  Widget appBar(
    context, {
    String? invoiceNo,
  }) {
    return BlocBuilder<AddToRackCubit, AddToRackState>(
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
            child: Column(
              children: [
                Row(
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
                    SizedBox(
                      width: AppConfig(context).appWidth(10),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

/*  Widget QuantityAddSubWidget(BuildContext context,
      {VoidCallback? onTapAdd,
      VoidCallback? onTapSubtract,
      TextEditingController? controller}) {
    return BlocBuilder<AddToRackCubit, AddToRackState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: onTapAdd,
              child: Container(
                height: AppConfig(context).appHeight(4),
                width: AppConfig(context).appHeight(4),
                decoration: BoxDecoration(
                    color: AppColors().colorPrimary(1),
                    borderRadius: BorderRadius.circular(
                        AppConfig(context).appHeight(0.5))),
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: TextFormField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  maxLength: 4,
                  onChanged: (value) {

                    myValueSetter(value);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                  decoration: InputDecoration(counterText: ""),
                ),
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
                    borderRadius: BorderRadius.circular(
                        AppConfig(context).appHeight(0.5))),
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
      },
    );
  }*/
}
