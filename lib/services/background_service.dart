import 'dart:ui';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ralert/core/dto/crashmotion.dto.dart';
import 'package:ralert/core/global/global.variable.dart';
import 'package:ralert/data/data_sources/local/motion_datasource/implementation.dart';
import 'package:ralert/data/data_sources/remote/emergency_datasource/implementation.dart';
import 'package:ralert/firebase_options.dart';
import 'package:ralert/services/carcrash_detection.dart';
import 'package:sensors_plus/sensors_plus.dart';

const notificationChannelId = "foreground_notif";
const notificationId = 888;

void initializeBackgroundService() async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId, "RCCDS",
    description: "Automated car crash detection in the background.",
    importance: Importance.high
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
    FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
    ?.createNotificationChannel(channel);

  String startingPoint = "onStartUser";

  final user = await getUser(currentUserId);

  if (user != null) {
    final userData = user.data();

    if (userData["userType"] == "rescuer") {
      startingPoint = "onStartRescuer";
    }
  }

  await service.configure(
    iosConfiguration: IosConfiguration(), 
    androidConfiguration: AndroidConfiguration(
      onStart: startingPoint == "onStartUser"
        ? onStartUser
        : onStartRescuer, 
      isForegroundMode: true,
      autoStart: true,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: "Preparing...",
      initialNotificationContent: "Background Service",
      foregroundServiceNotificationId: notificationId
    )
  );

}

@pragma('vm:entry-point')
Future<void> onStartUser(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  String title = "Ralert Car Crash Safety Detection";
  showNotification(title: title, content: "Drive safe! We will back you if something happens.", payload: 'detecting/0');

  MotionLocalDatasource datasource = MotionLocalDatasource();

  if (service is AndroidServiceInstance) {
    AccelerometerRecordKeeper recordKeeper = datasource.onMotion();

    recordKeeper.addListener((value) async {
      CrashMotion? crashMotion = checkCarCrash(value, recordKeeper);

      if (crashMotion == null) {
        return;
      }

      if(crashMotion.isCarCrash) {
        carCrashDetected();
      } else {
        showNotification(title: title, content: crashMotion.motion.toString());
      }

    });

    recordKeeper.start(userAccelerometerEvents);
  }
}

@pragma('vm:entry-point')
Future<void> onStartRescuer(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  String title = "Ralert Distress Radar";
  showNotification(title: title, content: "We will notify you if something happens nearby.", payload: 'detecting/0');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  EmergencyRemoteDatasource datasource = EmergencyRemoteDatasource();

  if (service is AndroidServiceInstance) {
    datasource.listenToEmergencies(listen: (incidentInfo) {
      showNotification(
        title: "DISTRESS SIGNAL DETECTED NEARBY!",
        content: "A ${incidentInfo["emergencyType"]} has been detected in your area! Take an action now!",
        payload: 'incident/${incidentInfo['id']}'
      );
    });
  }
}

