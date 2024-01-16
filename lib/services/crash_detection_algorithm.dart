import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sensors_plus/sensors_plus.dart';

class CrashDetection {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {});
  }

  Future<bool> isCrashDetectedFromSensorPlus() async {
    try {
      final response = await http.get('SENSOR_PLUS_API_ENDPOINT');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data['isCrashDetected'];
      } else {
        throw Exception('Failed to fetch data from SensorPlus API');
      }
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  Future<void> startCrashDetection() async {
    await initializeNotifications();

    Timer.periodic(Duration(seconds: 10), (Timer timer) async {
      Location location = Location();
      LocationData currentLocation = await location.getLocation();
      double currentSpeed = currentLocation.speed ?? 0;

      if (await isCrashDetectedFromSensorPlus() &&
          currentSpeed > 30 &&
          currentSpeed == 0) {
        showNotification();
      }
    });
  }

  void showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'crash_detection_channel',
      'Crash Detection',
      'Notify when a crash is detected',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Crash Detected!',
      'A potential car crash has been detected.',
      platformChannelSpecifics,
    );
  }
}
