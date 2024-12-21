import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:erpvc/pages/add_to_rack/cubit/add_to_rack_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helper/app_config.dart';
import '../../../helper/helper.dart';
import '../../../model/inward_deatils_model_data.dart';
import '../../../model/rack_list.dart';
import '../elements/add_to_rack_elements.dart';

class AddToRack extends StatefulWidget {
  String? invoiceNo;
  String? inwardId;

  AddToRack({Key? key, this.invoiceNo, this.inwardId}) : super(key: key);

  @override
  State<AddToRack> createState() => _AddToRackState();
}

class _AddToRackState extends State<AddToRack> {
  AddToRackCubit? addRackStoriesCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addRackStoriesCubit = context.read<AddToRackCubit>();
    addRackStoriesCubit!.getProgressBar(false);
  }

  TextEditingController qunController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AddToRackCubit, AddToRackState>(
          builder: (context, state) {
        //   print("state.isAddRackVisible${state.isAddRackVisible ?? "fghjk"}");
        return SafeArea(
          child: Column(
            children: [
              AddToRackElements().appBar(
                context,
                invoiceNo: "${widget.invoiceNo}",
              ),
              Expanded(
                child: state.rackItemList != null
                    ? SingleChildScrollView(
                        child: Column(
                          children: List.generate(state.rackItemList!.length,
                              (index) {
                            return Container(
                                child: state.rackList != null
                                    ? RackIteamBox(
                                        itemData: state.rackItemList![index],
                                        racklList: state.rackList!,
                                      )
                                    : const SizedBox());
                          }),
                        ),
                      )
                    : const Center(
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Helper.commonButton(
                          context: context,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          label: "Back",
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
                          onTap: () async {
                            await addRackStoriesCubit!
                                .getAddItems(widget.inwardId!);
                          },
                          label: "Save",
                          backgroundColor: state.isProcessingVar!
                              ? Colors.green
                              : AppColors().colorPrimary(1),
                          textColor: Colors.white,
                          borderColor: Colors.white,
                        )),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void getAddListData() {}
}

class RackIteamBox extends StatefulWidget {
  final Itemslist itemData;

  final RackList? racklList;

  const RackIteamBox({
    super.key,
    required this.itemData,
    this.racklList,
  });

  @override
  State<RackIteamBox> createState() => _RackIteamBoxState();
}

class _RackIteamBoxState extends State<RackIteamBox> {
  Map<String, int> mapMainData = {};

  AddToRackCubit? addRackStoriesCubit;

  TextEditingController textControllers = TextEditingController();

  int? indexV;

  int rackCountValues = 0;

  bool? isRackAddMore = false;

  int isRackAddMoreCount = 1;
  List<Map<String, int>> enterQnt = [];
  Map<String, int> enterQnt1 = {};
  Map<String, TextEditingController> textControllersMap = Map();

  RackData? rackListPickUpData;

  int totalInputQnt = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: ExpansionTile(
        backgroundColor: AppColors().colorPrimaryLight(0),
        collapsedIconColor: AppColors().colorPrimary(0),
        collapsedShape: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors().colorPrimary(0))),
        iconColor: AppColors().colorPrimary(0),
        childrenPadding:
            EdgeInsets.symmetric(horizontal: AppConfig(context).appHeight(2)),
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${widget.itemData.itemName}",
              style: GoogleFonts.inter(
                  color: AppColors().accentColor(1),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "${widget.itemData.onRecieveQty}",
              style: GoogleFonts.inter(
                  color: AppColors().accentColor(1),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Items Left to assign",
                    style: GoogleFonts.inter(
                        color: AppColors().accentColor(1),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "${addRackStoriesCubit!.state.totalReceiveQnt!["${widget.itemData.id}"] >= 0 ? addRackStoriesCubit!.state.totalReceiveQnt!["${widget.itemData.id}"] : 0}/${widget.itemData.onRecieveQty}",
                    style: GoogleFonts.inter(
                        color: AppColors().accentColor(1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Rack",
                          style: GoogleFonts.inter(
                              color: AppColors().accentColor(1),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        getRackList(widget.racklList!.data),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Enter Quantity",
                          style: GoogleFonts.inter(
                              color: AppColors().accentColor(1),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: AppConfig(context).appHeight(0.7),
                        ),
                        QuantityAddSubWidget(
                            rackCount: rackCountValues, context, onTapAdd: () {
                          try {
                            int total = 0;
                            if (isRackAddMore!) {
                              total = enterQnt1["item_quantity"]!;
                              if (enterQnt1["item_quantity0"] != null) {
                                for (int i = 0; i < enterQnt1.length - 1; i++) {
                                  total =
                                      total + enterQnt1["item_quantity${i}"]!;
                                }
                              } else {}
                            } else {
                              total = enterQnt1!["item_quantity"] ?? 0;
                            }

                            if (enterQnt1!["item_quantity"]! >=
                                int.parse("${rackListPickUpData!.capacity}")) {
                              Fluttertoast.showToast(
                                  msg: "You can not Enter more amount bill amount");
                              return;

                            }

                            debugPrint("call total va$total");
                            if (int.parse("${widget.itemData.onRecieveQty}") <=
                                total) {
                              totalInputQnt =
                                  int.parse(widget.itemData.onRecieveQty!) -
                                      total;

                              addRackStoriesCubit!.setTotalReceiveValues(
                                  totalInputQnt, widget.itemData.id!);
                              Fluttertoast.showToast(
                                  msg:
                                      "You can not Enter more amount bill amount");
                            } else {
                              setState(() {
                                if (textControllers.text != null &&
                                    textControllers.text.isNotEmpty) {
                                  mapMainData!["item_quantity"] =
                                      int.parse(textControllers.text) + 1;
                                  total=total+1;
                                } else {
                                  total=1;
                                  mapMainData!["item_quantity"] = 1;
                                }

                                textControllers.text =
                                    "${mapMainData!["item_quantity"]}";
                                //mapMainData!["item_quantity"];
                                enterQnt1!["item_quantity"] =
                                    mapMainData!["item_quantity"]!;
                                totalInputQnt =
                                    int.parse(widget.itemData.onRecieveQty!) -
                                        total;

                                addRackStoriesCubit!.setTotalReceiveValues(
                                    totalInputQnt, widget.itemData.id!);

                                addRackStoriesCubit!
                                    .onInputDataChange(mapMainData!);
                                addRackStoriesCubit!
                                    .onInputDataChangeVar(mapMainData!);
                              });
                            }

                            setState(() {});
                          } catch (e) {
                            print("Invalid input: $e");
                          }
                        }, onTapSubtract: () {
                          setState(() {
                            if (int.parse(textControllers.text!) > 0) {
                              mapMainData!["item_quantity"] =
                                  int.parse(textControllers.text!) - 1;
                              textControllers.text =
                                  "${mapMainData!["item_quantity"]}";
                              enterQnt1!["item_quantity"] =
                                  int.parse(textControllers.text);
                              totalInputQnt =
                                  int.parse(widget.itemData.onRecieveQty!) -
                                      mapMainData!["item_quantity"]!;

                              addRackStoriesCubit!.setTotalReceiveValues(
                                  totalInputQnt, widget.itemData.id!);
                              addRackStoriesCubit!
                                  .onInputDataChange(mapMainData!);
                              addRackStoriesCubit!
                                  .onInputDataChangeVar(mapMainData!);
                            }
                          });
                        }),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                  visible: isRackAddMore!,
                  child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: isRackAddMoreCount,
                      itemBuilder: (context, index) {
                        print("call herre data acall");
                        return Container(
                            child: AddMoreRackButton(
                                enterQnt1,
                                rackCountValues,
                                widget.itemData.onRecieveQty,
                                textControllersMap!["item$index"],
                                index,
                                widget.itemData.itemId,
                                widget.itemData.id,
                                widget.racklList!.data));
                      })),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    if (widget.racklList!.data!.length >= 2 &&
                        addRackStoriesCubit!.state
                                .totalReceiveQnt!["${widget.itemData.id}"] >=
                            1) {
                      if (isRackAddMoreCount + 1 <
                          widget.racklList!.data!.length) {
                        if (isRackAddMore!) {
                          textControllersMap['item$isRackAddMoreCount'] =
                              TextEditingController();
                          isRackAddMoreCount = isRackAddMoreCount + 1;

                          //}
                        } else {
                          textControllersMap['item0'] = TextEditingController();
                          isRackAddMore = true;
                        }
                      } else {
                        Fluttertoast.showToast(msg: "can not do it ");
                      }
                    }
                    else {
                      Fluttertoast.showToast(msg: "can not do it ");
                    }
                  });

                  //  visibleAddMoreRack();
                },
                child: Container(
                  height: AppConfig(context).appHeight(5),
                  width: AppConfig(context).appWidth(35),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppConfig(context).appHeight(0.5)),
                      border: Border.all(color: AppColors().colorPrimary(0))),
                  child: Center(
                    child: Text(
                      "Add more rack",
                      style: GoogleFonts.inter(
                          color: AppColors().colorPrimary(1),
                          fontSize: AppConfig(context).appHeight(1.5),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: AppConfig(context).appHeight(3),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget getRackList(List<RackData>? partyNameModelList) {
    return DropdownButton2<RackData>(
      isExpanded: false,
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
                  "${item.locationName}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      value: rackListPickUpData ?? partyNameModelList[0],

      onChanged: (value) {
        mapMainData!["rack_id"] = int.parse("${value!.id}");

        rackListPickUpData = value;

        setState(() {});
        addRackStoriesCubit!.onInputDataChange(mapMainData!);
        addRackStoriesCubit!.onInputDataChangeVar(mapMainData!);
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

      //This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          //  textEditingController.clear();
        }
      },
    );
  }

  Widget QuantityAddSubWidget(
    BuildContext context, {
    VoidCallback? onTapAdd,
    required int rackCount,
    VoidCallback? onTapSubtract,
  }) {
    return BlocBuilder<AddToRackCubit, AddToRackState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: onTapAdd,
              child: Container(
                height: AppConfig(context).appHeight(4),
                width: AppConfig(context).appHeight(4),
                decoration: BoxDecoration(
                    color: AppColors().colorPrimary(1),
                    borderRadius: BorderRadius.circular(
                        AppConfig(context).appHeight(0.5))),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: AppConfig(context).appHeight(2),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppConfig(context).appWidth(2),
            ),
            SizedBox(
              height: AppConfig(context).appHeight(5),
              width: AppConfig(context).appWidth(12),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  maxLength: 4,
                  controller: textControllers,
                  onChanged: (value) {
                    try {
                      enterQnt1!["item_quantity"] = int.parse(value);
                    } catch (E) {
                      enterQnt1!["item_quantity"] = 0;
                    }

                    int total = 0;
                    if (isRackAddMore!) {
                      total = enterQnt1["item_quantity"]!;
                      if (enterQnt1["item_quantity0"] != null) {
                        for (int i = 0; i < enterQnt1.length - 1; i++) {
                          total = total + enterQnt1["item_quantity$i"]!;
                        }
                      } else {}
                    } else {
                      total = enterQnt1!["item_quantity"]!;
                    }

                    debugPrint("call total va$total");

                    if (enterQnt1["item_quantity"]! <= int.parse("${rackListPickUpData!.capacity}")) {
                      if (int.parse("${widget.itemData.onRecieveQty}") <
                          total) {
                        Fluttertoast.showToast(
                            msg: "You can not Enter more amount bill amount");
                        textControllers.text = "0";

                        total = total - enterQnt1!["item_quantity"]!;
                        enterQnt1!["item_quantity"] = 0;

                        totalInputQnt =
                            int.parse(widget.itemData.onRecieveQty!) - total;

                        addRackStoriesCubit!.setTotalReceiveValues(
                            totalInputQnt, widget.itemData.id!);
                      } else {
                        totalInputQnt =
                            int.parse(widget.itemData.onRecieveQty!) - total;

                        addRackStoriesCubit!.setTotalReceiveValues(
                            totalInputQnt, widget.itemData.id!);

                        if (value != null && value.isNotEmpty) {
                          mapMainData!["item_quantity"] = int.parse(value);
                        } else {
                          mapMainData!["item_quantity"] = 0;
                        }

                        addRackStoriesCubit!.onInputDataChange(mapMainData!);
                        addRackStoriesCubit!.onInputDataChangeVar(mapMainData!);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "You can not Enter more amount bill amount");
                      textControllers.text = "0";

                      total = total - enterQnt1!["item_quantity"]!;
                      enterQnt1!["item_quantity"] = 0;

                      totalInputQnt =
                          int.parse(widget.itemData.onRecieveQty!) - total;

                      addRackStoriesCubit!.setTotalReceiveValues(
                          totalInputQnt, widget.itemData.id!);
                    }

                    /* } catch (e) {
                      debugPrint("Invalid input: $value");
                    }
*/
                    // myValueSetter(value);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                  decoration: const InputDecoration(counterText: ""),
                ),
              ),
            ),
            SizedBox(
              width: AppConfig(context).appWidth(2),
            ),
            InkWell(
              onTap: onTapSubtract,
              child: Container(
                height: AppConfig(context).appHeight(4),
                width: AppConfig(context).appHeight(4),
                decoration: BoxDecoration(
                    color: AppColors().colorPrimary(1),
                    borderRadius: BorderRadius.circular(
                        AppConfig(context).appHeight(0.5))),
                child: Center(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: AppConfig(context).appHeight(2),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void getAllData() {
    addRackStoriesCubit = context.read<AddToRackCubit>();
    if (addRackStoriesCubit!.state.inputDataList != null &&
        addRackStoriesCubit!.state.inputDataList!.isNotEmpty) {
      int indexV =
          addRackStoriesCubit!.state.inputDataList!.indexWhere((element) {
        return element['id'] == int.parse("${widget.itemData.id}");
      });
      if (indexV > -1) {
        textControllers.text =
            "${addRackStoriesCubit!.state.inputDataList![indexV]["item_quantity"]}";
        mapMainData!["item_quantity"] =
            addRackStoriesCubit!.state.inputDataList![indexV]["item_quantity"];
        mapMainData!["rack_id"] =
            addRackStoriesCubit!.state.inputDataList![indexV]["rack_id"];
        mapMainData!["id"] = int.parse("${widget.itemData.id}") ?? 0;

        enterQnt1!["item_quantity"] =
            addRackStoriesCubit!.state.inputDataList![indexV]["item_quantity"];
        totalInputQnt =
            addRackStoriesCubit!.state.inputDataList![indexV]["item_quantity"]??0;
        RackData? result = widget.racklList!.data!.firstWhere((rackData) =>
            rackData.id ==
            "${addRackStoriesCubit!.state.inputDataList![indexV]["rack_id"]}");

        if (result != null) {
          rackListPickUpData = result;
          print("Found: ${result.toString()}");
        } else {
          print("Not found.");
        }
        mapMainData!["item_id"] =
            addRackStoriesCubit!.state.inputDataList![indexV]["item_id"] ?? 0;

        addRackStoriesCubit!.onInputDataChange(mapMainData!);
        addRackStoriesCubit!.onInputDataChangeVar(mapMainData!);

        if (addRackStoriesCubit!.state.inputDataListAddMoreItem != null &&
            addRackStoriesCubit!.state.inputDataListAddMoreItem!.isNotEmpty) {
          for (int i = 0;
              i < addRackStoriesCubit!.state.inputDataListAddMoreItem!.length;
              i++) {
            int indexV11 = addRackStoriesCubit!.state.inputDataListAddMoreItem!
                .indexWhere((element) {
              return element['id'] == int.parse("${widget.itemData.id}$i");
            });

            if (indexV11 > -1) {
              isRackAddMoreCount = i + 1;
              isRackAddMore = true;
              textControllersMap['item$i'] = TextEditingController();
              if (addRackStoriesCubit!.state.inputDataListAddMoreItem![indexV11]["item_quantity"] !=
                  null) {
                totalInputQnt = (addRackStoriesCubit!
                            .state.inputDataListAddMoreItem![indexV11]
                        ["item_quantity"]) +
                    totalInputQnt;
              } else {
                //  totalInputQnt= 0;
              }
            }
          }
          totalInputQnt =
              int.parse(widget.itemData.onRecieveQty!) - totalInputQnt;

          addRackStoriesCubit!
              .setTotalReceiveValues(totalInputQnt, widget.itemData.id!);
        } else {
          totalInputQnt = int.parse(widget.itemData.onRecieveQty!) -
              int.parse(textControllers.text);
          print(
              "set calculates va${int.parse(widget.itemData.onRecieveQty!) - int.parse(textControllers.text)}");
          addRackStoriesCubit!
              .setTotalReceiveValues(totalInputQnt, widget.itemData.id!);
        }
      } else {
        addRackStoriesCubit!.setTotalReceiveValues(
            int.parse(widget.itemData.onRecieveQty!), widget.itemData.id!);
        mapMainData!["item_id"] = int.parse("${widget.itemData.itemId}") ?? 0;
        mapMainData!["id"] = int.parse("${widget.itemData.id}") ?? 0;
        mapMainData!["item_quantity"] = 0;
        mapMainData!["rack_id"] = int.parse("${widget.racklList!.data![0].id}");

        enterQnt1!["item_quantity"] = 0;
        addRackStoriesCubit!.onInputDataChange(mapMainData!);

        addRackStoriesCubit!.onInputDataChangeVar(mapMainData!);

        rackListPickUpData = widget.racklList!.data![0];
      }
    } else {
      addRackStoriesCubit!.setTotalReceiveValues(
          int.parse(widget.itemData.onRecieveQty!), widget.itemData.id!);
      mapMainData!["item_id"] = int.parse("${widget.itemData.itemId}") ?? 0;
      mapMainData!["id"] = int.parse("${widget.itemData.id}") ?? 0;
      mapMainData!["item_quantity"] = 0;
      mapMainData!["rack_id"] = int.parse("${widget.racklList!.data![0].id}");

      enterQnt1!["item_quantity"] = 0;
      addRackStoriesCubit!.onInputDataChange(mapMainData!);

      addRackStoriesCubit!.onInputDataChangeVar(mapMainData!);
      rackListPickUpData = widget.racklList!.data![0];
    }
  }
}

class AddMoreRackButton extends StatefulWidget {
  List<RackData>? rackData;
  String? itemId;
  String? id;
  int? index;
  Map<String, int>? enterQnt1;
  String? onRecieveQty;
  TextEditingController? textControllersMap;
  int? isRackAddMoreCount;

  AddMoreRackButton(this.enterQnt1, this.isRackAddMoreCount, this.onRecieveQty,
      this.textControllersMap, this.index, this.itemId, this.id, this.rackData,
      {super.key});

  @override
  State<AddMoreRackButton> createState() => _AddMoreRackButtonState();
}

class _AddMoreRackButtonState extends State<AddMoreRackButton> {
  AddToRackCubit? addRackStoriesCubit;

  Map<String, int> mapMainData = {};

  RackData? rackListPickUpData;

  var totalInputData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    addRackStoriesCubit = context.read<AddToRackCubit>();
    getAllData();
  }

  void getAllData() {
    if (addRackStoriesCubit!.state.inputDataListAddMoreItem != null &&
        addRackStoriesCubit!.state.inputDataListAddMoreItem!.isNotEmpty) {
      int indexV = addRackStoriesCubit!.state.inputDataListAddMoreItem!
          .indexWhere((element) {
        return element['id'] == int.parse("${widget.id}${widget.index}");
      });
      if (indexV > -1) {
        widget.textControllersMap!.text =
            "${addRackStoriesCubit!.state.inputDataListAddMoreItem![indexV]["item_quantity"]}";

        mapMainData!["item_quantity"] = addRackStoriesCubit!
            .state.inputDataListAddMoreItem![indexV]["item_quantity"];
        mapMainData!["rack_id"] = addRackStoriesCubit!
            .state.inputDataListAddMoreItem![indexV]["rack_id"];
        mapMainData!["id"] = int.parse("${widget.id}${widget.index}") ?? 0;


        int index11 = widget.rackData!.indexWhere((element) {
          print("element${element}");

          return element.id == "${mapMainData!["rack_id"]}";
        });

        if (index11 > -1) {
          rackListPickUpData = widget.rackData![index11];
        }

        widget.enterQnt1!["item_quantity${widget.index}"] = addRackStoriesCubit!
            .state.inputDataListAddMoreItem![indexV]["item_quantity"];
        mapMainData!["item_id"] = int.parse("${widget.itemId}") ?? 0;

        addRackStoriesCubit!.onInputDataChangeAddMoreRack(mapMainData!);
        addRackStoriesCubit!.onInputDataChangeAddMoreRackVar(mapMainData!);
      } else {

        rackListPickUpData=widget.rackData![0];
        mapMainData!["item_id"] = int.parse("${widget.itemId}") ?? 0;
        mapMainData!["id"] = int.parse("${widget.id}${widget.index}") ?? 0;
        mapMainData!["item_quantity"] = 0;
        mapMainData!["rack_id"] = int.parse("${widget.rackData![0].id}");
        widget.enterQnt1!["item_quantity${widget.index}"] = 0;
        addRackStoriesCubit!.onInputDataChangeAddMoreRack(mapMainData!);
        addRackStoriesCubit!.onInputDataChangeAddMoreRackVar(mapMainData!);
      }
    } else {

      rackListPickUpData=widget.rackData![0];
      mapMainData!["item_id"] = int.parse("${widget.itemId}") ?? 0;
      mapMainData!["id"] = int.parse("${widget.id}${widget.index}") ?? 0;
      mapMainData!["item_quantity"] = 0;
      mapMainData!["rack_id"] = int.parse("${widget.rackData![0].id}");
      widget.enterQnt1!["item_quantity${widget.index}"] = 0;
      addRackStoriesCubit!.onInputDataChangeAddMoreRack(mapMainData!);
      addRackStoriesCubit!.onInputDataChangeAddMoreRackVar(mapMainData!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // widget.textControllersMap!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select Rack",
                  style: GoogleFonts.inter(
                      color: AppColors().accentColor(1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                getRackList(widget.rackData!),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter Quantity",
                  style: GoogleFonts.inter(
                      color: AppColors().accentColor(1),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: AppConfig(context).appHeight(0.7),
                ),
                QuantityAddSubWidget(context, onTapAdd: () {
                  try {
                    int total = 0;

                    total = widget.enterQnt1!["item_quantity"]!;
                    if (widget.enterQnt1!["item_quantity0"] != null) {
                      for (int i = 0; i < widget.enterQnt1!.length - 1; i++) {
                        total = total + widget.enterQnt1!["item_quantity${i}"]!;
                      }
                    } else {}

                    debugPrint("call total va$total");
                    if (widget.enterQnt1!["item_quantity${widget.index}"]! >=
                        int.parse("${rackListPickUpData!.capacity}")) {
                      Fluttertoast.showToast(
                          msg: "You can not Enter more amount bill amount");
                      return;

                    }

                    if (int.parse("${widget.onRecieveQty}") < total) {
                      Fluttertoast.showToast(
                          msg: "You can not Enter more amount bill amount");
                    } else {
                      if (widget.textControllersMap != null &&
                          widget.textControllersMap!.text != null &&
                          widget.textControllersMap!.text.isNotEmpty) {
                        mapMainData!["item_quantity"] =
                            int.parse(widget.textControllersMap!.text) + 1;
                        total=total+1;
                      } else {
                        total=1;
                        mapMainData!["item_quantity"] = 1;
                      }

                      widget.textControllersMap!.text =
                          "${mapMainData!["item_quantity"]}";
                      widget.enterQnt1!["item_quantity${widget.index}"] =
                          mapMainData!["item_quantity"]!;

                      totalInputData = int.parse(widget.onRecieveQty!) - total;

                      addRackStoriesCubit!
                          .setTotalReceiveValues(totalInputData, widget.id!);

                      addRackStoriesCubit!
                          .onInputDataChangeAddMoreRack(mapMainData!);
                      addRackStoriesCubit!
                          .onInputDataChangeAddMoreRackVar(mapMainData!);
                      setState(() {});
                    }
                  } catch (e) {
                    print("Invalid input: $e");
                  }

                  setState(() {});
                }, onTapSubtract: () {
                  if (int.parse(widget.textControllersMap!.text!) > 0) {
                    mapMainData!["item_quantity"] =
                        int.parse(widget.textControllersMap!.text!) - 1;
                    widget.textControllersMap!.text =
                        "${mapMainData!["item_quantity"]}";

                    widget.enterQnt1!["item_quantity${widget.index}"] =
                        mapMainData!["item_quantity"]!;

                    totalInputData = addRackStoriesCubit!
                            .state.totalReceiveQnt!["${widget.id}"] +
                        1;

                    addRackStoriesCubit!
                        .setTotalReceiveValues(totalInputData, widget.id!);

                    addRackStoriesCubit!
                        .onInputDataChangeAddMoreRack(mapMainData!);
                    addRackStoriesCubit!
                        .onInputDataChangeAddMoreRackVar(mapMainData!);
                    setState(() {});
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget QuantityAddSubWidget(
    BuildContext context, {
    VoidCallback? onTapAdd,
    VoidCallback? onTapSubtract,
  }) {
    return BlocBuilder<AddToRackCubit, AddToRackState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: onTapAdd,
              child: Container(
                height: AppConfig(context).appHeight(4),
                width: AppConfig(context).appHeight(4),
                decoration: BoxDecoration(
                    color: AppColors().colorPrimary(1),
                    borderRadius: BorderRadius.circular(
                        AppConfig(context).appHeight(0.5))),
                child: Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: AppConfig(context).appHeight(2),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppConfig(context).appWidth(2),
            ),
            SizedBox(
              height: AppConfig(context).appHeight(5),
              width: AppConfig(context).appWidth(12),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  maxLength: 4,
                  controller: widget.textControllersMap,
                  onChanged: (value1) {
                    try {
                      widget.enterQnt1!["item_quantity${widget.index}"] =
                          int.parse(value1);
                    } catch (E) {
                      widget.enterQnt1!["item_quantity${widget.index}"] = 0;
                    }
                    try {
                      debugPrint("widget.enterQnt1!.toString()");
                      debugPrint(widget.enterQnt1!.toString());
                      int total = widget.enterQnt1!["item_quantity"]!;
                      if (widget.enterQnt1!["item_quantity0"] != null) {
                        for (int i = 0; i < widget.enterQnt1!.length - 1; i++) {
                          int aa = widget.enterQnt1!["item_quantity${i}"]!;
                          debugPrint("aa$aa");
                          total = total + aa;
                        }
                      } else {}

                      if (widget.enterQnt1!["item_quantity${widget.index}"]! <=
                          int.parse("${rackListPickUpData!.capacity}")) {
                        if (total > int.parse("${widget.onRecieveQty ?? 0}")) {
                          debugPrint(
                              "widget.onRecieveQty${widget.onRecieveQty}");
                          widget.enterQnt1!["item_quantity${widget.index}"] = 0;
                          Fluttertoast.showToast(
                              msg: "You can not Enter more amount bill amount");
                          widget.textControllersMap!.text = "0";

                          totalInputData =
                              int.parse(widget.onRecieveQty!) - total;

                          addRackStoriesCubit!.setTotalReceiveValues(
                              totalInputData, widget.id!);
                        } else {
                          total = total - widget.enterQnt1!["item_quantity${widget.index}"]!;
                          totalInputData =
                              int.parse(widget.onRecieveQty!) - total;

                          addRackStoriesCubit!.setTotalReceiveValues(
                              totalInputData, widget.id!);

                          mapMainData!["item_quantity"] = int.parse(value1);
                          addRackStoriesCubit!
                              .onInputDataChangeAddMoreRack(mapMainData!);
                          addRackStoriesCubit!
                              .onInputDataChangeAddMoreRackVar(mapMainData!);
                        }
                      } else {
                        total = total - widget.enterQnt1!["item_quantity${widget.index}"]!;

                        debugPrint("widget.onRecieveQty${widget.onRecieveQty}");
                        widget.enterQnt1!["item_quantity${widget.index}"] = 0;
                        Fluttertoast.showToast(
                            msg: "You can not Enter more amount bill amount");
                        widget.textControllersMap!.text = "0";

                        totalInputData =
                            int.parse(widget.onRecieveQty!) - total;

                        addRackStoriesCubit!
                            .setTotalReceiveValues(totalInputData, widget.id!);
                      }

                      setState(() {});
                    } catch (E) {
                      debugPrint("errro $E");
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                  ],
                  decoration: const InputDecoration(counterText: ""),
                ),
              ),
            ),
            SizedBox(
              width: AppConfig(context).appWidth(2),
            ),
            InkWell(
              onTap: onTapSubtract,
              child: Container(
                height: AppConfig(context).appHeight(4),
                width: AppConfig(context).appHeight(4),
                decoration: BoxDecoration(
                    color: AppColors().colorPrimary(1),
                    borderRadius: BorderRadius.circular(
                        AppConfig(context).appHeight(0.5))),
                child: Center(
                  child: Icon(
                    Icons.remove,
                    color: Colors.white,
                    size: AppConfig(context).appHeight(2),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getRackList(List<RackData>? partyNameModelList) {
    return DropdownButton2<RackData>(
      isExpanded: false,
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
                  "${item.locationName}",
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      value: rackListPickUpData ?? partyNameModelList[0],
      onChanged: (value) {
        rackListPickUpData = value;
        mapMainData!["rack_id"] = int.parse("${value!.id}");
        addRackStoriesCubit!.onInputDataChangeAddMoreRack(mapMainData!);
        addRackStoriesCubit!.onInputDataChangeAddMoreRackVar(mapMainData!);
        setState(() {});
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
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          //  textEditingController.clear();
        }
      },
    );
  }
}
