import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_config.dart';

class Helper {
  static Helper helper = Helper.instance();

  factory Helper() {
    return helper;
  }

  Helper.instance();

  static void showToast(dynamic message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER);
  }

  Future<void> storeDataRacksCreatePer(var racksCreate) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("racksCreate", racksCreate);
  }

  Future<bool> getDataRacksPer() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("racksCreate") != null) {
      bool? racksCreateV = prefs.getBool("racksCreate");
      return racksCreateV!;
    } else {
      return false;
    }
  }

  void setGateKeeperPermission(bool? gatekeeper) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("gatekeeper", gatekeeper!);
  }

  void setStoreKeeperPermission(bool? storekeeper) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("storekeeper", storekeeper!);
  }

  Future<bool> getGateKeeperPermission() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("gatekeeper") != null) {
      bool? racksCreateV = prefs.getBool("gatekeeper");

      print("racksCreateV $racksCreateV");
      return racksCreateV!;
    } else {
      return false;
    }
  }

  Future<bool> getStoreKeeperPermission() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("storekeeper") != null) {
      bool? racksCreateV = prefs.getBool("storekeeper");
      return racksCreateV!;
    } else {
      return false;
    }
  }

  Future<void> storeDataEntryEditDPer(var racksCreate) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("data_entry_edit", racksCreate);
  }

  Future<bool> getDataEntryEditDPer() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("data_entry_edit") != null) {
      bool? racksCreateV = prefs.getBool("data_entry_edit");
      return racksCreateV!;
    } else {
      return false;
    }
  }

  static commonButton(
      {String? label,
      BuildContext? context,
      VoidCallback? onTap,
      Color? textColor,
      bool isLoading = false,
      Color? backgroundColor,
      Color? borderColor}) {
    return ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
          return backgroundColor /*AppColors().colorPrimary(1)*/;
        }), side: MaterialStateProperty.resolveWith((states) {
          return BorderSide(
            color: borderColor!,
          );
        })),
        child: Padding(
          padding: EdgeInsets.all(AppConfig(context!).appWidth(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isLoading
                  ? SizedBox(
                      height: AppConfig(context!).appWidth(6),
                      width: AppConfig(context!).appWidth(6),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors().colorWhite(1),
                      ))
                  : Text(
                      "$label",
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: AppConfig(context).appWidth(4)),
                    )
            ],
          ),
        ));
  }

  getFormatedDate(date) {
    try {
      var inputFormat = DateFormat('dd-MM-yyyy HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('dd-MM-yyyy HH:mm');
      return outputFormat.format(inputDate);
    } catch (E) {
      /* DateTime date1 = DateTime.parse(date);
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      return formatter.format(date1);*/

      var inputFormat = DateFormat('yyyy-MM-DD');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('dd-MM-yyyy');
      return outputFormat.format(inputDate);
    }
  }

  getFormatedDateHour(date) {
    /*  try {
      var inputFormat = DateFormat('dd-MM-yyyy HH:mm');
      var inputDate = inputFormat.parse(date);
      var outputFormat = DateFormat('dd-MM-yyyy');
      return outputFormat.format(inputDate);
    } catch (E) {*/

    DateTime inputDate = DateTime.parse(date);

    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(inputDate);
    print(formattedDate);

    return formattedDate;


  }

/* getDdMmYear(date) {
    var inputFormat = DateFormat('dd-MM-yyy');
    var inputDate = inputFormat.parse(date);
    var outputFormat = DateFormat('dd-MM-yyyy');
    return outputFormat.format(inputDate);
  }*/
/*
  String getDdMmYear(String dateStr) {
    // Parse the input date string
    DateTime date = DateTime.parse(dateStr!);

    // Create a date format
    final DateFormat formatter = DateFormat('dd-MM-yyyy');

    // Format the date and return as a string
    return formatter.format(date);
  }*/

/*   getDdMmYear(inputDate) {
     var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
     var inputDate = inputFormat.parse(inputDate!);
     var outputFormat = DateFormat('dd-MM-yyyy');
     return outputFormat.format(inputDate);
  }*/
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime selectedDateTime = DateTime.now();

  DateTime? picked;

  Future<void> _selectDateTime(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then((value) {
      if (value != null) {
        picked = value;
        print(value);
        //   myDateSetter(value);
      }
    });

    if (picked != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (selectedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked!.year,
            picked!.month,
            picked!.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Date and Time Picker Example'),
        ),
        body: Container(
          height: 0,
        ),
      ),
    );
  }
}
