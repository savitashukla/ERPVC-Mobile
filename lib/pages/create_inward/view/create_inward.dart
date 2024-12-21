import 'dart:io';

import 'package:erpvc/helper/app_config.dart';
import 'package:erpvc/helper/helper.dart';
import 'package:erpvc/helper/route_arguments.dart';
import 'package:erpvc/pages/create_inward/cubit/inward_create_cubit.dart';
import 'package:erpvc/pages/create_inward/elements/create_inward_elements.dart';
import 'package:erpvc/pages/create_inward/elements/create_inward_page1.dart';
import 'package:erpvc/pages/create_inward/elements/create_inward_page2.dart';
import 'package:erpvc/repos/inventory_repo.dart';
import 'package:erpvc/repos/user_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../repos/authentication_repository.dart';

class CreateInwardPage extends StatefulWidget {
  CreateInwardPage({Key? key, this.routeArguments}) : super(key: key);
  RouteArguments? routeArguments;

  static Route route(RouteArguments? routeArguments) {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (context) => InwardCreateCubit(
            inventoryRepo: context.read<InventoryRepo>(),
            authenticationRepository: context.read<AuthenticationRepository>(),
            userRepository: context.read<UserRepository>(),
            routeArguments: routeArguments),
        child: CreateInwardPage(
          routeArguments: routeArguments,
        ),
      );
    });
  }

  @override
  State<CreateInwardPage> createState() => _CreateInwardPageState();
}

class _CreateInwardPageState extends State<CreateInwardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<InwardCreateCubit, InwardCreateState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                CreateInwardElement().appBar(context,
                    invoiceNo: "${state.invoiceNo!}",
                    currentProgressStep: state.selectedPage == 1 ? 1 : 2,
                    title: widget.routeArguments!.fromScreen == "Edit Entry"
                        ? "Edit Entry"
                        : "New Entry"),
                Expanded(
                  child: SingleChildScrollView(
                      child: Padding(
                    padding: EdgeInsets.only(
                        bottom: AppConfig(context).appHeight(5)),
                    child: state.selectedPage == 1
                        ? CreateInwardPageFirst(
                      routeArguments: widget.routeArguments,
                      //     key: Key(state.hashCode.toString()),
                    )
                        : CreateInwardPage2(
                      routeArguments: widget.routeArguments,
                    )
                  )),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: BlocBuilder<InwardCreateCubit, InwardCreateState>(
          builder: (context, state) {
            return Container(
              height: AppConfig(context).appHeight(8),
              width: AppConfig(context).appWidth(80),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: AppConfig(context).appWidth(40),
                    child: Helper.commonButton(
                        context: context,
                        onTap: () {
                          if (state.selectedPage == 1) {
                            context.read<InwardCreateCubit>().onClearTap();
                          } else {
                            context
                                .read<InwardCreateCubit>()
                                .onChangePage(page: 1);
                          }
                        },
                        label: state.selectedPage == 1 ? "Clear" : "Back",
                        backgroundColor: Colors.white,
                        textColor: AppColors().colorPrimary(1),
                        borderColor: AppColors().colorPrimary(1)),
                  ),
                  SizedBox(
                    width: AppConfig(context).appWidth(2),
                  ),
                  SizedBox(
                      width: AppConfig(context).appWidth(40),
                      child: Helper.commonButton(
                        context: context,
                        isLoading: state.createInwardStatus ==
                            FormzSubmissionStatus.inProgress,
                        onTap: () async {
                          if (state.selectedPage == 1) {
                            if (state.validationStatus &&
                                state.selectedParty != null &&
                                state.inwardCreateSubCubitList.isNotEmpty &&
                                state.inwardCreateSubCubitList.first.state
                                        .uploadedDocName !=
                                    null) {
                              context
                                  .read<InwardCreateCubit>()
                                  .onChangePage(page: 2);
                            } else {
                              Helper.showToast(
                                  "Please fill all the mendatory fields and attach docs");
                            }
                          } else {
                            if (state.inwardItemSubCubitList.isNotEmpty) {
                              context.read<InwardCreateCubit>().createInward();
                            } else {
                              Helper.showToast("Please add atleast one item");
                            }
                          }
                        },
                        label: state.selectedPage == 1 ? "Next" : "Save",
                        backgroundColor: AppColors().colorPrimary(1),
                        textColor: Colors.white,
                        borderColor: Colors.white,
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
