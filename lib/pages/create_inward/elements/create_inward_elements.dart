import 'package:erpvc/helper/app_config.dart';
import 'package:erpvc/pages/create_inward/cubit/inward_create_cubit.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class CreateInwardElement {
  static final CreateInwardElement _createInwardElement =
      CreateInwardElement.instance();

  factory CreateInwardElement() {
    return _createInwardElement;
  }

  CreateInwardElement.instance();

  final ValueChanged<DateTime> myDateSetter = (value) {};
  final ValueChanged<String> myValueSetter = (value) {};

  Widget appBar(
    context, {
    String? invoiceNo,
    int? currentProgressStep,
    String? title,
  }) {
    return BlocBuilder<InwardCreateCubit, InwardCreateState>(
      builder: (context, state) {
        return Card(
          elevation: 1,
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
                          if (state.selectedPage == 1) {
                            navigatorKey.currentState!.pop();
                          } else {
                            context
                                .read<InwardCreateCubit>()
                                .onChangePage(page: 1);
                          }
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors().colorPrimary(1),
                          size: AppConfig(context).appWidth(5),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        title!,
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
                  height: AppConfig(context).appHeight(2),
                ),
                /* Center(
                  child: Text(
                    "Inward No: ${invoiceNo ?? ""}",
                    style: GoogleFonts.inter(
                        color: AppColors().colorPrimary(1),
                        fontSize: AppConfig(context).appWidth(4),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(2),
                ),*/
                SizedBox(
                  width: AppConfig(context).appWidth(84),
                  child: LinearProgressBar(
                    maxSteps: 2,
                    progressType: LinearProgressBar.progressTypeLinear,
                    currentStep: currentProgressStep,
                    progressColor: AppColors().colorPrimary(1),
                    backgroundColor: const Color(0xffD9D9D9),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget appBarB(context, {String? invoiceNo, int? currentProgressStep}) {
    return BlocBuilder<InwardCreateCubit, InwardCreateState>(
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
                          if (state.selectedPage == 1) {
                            navigatorKey.currentState!.pop();
                          } else {
                            context
                                .read<InwardCreateCubit>()
                                .onChangePage(page: 1);
                          }
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

  Widget dateFieldCommon(
      {required BuildContext context,
      myDateSetter,
      Key? key,
      String? labelTittle,
      TextEditingController? textEditingController}) {
    return SizedBox(height: AppConfig(context).appHeight(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$labelTittle",
            style: GoogleFonts.inter(
                color: AppColors().textColor(1),
                fontSize: AppConfig(context).appWidth(4),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AppConfig(context).appHeight(6),
            child: TextFormField(
              key: key,
              controller: textEditingController,
              readOnly: true,
              onTap: () async {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: labelTittle!.startsWith("Expiry Date")
                      ? DateTime(2030)
                      : DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: AppColors().colorPrimary(1),
                          onPrimary: Colors.white,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            primary:
                                AppColors().colorPrimary(1), // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                ).then((value) async {
                  if (value != null) {
                    //   myDateSetter(value);
                    //   picked=value;

                    if (value != null) {
                      TimeOfDay? selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: AppColors().colorPrimary(1),
                                onPrimary: Colors.white,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: AppColors()
                                      .colorPrimary(1), // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (selectedTime != null) {
                        myDateSetter(DateTime(
                          value!.year,
                          value!.month,
                          value!.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        ));
                      }
                    }
                    print(value);
                    //   myDateSetter(value);
                  }
                });

                /*  showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: AppColors().colorPrimary(1),
                          onPrimary: Colors.white,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            primary:
                                AppColors().colorPrimary(1), // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                ).then((value) {
                  if (value != null) {
                    myDateSetter(value);
                  }
                });*/
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffDC1919),
                  ),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffD3D8DD),
                  ),
                ),
                errorStyle: GoogleFonts.roboto(color: const Color(0xffDC1919)),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: SvgPicture.asset(
                    'assets/img/calendar.svg',
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 2,
                  minHeight: 2,
                ),
                contentPadding:
                    EdgeInsets.only(top: AppConfig(context).appWidth(4)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                  ),
                ),
                fillColor: Colors.transparent,
                filled: true,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffD3D8DD),
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffD3D8DD),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldCommon(
      {String? labelTittle,
      TextEditingController? textEditingController,
      TextInputType? textInputType,
      bool? readOnly,
      Color? textColor,

        Widget? suffixIcon,
      context}) {
    return SizedBox(height: AppConfig(context).appHeight(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$labelTittle",
            style: GoogleFonts.inter(
                color: textColor ?? AppColors().textColor(1),
                fontSize: AppConfig(context).appWidth(4),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: AppConfig(context).appHeight(6),
            child: TextFormField(
              controller: textEditingController,
              readOnly: readOnly ?? false,
              onChanged: (value) {
                myValueSetter(value);
              },
              textInputAction: TextInputAction.next,
              keyboardType: textInputType ?? TextInputType.emailAddress,
              decoration: InputDecoration(
                 suffixIcon: suffixIcon,
                suffixIconColor: AppColors().colorPrimary(1),

                contentPadding: EdgeInsets.zero,
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffDC1919),
                  ),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffD3D8DD),
                  ),
                ),
                errorStyle: GoogleFonts.roboto(color: const Color(0xffDC1919)),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).focusColor,
                  ),
                ),
                fillColor: Colors.transparent,
                filled: true,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffD3D8DD),
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xffD3D8DD),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget QuantityAddSubWidget(BuildContext context,
      {VoidCallback? onTapAdd,
      VoidCallback? onTapSubtract,
      VoidCallback? onChangesMe,
        bool? readOnly,
      TextEditingController? controller}) {
    return BlocBuilder<InwardCreateCubit, InwardCreateState>(
      builder: (context, state) {
        return Row(
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
              child: TextFormField(
                controller: controller,
                textAlign: TextAlign.center,
                maxLength: 4,
                readOnly: readOnly ?? false,
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
  }
}
