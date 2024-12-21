import 'package:erpvc/helper/app_config.dart';
import 'package:erpvc/pages/add_to_rack/cubit/add_to_rack_cubit.dart';
import 'package:erpvc/pages/create_inward/cubit/inward_create_cubit.dart';
import 'package:erpvc/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:erpvc/pages/inventory/cubit/inventory_cubit.dart';
import 'package:erpvc/pages/inward_details/cubit/inward_details_cubit.dart';
import 'package:erpvc/pages/login/view/login_page.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:erpvc/repos/inventory_repo.dart';
import 'package:erpvc/repos/user_repository.dart';
import 'package:erpvc/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/authentication/authentication_bloc.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  App(
      {Key? key,
      required this.authenticationRepository,
      required this.userRepository})
      : super(key: key) {
    inventoryRepo = InventoryRepo(userRepository);
  }

  InventoryRepo? inventoryRepo;

  @override
  Widget build(BuildContext context) {
    // ticketsRepository=TicketsRepository(userRepository);
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => authenticationRepository),
        RepositoryProvider(create: (context) => userRepository),
        RepositoryProvider(create: (context) => inventoryRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => DashboardCubit(),
          ),
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
              userRepository: userRepository,
            ),
          ),
          BlocProvider(
            create: (_) => InwardCreateCubit(
                inventoryRepo: inventoryRepo,
                authenticationRepository: authenticationRepository,
            userRepository: userRepository
            ),
          ),
          BlocProvider(
            create: (_) => InwardDetailsCubit(),
          ),
          BlocProvider(
            create: (_) => AddToRackCubit(),
          ),
          BlocProvider(create:(_)=>InventoryCubit() )


        ],
        child: AppView(
          userRepository: userRepository,
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  AppView({this.userRepository});

  final UserRepository? userRepository;

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  NavigatorState? get _navigator => navigatorKey.currentState;

  // FirebaseMessaging? messaging;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, //// navigation bar color
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) async {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  /*for (var element in state.user!.data!.permissions!) {
                    context
                        .read<UserRepository>()
                        .permission
                        .add(element.name!);
                  }*/
                  navigatorKey.currentState!.pushNamed('/DashboardPage');
                  break;
                case AuthenticationStatus.unauthenticated:
                  print('app:-unauthenticated');
                  // navigatorKey.currentState!.pushNamed('/DashboardPage');
                  _navigator!.pushAndRemoveUntil<void>(
                    LoginPage.route(),
                    (route) => false,
                  );
                  break;
                default:
                  break;
              }
            },
            child: child,
          ),
        );
      },
      initialRoute: '/Splash',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        fontFamily: 'roboto',
        primaryColor: AppColors().colorPrimary(1),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 0, foregroundColor: Colors.white),
        brightness: Brightness.light,
        dividerColor: AppColors().accentColor(0.1),
        focusColor: AppColors().secondColor(1),
        unselectedWidgetColor: AppColors().colorDark(1),
        canvasColor: AppColors().colorPrimaryLight(1),
        hintColor: AppColors().secondColor(1),
        scaffoldBackgroundColor: AppColors().scaffoldColor(1),
        primaryColorLight: AppColors().colorPrimaryLight(1),
        primaryColorDark: AppColors().colorPrimaryDark(1),
      ),
    );
  }
}
