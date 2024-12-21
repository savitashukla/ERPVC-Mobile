import 'package:erpvc/app.dart';
import 'package:erpvc/pages/inventory/cubit/inventory_cubit.dart';
import 'package:erpvc/pages/inventory/view/inventory_second_view.dart';
import 'package:erpvc/repos/inventory_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../helper/app_config.dart';
import '../elements/inventory_elements.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (context) => InventoryCubit(),
        child: const InventoryListViewSec(),
      );
    });
  }

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  InventoryCubit? createStoriesCubit;

  final TextEditingController testController =
  TextEditingController(text: "");


  @override
  void initState() {
    // TODO: implement initState
    super.initState();



    getApiData();



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<InventoryCubit, InventoryState>(
        builder: (context,state) {
          return SafeArea(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: AppConfig(context).appHeight(3)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppConfig(context).appHeight(2),
                  ),
                  InventoryElements().appBar(
                    context,
                  ),
                  SizedBox(
                    height: AppConfig(context).appHeight(3),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: AppConfig(context).appWidth(75),
                        height:AppConfig(context).appHeight(5),
                        child: TextFormField(
                          controller: testController,
                          decoration:   InputDecoration(prefixIcon: Icon(Icons.search),
                            prefixIconConstraints: BoxConstraints( maxWidth: AppConfig(context).appWidth(15),

                            ),
                            hintText: "Search by party, Inward ID",
                          ),
                        ),
                      ),
                      SizedBox(
                        child: SvgPicture.asset("assets/img/Filter.svg"),
                      ),

                    ],
                  ),
                  SizedBox(
                    height: AppConfig(context).appHeight(2),
                  ),
               state.isProcessing?   InventoryElements().InventoryListMethod(state.inventoryList):const Center(
                 child: SizedBox(
                   height: 30,
                   width: 30,
                   child: CircularProgressIndicator(),
                 ),
               )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  Future<void> getApiData() async {
    createStoriesCubit = context.read<InventoryCubit>();
    createStoriesCubit!.paginationCurrentPage(5);
    //var mapData={"keywords":"${testController.text}"};
    await createStoriesCubit!.getInventoryList(currentPage:20);

  }
}