void showNotification({ required String title, required String content, String? payload}) {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
  NotificationDetails notificationDetails = const NotificationDetails(
    android: AndroidNotificationDetails(
      notificationChannelId, 
      "RCCDS",
      icon: "ic_bg_service_small",
      ongoing: true
    )
  );

  flutterLocalNotificationsPlugin.show(
    notificationId, title, content, notificationDetails, payload: payload);
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// const NOTIFICATION_CHANNEL_ID = "foreground_notif";
// const NOTIFICATION_ID = 888;

// class BackgroundServiceConfiguration {
//   final bool autoStart;
//   final Function(ServiceInstance service) onStartListener;
//   final Function(ServiceInstance service) onTickListener;
//   final bool isForegroundMode;
//   final String initialTitle;
//   final String initialContent;
//   final int notificationId;
  
//   final bool periodic;
//   final Duration periodDelay;


//   BackgroundServiceConfiguration({ 
//     this.autoStart = false, 
//     Function(ServiceInstance service) ? onStart,
//     Function(ServiceInstance service) ? onTick,
//     this.isForegroundMode = true,
//     this.initialTitle = 'Preparing',
//     this.initialContent = 'Background Service',
//     this.notificationId = 888,
//     this.periodic = false,
//     this.periodDelay = const Duration(seconds: 1)
//   }) : onTickListener = onTick ?? ((service) {}), 
//     onStartListener = onStart ?? ((service) {});
// }

// class BackgroundService {
//   late AndroidNotificationChannel channel;
//   static late BackgroundServiceConfiguration configuration;
//   static FlutterBackgroundService service = FlutterBackgroundService();
//   static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
//     FlutterLocalNotificationsPlugin();

//   static late ServiceInstance serviceInstance;

//   static void configure(
//     AndroidNotificationChannel chnnl,
//     BackgroundServiceConfiguration config 
//   ) async {
//     BackgroundService.channel = chnnl;
//     BackgroundService.configuration = config;
    

//     await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(chnnl);

//     await service.configure(
//       iosConfiguration: IosConfiguration(), 
//       androidConfiguration: AndroidConfiguration(
//         onStart: onStart,
//         isForegroundMode: BackgroundService.configuration.isForegroundMode,
//         autoStart: BackgroundService.configuration.autoStart,

//         notificationChannelId: channel.id,
//         initialNotificationTitle: BackgroundService.configuration.initialTitle,
//         initialNotificationContent: BackgroundService.configuration.initialContent,
//         foregroundServiceNotificationId: BackgroundService.configuration.notificationId
//       )
//     );

    
//   }

//   static void showNotification({ 
//     required String title, 
//     required String content, 
//     bool ongoing = false, 
//     String icon = 'ic_bg_service_small' }) async {
//     BackgroundServiceConfiguration configuration = BackgroundService.configuration;
//     AndroidNotificationChannel channel = BackgroundService.channel;

//     if(serviceInstance is AndroidServiceInstance) {
//       if(await (serviceInstance as AndroidServiceInstance).isForegroundService()) {
//         flutterLocalNotificationsPlugin.show(
//           configuration.notificationId, 
//           title, content, 
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id, 
//               channel.name,
//               icon: icon,
//               ongoing: ongoing
//             ),
//           ));
//       }
//     }
//   }

// }

// void onStart(ServiceInstance instance) {
//   print("onStart ran");
//   BackgroundServiceConfiguration configuration = BackgroundService.configuration;
//   DartPluginRegistrant.ensureInitialized();
//   configuration.onStartListener(instance);

//   if(configuration.periodic) {
//     Timer.periodic(configuration.periodDelay, (timer) async {
//       configuration.onTickListener(instance);
//     });
//   }
// }

// void initializeBackgroundService() async {
//   final service = FlutterBackgroundService();

//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     NOTIFICATION_CHANNEL_ID, "TEST TITLE #001",
//     description: "Some description",
//     importance: Importance.low
//   );


//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
//     FlutterLocalNotificationsPlugin();

//   await flutterLocalNotificationsPlugin
//     .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//     ?.createNotificationChannel(channel);

//   await service.configure(
//     iosConfiguration: IosConfiguration(), 
//     androidConfiguration: AndroidConfiguration(
//       onStart: onStart, 
//       isForegroundMode: true,
//       autoStart: true,

//       notificationChannelId: NOTIFICATION_CHANNEL_ID,
//       initialNotificationTitle: "Service #001",
//       initialNotificationContent: "Content #001",
//       foregroundServiceNotificationId: NOTIFICATION_ID
//     )
//   );

//   if (kDebugMode) {
//     print("Background service has been initialized.");
//   }
// }



// Future<void> onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();

//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

//   Timer.periodic(const Duration(seconds: 10), (timer) async {
//     if(service is AndroidServiceInstance) {
//       if(await service.isForegroundService()) {
//         flutterLocalNotificationsPlugin.show(
//           NOTIFICATION_ID, 
//           "Notification #001", 
//           "Message: ${DateTime.now()}", 
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               NOTIFICATION_CHANNEL_ID, 
//               "SERVICE #001",
//               icon: "ic_bg_service_small",
//               ongoing: true
//             ),
//           ));
//       }
//     }
//   });
// }