import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationService {
  static var onSelectNotification = false;
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;



  static Future<void> initialize() async {
    // initializationSettings  for Android
    InitializationSettings initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );


      _notificationsPlugin.initialize(
        initializationSettings,

       /* onSelectNotification: (String? payload) async {
          print(payload);

        },*/
      );

  }




  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "earnzoflutter",
          "earnzoflutterchannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
      );

    await _notificationsPlugin.show(id,  message.notification!.title??"", message.notification!.body??"", notificationDetails);
    } on Exception catch (e) {
   print(e);
    }
  }

  static void showNotificationWithDefaultSound(RemoteMessage body_values) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'earnzoflutter',
      "earnzoflutterchannel",
      channelDescription:
      "This channel is responsible for all the local notifications",
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

    var platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await _notificationsPlugin.show(0,  body_values.notification!.title??"", body_values.notification!.body??"", platformChannelSpecifics);

  }


}
