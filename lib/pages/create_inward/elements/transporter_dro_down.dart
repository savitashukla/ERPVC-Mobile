import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../model/party_name_model.dart';
import '../../../model/transporter_model.dart';

class TransporterDropDown extends StatelessWidget {
  TransporterDropDown(
      {Key? key,
        this.partyNameModelList=const[],
        this.selectedParty,
        required this.textEditingController,
        required this.myDateSetter})
      : super(key: key);

  final List<DataTransporterModel> partyNameModelList;
  final DataTransporterModel? selectedParty;
  final ValueChanged<DataTransporterModel> myDateSetter;

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          width: AppConfig(context).appWidth(100),
          child: DropdownButton2<DataTransporterModel>(
            isExpanded: true,
            hint: Text(
              'Select Item',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: partyNameModelList!
                .map((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item!.tName!,
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


          ),


        ),
      ],
    );
  }
}