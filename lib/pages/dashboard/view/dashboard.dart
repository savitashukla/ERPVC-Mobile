import 'package:erpvc/helper/app_config.dart';
import 'package:erpvc/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../helper/LocalNotification.dart';
import '../../../helper/helper.dart';
import '../../../helper/route_arguments.dart';
import '../cubit/dashboard_state.dart';
import '../elements.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider(
        create: (context) => DashboardCubit(),
        child: const DashBoardPage(),
      );
    });
  }

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  TextEditingController dateController = TextEditingController();
  final TextEditingController testController = TextEditingController(text: "");
  DashboardCubit? createStoriesCubit;
  TextEditingController dateControllerEnd = TextEditingController();
  TextEditingController dateControllerStart = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  String? startDate;
  String? endDate;

  @override
  void initState() {
    testController.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
    super.initState();
    getApiData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Fluttertoast.showToast(
            msg: "Back Off !! You Schedule Use logout Button");
        return false;
      },
      child: RefreshIndicator(
        color: AppColors().colorPrimary(1),
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 0), () async {
            await createStoriesCubit!.getInwardList(
                DateFormat('yyyy-MM-dd').format(
                  DateTime.now(),
                ),
                DateFormat('yyyy-MM-dd').format(DateTime.now()));
            await createStoriesCubit!.getUserProfile();
            createStoriesCubit!.getProgressBar(true);
          });
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leadingWidth: AppConfig(context).appWidth(10),
            leading: InkWell(
              onTap: () {
                context
                    .read<AuthenticationRepository>()
                    .showAlertDialog(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: AppConfig(context).appWidth(4)),
                child: SvgPicture.asset(
                  "assets/img/logout.svg",
                  height: AppConfig(context).appWidth(4),
                  width: AppConfig(context).appWidth(4),
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              "Home",
              style: GoogleFonts.inter(
                  color: AppColors().colorPrimary(1),
                  fontSize: AppConfig(context).appWidth(7),
                  fontWeight: FontWeight.w500),
            ),
          ),
          body: BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(AppConfig(context).appWidth(7)),
              child: Column(
                children: [
                  // this is visible as per Gate keeper
                  state.userProfileDataV != null &&
                          state.userProfileDataV!.data != null
                      ? state.userProfileDataV!.data!.warehouse!
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 71,
                                  width: AppConfig(context).appWidth(42),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        // LocalNotificationService.showNotificationWithDefaultSound("");

                                        //   LocalNotificationService().   initialize;
                                        //        LocalNotificationService().   showNotification(id: 0, title: 'title', body: 'body');

                                        Fluttertoast.showToast(
                                            msg: "Already Open it");

                                        /* navigatorKey.currentState!
                                            .pushNamed("/InventoryScreen");*/
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          return AppColors().colorPrimary(1);
                                        }),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/img/ic_eye.svg'),
                                          SizedBox(
                                            height:
                                                AppConfig(context).appHeight(1),
                                          ),
                                          Text(
                                            "View Entry",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: AppConfig(context)
                                                    .appWidth(3.5)),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: 71,
                                  width: AppConfig(context).appWidth(42),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        navigatorKey.currentState!
                                            .pushNamed("/InventoryScreen");
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          return AppColors()
                                              .colorPrimaryLightSS(1);
                                        }),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              'assets/img/boxes_stacked.svg'),
                                          SizedBox(
                                            width:
                                                AppConfig(context).appWidth(3),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "View Inventory",
                                            style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: AppConfig(context)
                                                    .appWidth(3.5)),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            )
                          : state.userProfileDataV!.data!.dataEntryCreate!
                              ? Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 71,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              navigatorKey.currentState!
                                                  .pushNamed(
                                                      "/CreateInwardPage",
                                                      arguments: RouteArguments(
                                                          fromScreen:
                                                              "New Entry"));
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) {
                                                return AppColors()
                                                    .colorPrimary(1);
                                              }),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: AppConfig(context)
                                                      .appWidth(7),
                                                ),
                                                SizedBox(
                                                  width: AppConfig(context)
                                                      .appWidth(3),
                                                ),
                                                Text(
                                                  "Add New Entry",
                                                  style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          AppConfig(context)
                                                              .appWidth(3.5)),
                                                )
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  height: 71,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              /* navigatorKey.currentState!
                                    .pushNamed("/CreateInwardPage");*/
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith((states) {
                                                return AppColors()
                                                    .colorPrimary(1);
                                              }),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    'assets/img/ic_eye.svg'),
                                                SizedBox(
                                                  height: AppConfig(context)
                                                      .appHeight(1),
                                                ),
                                                Text(
                                                  "View Entry",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize:
                                                          AppConfig(context)
                                                              .appWidth(3.5)),
                                                )
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                      : const SizedBox(height: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, right: 3),
                                child: Text(
                                  "Date",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors().colorPrimary(1),
                                      fontSize: AppConfig(context).appWidth(4)),
                                ),
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: DashboardElements().dateFieldCommon(
                                  context: context,
                                  myDateSetter: (DateTime? value) {
                                    testController!.text =
                                        DateFormat('dd-MM-yyyy').format(value!);

                                    createStoriesCubit!.getInwardList(
                                        DateFormat('yyyy-MM-dd').format(value!),
                                        DateFormat('yyyy-MM-dd')
                                            .format(value!));
                                  },
                                  textEditingController: testController,
                                ),
                              )),
                              InkWell(
                                onTap: () {
                                  showBottomSheetFilterDash(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: SizedBox(
                                    height: 20,
                                    width: 25,
                                    child: SvgPicture.asset(
                                        "assets/img/Filter.svg"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: AppConfig(context).appHeight(2),
                          ),
                          state.isProcessing && state.userProfileDataV != null
                              ? state.inwardModelVar!.data!.isNotEmpty
                                  ? DashboardElements().DashboardProductList(
                                      state.inwardModelVar!.data,
                                      state.userProfileDataV!.data!
                                          .racksCreatePer)
                                  : Center(
                                      child: Text('',
                                          style: GoogleFonts.roboto(
                                              fontSize: AppConfig(context)
                                                  .appWidth(4.0),
                                              color:
                                                  AppColors().colorPrimary(1),
                                              fontWeight: FontWeight.w700)),
                                    )
                              : Center(
                                  child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator(
                                      color: AppColors().colorPrimary(1),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> getApiData() async {
    createStoriesCubit = context.read<DashboardCubit>();
    await createStoriesCubit!.getInwardList(
        DateFormat('yyyy-MM-dd').format(
          DateTime.now(),
        ),
        DateFormat('yyyy-MM-dd').format(DateTime.now()));
    await createStoriesCubit!.getUserProfile();
    createStoriesCubit!.getProgressBar(true);
  }

  void showBottomSheetFilterDash(
    BuildContext context,
  ) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                SizedBox(
                  width: double.infinity,
                  //       height: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          "Filter",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              color: AppColors().accentColor(1),
                              fontSize: AppConfig(context).appWidth(4)),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Search",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: AppColors().accentColor(1),
                            fontSize: AppConfig(context).appWidth(4)),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: AppConfig(context).appHeight(5),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            searchController.text = value;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.search),
                            ),
                            prefixIconConstraints: BoxConstraints(
                              maxWidth: AppConfig(context).appWidth(15),
                            ),
                            hintText: "Search",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Start Date",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors().colorPrimary(1),
                                  fontSize: AppConfig(context).appWidth(4)),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "End Date",
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors().colorPrimary(1),
                                    fontSize: AppConfig(context).appWidth(4)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: DashboardElements().dateFieldCommon(
                            context: context,
                            myDateSetter: (DateTime? value) {
                              dateControllerStart!.text =
                                  DateFormat('dd-MM-yyyy').format(value!);
                              startDate=DateFormat('yyyy-MM-dd').format(value!);
                            },
                            dateNo:
                                DateFormat('dd-MM-yyyy').format(DateTime.now()),
                            textEditingController: dateControllerStart,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: DashboardElements().dateFieldCommon(
                            context: context,
                            dateNo: dateControllerStart!.text,
                            myDateSetter: (DateTime? value) {
                              endDate =
                                  DateFormat('yyy-MM-dd').format(value!);
                              dateControllerEnd!.text =
                                  DateFormat('dd-MM-yyyy').format(value!);
                            },
                            textEditingController: dateControllerEnd,
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Helper.commonButton(
                                context: context,
                                onTap: () {
                                  dateControllerEnd.text = "";
                                  dateControllerStart.text = "";
                                  searchController.text = "";

                                  Navigator.pop(
                                      navigatorKey.currentState!.context);
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
                                onTap: () {
                                  createStoriesCubit!.getInwardList(startDate,
                                      endDate, searchController.text);
                                  Navigator.pop(context);
                                },
                                label: "Search",
                                backgroundColor: AppColors().colorPrimary(1),
                                textColor: Colors.white,
                                borderColor: Colors.white,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
/*class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async{
    const AndroidInitializationSettings androidInitializationSettings=
    AndroidInitializationSettings('@mipmap/ic_launcher');



    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );
    await _localNotificationService.initialize(
      settings,
    );
  }

  Future<NotificationDetails> _notificationsDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('earnzoflutter', 'earnzoflutter',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true);


    return const NotificationDetails(
      android: androidNotificationDetails,
    );

  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationsDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  void _onDidReceiveLocalNotification(
      int id,String? title,String? body,String? payload) {
    print('id $id');
  }

  void onSelectNotification(
      String? payload) {
    print('payload $payload');
  }

}*/
