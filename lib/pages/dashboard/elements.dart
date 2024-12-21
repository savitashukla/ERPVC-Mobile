import 'package:erpvc/model/inword_model.dart';
import 'package:erpvc/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:erpvc/pages/inward_details/view/inward_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper/app_config.dart';
import '../../helper/helper.dart';
import '../../repos/authentication_repository.dart';
import '../add_to_rack/cubit/add_to_rack_cubit.dart';
import '../create_inward/cubit/inward_create_cubit.dart';
import '../inward_details/cubit/inward_details_cubit.dart';

class DashboardElements {
  static final DashboardElements _createInwardElement =
      DashboardElements.instance();

  TextEditingController dateControllerEnd = TextEditingController();
  TextEditingController dateControllerStart = TextEditingController();
  TextEditingController searchController = TextEditingController();

  DashboardCubit? createStoriesCubit;

  factory DashboardElements() {
    return _createInwardElement;
  }

  DashboardElements.instance();

  Widget appBar(
    context, {
    String? invoiceNo,
  }) {
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
            padding:
                EdgeInsets.symmetric(vertical: AppConfig(context).appWidth(4)),
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
                          context
                              .read<AuthenticationRepository>()
                              .showAlertDialog(context);
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "assets/img/logout.svg",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Center(
                        child: Text(
                          "Home",
                          style: GoogleFonts.inter(
                              color: AppColors().colorPrimary(1),
                              fontSize: AppConfig(context).appWidth(6),
                              fontWeight: FontWeight.w600),
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
      String? dateNo,
      Key? key,
      TextEditingController? textEditingController}) {
    return TextFormField(
      key: key,
      controller: textEditingController,
      readOnly: true,
      onTap: () {
        showDatePicker(
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
                    primary: AppColors().colorPrimary(1), // button text color
                  ),
                ),
              ),
              child: child!,
            );
          },
        ).then((value) {
          if (value != null) {
            // textEditingController.text=value;
            print("select date$value");
            myDateSetter(value);
          }
        });
      },
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: AppConfig(context).appHeight(3)),
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
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 20,
            bottom: 2,
          ),
          child: SizedBox(
            child: SvgPicture.asset(
              'assets/img/calendar.svg',
            ),
          ),
        ),
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
    );
  }

  Widget DashboardProductList(
      List<InwardData>? inwardData, bool? racksCreatePer) {
    return inwardData != null && inwardData!.isNotEmpty
        ? ListView.separated(
            shrinkWrap: true,
            itemCount: inwardData!.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Inward No: ${inwardData[index].inwardNo}",
                            style: GoogleFonts.inter(
                                color: AppColors().textColor(1),
                                fontSize: AppConfig(context).appWidth(4.5),
                                fontWeight: FontWeight.w600),
                          ),
                          racksCreatePer!
                              ? inwardData[index].rackflag == 0
                                  ? Text(
                                      "*",
                                      style: GoogleFonts.inter(
                                          color: AppColors().textColor(1),
                                          fontSize:
                                              AppConfig(context).appWidth(4),
                                          fontWeight: FontWeight.w600),
                                    )
                                  : SizedBox(height: 0)
                              : SizedBox(height: 0)
                        ],
                      ),
                      Text(
                        Helper().getFormatedDateHour(inwardData[index].createdAt),
                        //   "${DateFormat('yyyy-MM-dd').parse("${inwardData[index].createdAt}")} ",
                        style: GoogleFonts.inter(
                            color: AppColors().textColor(1),
                            fontSize: AppConfig(context).appWidth(3.5),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppConfig(context).appHeight(1),
                  ),
                  Text(
                    inwardData[index].partyname ?? "---",
                    style: GoogleFonts.inter(
                        color: AppColors().textColor(1),
                        fontSize: AppConfig(context).appWidth(3.5),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: AppConfig(context).appHeight(1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${inwardData[index].no_of_products}",
                        style: GoogleFonts.inter(
                            color: AppColors().textColor(1),
                            fontSize: AppConfig(context).appWidth(3.5),
                            fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                      //    context.read<AddToRackCubit>()!.isProgressBar(false);
                          context.read<InwardDetailsCubit>()!.getRackAssignFastTime(false);

                          context.read<AddToRackCubit>()!.onInputDataChangeSetEmpty();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InwardDetails(
                                        inwardData[index].id,
                                      )));
                        },
                        child: Text(
                          "View Details",
                          style: GoogleFonts.inter(
                              color: AppColors().colorPrimary(1),
                              fontSize: AppConfig(context).appWidth(4.5),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: AppColors().textColor(1),
              );
            },
          )
        : const SizedBox();
  }

/* void showBottomSheetFilterDash(
    BuildContext context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                right: 20,
                left: 20,
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
                          "Filter",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: AppColors().accentColor(1),
                              fontSize: AppConfig(context).appWidth(4)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Search",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: AppColors().accentColor(1),
                            fontSize: AppConfig(context).appWidth(4)),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: AppConfig(context).appHeight(5),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            searchController.text = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.search),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              maxWidth: AppConfig(context).appWidth(15),
                            ),
                            hintText: "Search",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Start Date",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors().colorPrimary(1),
                                  fontSize: AppConfig(context).appWidth(4)),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "End Date",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors().colorPrimary(1),
                                    fontSize: AppConfig(context).appWidth(4)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: DashboardElements().dateFieldCommon(
                            context: context,
                            myDateSetter: (DateTime? value) {
                              dateControllerStart!.text =
                                  DateFormat('yyyy-MM-dd').format(value!);
                            },
                            dateNo:
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            textEditingController: dateControllerStart,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: DashboardElements().dateFieldCommon(
                            context: context,
                            dateNo: dateControllerStart!.text,
                            myDateSetter: (DateTime? value) {
                              dateControllerEnd!.text =
                                  DateFormat('yyyy-MM-dd').format(value!);
                            },
                            textEditingController: dateControllerEnd,
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Helper.commonButton(
                                context: context,
                                onTap: () {
                                  dateControllerEnd.text = "";
                                  dateControllerStart.text = "";
                                  searchController.text = "";

                                  Navigator.pop(
                                      navigatorKey.currentState!.context);
                                },
                                label: "Discord",
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
                                  createStoriesCubit =
                                      context.read<DashboardCubit>();
                                  createStoriesCubit!.getInwardList(
                                      dateControllerStart.text,
                                      dateControllerEnd.text,
                                      searchController.text);
                                  Navigator.pop(
                                      context);
                                },
                                label: "Save",
                                backgroundColor: AppColors().colorPrimary(1),
                                textColor: Colors.white,
                                borderColor: Colors.white,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }*/
}
