import 'package:erpvc/app.dart';
import 'package:erpvc/repos/authentication_repository.dart';
import 'package:erpvc/repos/user_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'helper/LocalNotification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );


  //LocalNotificationService.showNotificationWithDefaultSound("");



  runApp(App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}



Future<void> backgroundHandler(RemoteMessage message) async {
  Map<dynamic, dynamic> bodyCal;
  bodyCal = message.data;
  print(
      "backgroundHandler ============================================>>>>>>>>>$bodyCal");
  LocalNotificationService.showNotificationWithDefaultSound(message);

  try {
    if (bodyCal["type"] != null &&
        bodyCal["type"] == "instantCashAddedFromGamePlay") {
      print("instantCashAdded true ${bodyCal["type"]}");
    }
  } catch (A) {}
}

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}*/
