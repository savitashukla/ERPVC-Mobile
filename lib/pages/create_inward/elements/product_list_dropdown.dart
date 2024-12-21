import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erpvc/model/product_list_model.dart';
import 'package:erpvc/pages/create_inward/cubit/inward_create_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../model/party_name_model.dart';

class ProductListDropdown extends StatelessWidget {
  ProductListDropdown({Key? key,
    this.partyNameModelList,
    this.selectedParty,
    required this.textEditingController,
    required this.myDateSetter})
      : super(key: key);

  final List<ProductData>? partyNameModelList;
  final ProductData? selectedParty;
  final ValueChanged<dynamic> myDateSetter;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InwardCreateCubit, InwardCreateState>(
      builder: (context, state) {
        return SizedBox(
          width: AppConfig(context).appWidth(100),
          child: DropdownButton2<ProductData>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme
                    .of(context)
                    .hintColor,
              ),
            ),
            items: partyNameModelList!
                .map((item) =>
                DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.productname!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                .toList(),
            value: selectedParty,
            onChanged: (value) {
              myDateSetter(value!);
            },
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.zero,
              // height: 40,
              width: AppConfig(context).appWidth(100),
            ),
            iconStyleData: IconStyleData(
                icon: Padding(
                  padding: EdgeInsets.all(AppConfig(context).appWidth(2)),
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: AppColors().colorPrimary(1),
                    size: AppConfig(context).appWidth(9),
                  ),
                )),

            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search for an item...',
                    hintStyle: const TextStyle(fontSize: 12),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors().colorPrimary(1),
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                //context.read<InwardCreateCubit>().getProductList(searchText: searchValue);

                return item.value!.productname.toString()
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),


        );
      },
    );
  }
}
