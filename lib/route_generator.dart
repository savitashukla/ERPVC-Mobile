
import 'package:erpvc/helper/route_arguments.dart';
import 'package:erpvc/pages/add_to_rack/view/add_to_rack_screen.dart';
import 'package:erpvc/pages/create_inward/elements/create_inward_page2.dart';

import 'package:erpvc/pages/create_inward/view/create_inward.dart';
import 'package:erpvc/pages/dashboard/view/dashboard.dart';
import 'package:erpvc/pages/forgot_password/view/forgot_password.dart';
import 'package:erpvc/pages/inventory/view/inventory_second_view.dart';
import 'package:erpvc/pages/inventory/view/inventory_view.dart';
import 'package:erpvc/pages/inward_details/view/inward_details.dart';
import 'package:erpvc/pages/login/view/login_page.dart';
import 'package:erpvc/pages/pdf_view/pdf_view.dart';
import 'package:erpvc/pages/splash.dart';
import 'package:flutter/material.dart';



class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print(settings.name.toString());
    switch (settings.name) {
      case '/Splash':
        return MaterialPageRoute<void>(builder: (_) => SplashPage());

      case '/Login':
        return LoginPage.route();

      case '/ForgotPassword':
        return ForgotPassword.route();

      case '/DashboardPage':
        return DashBoardPage.route();

      case '/PdfViewerPage':
        return PdfViewerPage.route();

      case '/CreateInwardPage':
        return CreateInwardPage.route(args as RouteArguments);

      case '/InventoryScreen':
        return InventoryListViewSec.route();
/*      case '/InwordDetails':
        return InwardDetails.route();*/

        /*case '/AddToRack':
        return AddToRack.route();
*/
      /*case '/CreateInwardPage2':
        return CreateInwardPage2.route();*/

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return MaterialPageRoute<void>(
            builder: (_) => const Scaffold(
                body: SafeArea(child: Center(child: Text('Route Error')))));
    }
  }
}

// "api_base_url":"https://ios.essitco.net/api/",
