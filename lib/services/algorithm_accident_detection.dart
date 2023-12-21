import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:all_sensors/all_sensors.dart';

class RescueAlertSystem {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Position? _currentLocation;
  double _speed = 0.0;

  void initialize() async {
    await Firebase.initializeApp();
  }

  void startMonitoring() {
    allSensorsEvents.listen((SensorEvent event) {
      if (event.sensorType == SensorType.accelerometer) {
        double acceleration = (event.data![0] * event.data![0] +
                event.data![1] * event.data![1] +
                event.data![2] * event.data![2])
            .sqrt();

        if (_currentLocation != null && _speed > 30.0) {
          if (_speed == 0.0 || acceleration > 4.0) {
            triggerAlert();
          }
        }
      }
    });

    Timer.periodic(Duration(seconds: 10), (Timer timer) async {
      _currentLocation = await Geolocator.getCurrentPosition();
      _speed = await Geolocator().getCurrentSpeed();
    });
  }

  void triggerAlert() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      _database.reference().child('alerts').push().set({
        'userId': user.uid,
        'latitude': _currentLocation!.latitude,
        'longitude': _currentLocation!.longitude,
        'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
      });

      print('Accident detected! Sending alert...');
    }
  }
}
