import 'package:erpvc/pages/create_inward/cubit/inward_create_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../repos/authentication_repository.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchController = TextEditingController();
int offset=0;
  @override
  void initState() {
    context.read<InwardCreateCubit>().getProductList();
    searchController.addListener(() {
      context.read<InwardCreateCubit>().onSearch(value: searchController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: BlocBuilder<InwardCreateCubit, InwardCreateState>(
          builder: (context, state) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: AppConfig(context).appHeight(80),
                width: AppConfig(context).appWidth(100),
                margin: EdgeInsets.only(
                  bottom: AppConfig(context).appHeight(10),
                  left: AppConfig(context).appWidth(5),
                  right: AppConfig(context).appWidth(5),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConfig(context).appHeight(2),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(AppConfig(context).appWidth(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            navigatorKey.currentState!.pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: AppConfig(context).appHeight(4),
                          ),
                        ),
                      ),
                      TextFormField(
                        onChanged: (_) {
                          context.read<InwardCreateCubit>().getProductList();
                        },
                        controller: searchController,
                        decoration: InputDecoration(hintText: "Search Here"),
                      ),
                      SizedBox(
                        height: AppConfig(context).appHeight(2),
                      ),
                      Expanded(
                        child: state.productsListStatus.isInProgress
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.zero,
                                itemCount: state.productListModel!.data!.length,
                                /*state.countryList!.length,*/
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return SizedBox(
                                      height:
                                          AppConfig(context).appHeight(1.5));
                                },
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      navigatorKey.currentState!.pop({
                                        /*'id': state.countryList![index].sId
                                        .toString(),*/
                                        'name': state.productListModel!
                                            .data![index].productname
                                            .toString(),
                                        'unit': state.productListModel!
                                            .data![index].unit
                                            .toString(),
                                        'id': state.productListModel!
                                            .data![index].id
                                            .toString()
                                      });
                                    },
                                    child: Container(
                                      height: AppConfig(context).appHeight(5),
                                      width: AppConfig(context).appHeight(100),
                                      child: Text(
                                        state.productListModel!.data![index]
                                            .productname!,
                                        /*state.countryList![index].name
                                        .toString()*/
                                        style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              AppConfig(context).appWidth(4.5),
                                        )),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {

                                    context.read<InwardCreateCubit>().getProductList(type: "dec",);

                                },
                                child: Container(
                                  height: AppConfig(context).appHeight(4),
                                  width: AppConfig(context).appHeight(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConfig(context).appHeight(4)),
                                    color: AppColors().colorPrimary(1),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    size: AppConfig(context).appHeight(2),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppConfig(context).appWidth(4),
                              ),
                              Text('${state.currentPage} / ${state.totalPages}',
                                  style: GoogleFonts.roboto(
                                      fontSize:
                                          AppConfig(context).appWidth(4.0),
                                      color: AppColors().colorPrimary(1),
                                      fontWeight: FontWeight.w700)),
                              SizedBox(
                                width: AppConfig(context).appWidth(4),
                              ),
                              InkWell(
                                onTap: () {

                                    context.read<InwardCreateCubit>().getProductList(type: "inc",);

                                },
                                child: Container(
                                  height: AppConfig(context).appHeight(4),
                                  width: AppConfig(context).appHeight(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        AppConfig(context).appHeight(4)),
                                    color: AppColors().colorPrimary(1),
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: AppConfig(context).appHeight(2),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
