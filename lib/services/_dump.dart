import 'dart:ui';
import 'dart:async';

import 'package:flutter/foundation.dart'
    show kDebugMode;
// import 'package:rxdart/rxdart.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const NOTIFICATION_CHANNEL_ID = "foreground_notif";
const NOTIFICATION_ID = 888;

void initializeBackgroundService() async {
  
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    NOTIFICATION_CHANNEL_ID, "TEST TITLE #001",
    description: "Some description",
    importance: Importance.low
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
    FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);

  await service.configure(
    iosConfiguration: IosConfiguration(), 
    androidConfiguration: AndroidConfiguration(
      onStart: onStart, 
      isForegroundMode: true,
      autoStart: true,

      notificationChannelId: NOTIFICATION_CHANNEL_ID,
      initialNotificationTitle: "Service #001",
      initialNotificationContent: "Content #001",
      foregroundServiceNotificationId: NOTIFICATION_ID
    )
  );

  if (kDebugMode) {
    print("Background service has been initialized.");
  }
}

Future<void> onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  Timer.periodic(const Duration(seconds: 10), (timer) async {
    if(service is AndroidServiceInstance) {
      if(await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          NOTIFICATION_ID, 
          "Notification #001", 
          "Message: ${DateTime.now()}", 
          const NotificationDetails(
            android: AndroidNotificationDetails(
              NOTIFICATION_CHANNEL_ID, 
              "SERVICE #001",
              icon: "ic_bg_service_small",
              ongoing: true
            )
          ));
      }
    }
  });
}




// // used to pass messages from event handler to the UI
// final _messageStreamController = BehaviorSubject<RemoteMessage>();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//  await Firebase.initializeApp();

//  if (kDebugMode) {
//    print("Handling a background message: ${message.messageId}");
//    print('Message data: ${message.data}');
//    print('Message notification: ${message.notification?.title}');
//    print('Message notification: ${message.notification?.body}');
//  }
// }



//   // Set FCM permissions
//   final messaging = FirebaseMessaging.instance;

//   final settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );

//   if (kDebugMode) {
//     print('Permission granted: ${settings.authorizationStatus}');
//   }

//   // Register to FCM
//   String? token = await messaging.getToken();

//   if (kDebugMode) {
//     print('Registration Token=$token');
//   }


//   // Setup foreground message handler
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     if (kDebugMode) {
//       print('Handling a foreground message: ${message.messageId}');
//       print('Message data: ${message.data}');
//       print('Message notification: ${message.notification?.title}');
//       print('Message notification: ${message.notification?.body}');
//     }

//     _messageStreamController.sink.add(message);
//   });

//   // Setup background message handler
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


