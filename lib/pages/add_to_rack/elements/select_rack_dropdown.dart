import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../../../helper/app_config.dart';


class SelectRack extends StatelessWidget {
  SelectRack(
      {Key? key,
        this.listData,
        this.selectedData,
        required this.textEditingController,
        required this.myDateSetter})
      : super(key: key);

  final List<String>? listData;
  final String? selectedData;
  final ValueChanged<String> myDateSetter;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConfig(context).appWidth(35),
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: const Text(
          'Select Rack',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        items: listData!
            .map((item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ))
            .toList(),
        value: selectedData,
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
                size: AppConfig(context).appWidth(7),
              ),
            )),


        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),

      /*DropdownButton<PartyData>(
              value: selectedParty,
              icon: Padding(
                padding: EdgeInsets.only(right: AppConfig(context).appWidth(2)),
                child: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors().colorPrimary(1),
                  size: AppConfig(context).appWidth(8),
                ),
              ),
              // elevation: 16,
              isExpanded: true,
              style: TextStyle(color: AppColors().colorPrimary(1)),
              underline: Container(
                height: 1,
                color: Color(0xffD3D8DD),
              ),
              onChanged: (PartyData? value) {
                // This is called when the user selects an item.
              },

              items: partyNameModelList!
                  .map<DropdownMenuItem<PartyData>>((PartyData value) {
                return DropdownMenuItem<PartyData>(
                  value: value,
                  child: Text(value.company!),
                );
              }).toList(),
            )*/
    );
  }
}
