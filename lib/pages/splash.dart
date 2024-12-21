import 'package:erpvc/helper/app_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helper/LocalNotification.dart';

class SplashPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {


    FirebaseMessaging.instance.getInitialMessage().then(
          (message) async {

        print("FirebaseMessaging.instance.getInitialMessage${message.toString()}");
        if (message != null) {
          //  LocalNotificationService.showNotificationWithDefaultSound("");
          if (message.notification != null) {
            LocalNotificationService.createanddisplaynotification(message);
           print("New Notification");
          } else {
            //  LocalNotificationService.showNotificationWithDefaultSound("");
          }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened

    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {
 print("FirebaseMessaging.onMessageOpenedApp.listen ${message.data}");

        //  Utils().customPrint("Aditi Rao Agle Sakal yeah${message.notification.title}");
        //    Utils().customPrint("FirebaseMessaging.onMessage.listen${message.notification.body}");
        //    LocalNotificationService.createanddisplaynotification(message);Aditi Rao Agle Sakal

        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
        } else {
          // LocalNotificationService.showNotificationWithDefaultSound("");
        }
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) async {
       print("FirebaseMessaging.onMessageOpenedApp.listen");
       LocalNotificationService.createanddisplaynotification(message);

       if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );
    super.initState();
  }

  //#E5E5E5

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/img/logo.svg',
          fit: BoxFit.contain,
          color: AppColors().colorPrimary(1),
        ),
      ),
    );
  }
}
