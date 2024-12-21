import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../model/add_package_model.dart';
import '../../../model/party_name_model.dart';

class PackageDropDown extends StatelessWidget {
  PackageDropDown(
      {Key? key,
        this.packageTypeNameList,
        this.selectedPackageName,
        required this.textEditingController,
        required this.myDateSetter})
      : super(key: key);

  final List<PackageTypeList>? packageTypeNameList;
  final PackageTypeList? selectedPackageName;
  final ValueChanged<PackageTypeList> myDateSetter;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          width: AppConfig(context).appWidth(100),
          child: DropdownButton2<PackageTypeList>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: packageTypeNameList!
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item.name!,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
                .toList(),
            value: selectedPackageName,
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
                return item.value!.name.toString().toLowerCase().contains(searchValue.toLowerCase());
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),


        ),
      ],
    );
  }
}
