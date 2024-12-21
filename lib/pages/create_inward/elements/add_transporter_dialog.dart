import 'package:cached_network_image/cached_network_image.dart';
import 'package:erpvc/model/product_list_model.dart';
import 'package:erpvc/pages/create_inward/elements/party_dropdown.dart';
import 'package:erpvc/pages/create_inward/elements/product_list_dropdown.dart';
import 'package:erpvc/pages/create_inward/elements/unit_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../helper/app_config.dart';
import '../../../helper/helper.dart';
import '../../../repos/authentication_repository.dart';
import '../cubit/inward_create_cubit.dart';
import 'create_inward_elements.dart';

class AddTransporter extends StatefulWidget {
  AddTransporter({Key? key, this.onAccept}) : super(key: key);
  Function? onAccept;

  @override
  _AddTransporterState createState() => _AddTransporterState();
}

class _AddTransporterState extends State<AddTransporter> {
  final TextEditingController nameController =
      TextEditingController();
  final TextEditingController addressController =
      TextEditingController();
  final TextEditingController numberController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InwardCreateCubit, InwardCreateState>(
      builder: (context, state) {
        return state.productsListStatus.isInProgress
            ? SizedBox(
                width: AppConfig(context).appWidth(100),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                )))
            : AlertDialog(
                insetPadding: const EdgeInsets.all(10),
                contentPadding: const EdgeInsets.all(0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                content: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppConfig(context).appHeight(1)),
                    child: Container(
                      width: AppConfig(context).appWidth(100),
                      padding: EdgeInsets.all(AppConfig(context).appHeight(1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              navigatorKey.currentState!.pop();
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                  height: AppConfig(context).appHeight(3),
                                  width: AppConfig(context).appHeight(3),
                                  child: Icon(Icons.close)),
                            ),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          SizedBox(
                            width: AppConfig(context).appWidth(100),
                            child: CreateInwardElement().textFieldCommon(
                                labelTittle: "Name *",
                                textColor: AppColors().textColor(0),
                                textEditingController:
                                    nameController,
                                context: context),
                          ),
                          SizedBox(
                            height: AppConfig(context).appWidth(2),
                          ),
                          SizedBox(
                            width: AppConfig(context).appWidth(100),
                            child: CreateInwardElement().textFieldCommon(
                                labelTittle: "Address",
                                textColor: AppColors().textColor(0),
                                textEditingController:
                                    addressController,
                                context: context),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          SizedBox(
                            width: AppConfig(context).appWidth(100),
                            child: CreateInwardElement().textFieldCommon(
                                labelTittle: "Transport Number",
                                textColor: AppColors().textColor(0),
                                textEditingController:
                                    numberController,
                                context: context),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          SizedBox(
                            width: AppConfig(context).appWidth(100),
                            child: CreateInwardElement().textFieldCommon(
                                labelTittle: "City",
                                textColor: AppColors().textColor(0),
                                textEditingController: cityController,
                                context: context),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          SizedBox(
                            width: AppConfig(context).appWidth(100),
                            child: CreateInwardElement().textFieldCommon(
                                labelTittle: "State",
                                textColor: AppColors().textColor(0),
                                textEditingController: stateController,
                                context: context),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          SizedBox(
                            width: AppConfig(context).appWidth(100),
                            child: CreateInwardElement().textFieldCommon(
                                labelTittle: "Zip code",
                                textColor: AppColors().textColor(0),
                                textEditingController: zipCodeController,
                                context: context),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          SizedBox(
                            width: AppConfig(context).appWidth(100),
                            child: CreateInwardElement().textFieldCommon(
                                labelTittle: "country",
                                textColor: AppColors().textColor(0),
                                textEditingController: countryController,
                                context: context),
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Helper.commonButton(
                                    context: context,
                                    onTap: () {


                                      navigatorKey.currentState!.pop();


                                    },
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
                                    isLoading: state.addTransporterStatus!.isInProgress,
                                    onTap: () async{
                                      if(nameController.text.trim().isNotEmpty){
                                        await context.read<InwardCreateCubit>().addTransporter(transporterData: {
                                          "name":nameController.text,
                                          "address":addressController.text,
                                          "number":numberController.text,
                                          "city":cityController.text,
                                          "state":stateController.text,
                                          "zip_code":zipCodeController.text,
                                          "country":countryController.text
                                        });
                                        navigatorKey.currentState!.pop();
                                      }
                                      else{
                                        Helper.showToast("Please Enter Transporter Name");
                                      }
                                      },
                                    label: "Save",
                                    backgroundColor:
                                        AppColors().colorPrimary(1),
                                    textColor: Colors.white,
                                    borderColor: Colors.white,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
