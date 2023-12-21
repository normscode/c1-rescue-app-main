import 'package:ralert/core/tools/record_keeper.dart';
import 'package:ralert/core/tools/vector.dart';
import 'package:ralert/data/data_sources/local/motion_datasource/abstract.dart';
import 'package:ralert/data/models/motion.model.dart';
import 'package:ralert/services/permissions.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:geolocator/geolocator.dart';

class AccelerometerRecordKeeper extends RecordKeeper<UserAccelerometerEvent, Vector2D> {
  AccelerometerRecordKeeper() : super(initial: Vector2D.zero(), delay: 500);

  @override
  Vector2D add(Vector2D cumulative, Vector2D current) {
    return Vector2D.add(cumulative, current);
  }

  @override
  Vector2D getAverage(Vector2D cumulative, int counter) {
    return Vector2D.scale(cumulative, 1/counter);
  }

  @override
  Vector2D processStreamEvent(UserAccelerometerEvent streamEvent) {
    return Vector2D(streamEvent.x, streamEvent.y);
  }
}

class MotionLocalDatasource implements IMotionLocalDatasource {
  static AccelerometerRecordKeeper accelerometerRecorder = AccelerometerRecordKeeper();

  static Future<void> initialize() async {
    final recorder = MotionLocalDatasource.accelerometerRecorder;

    if(!recorder.hasStarted) {
      MotionLocalDatasource.accelerometerRecorder.start(userAccelerometerEvents);
    }
    
  }

  Future<Location> getCurrentPosition() async {
    await ensurePermissions();
    
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return Location(longitude: position.longitude, latitude: position.latitude);
  }

  @override
  AccelerometerRecordKeeper onMotion() {
    return accelerometerRecorder;
  }

  @override
  Future<MotionModel> getMotionData() async {
    Vector2D acceleration = MotionLocalDatasource.accelerometerRecorder.value;
    Location location = await getCurrentPosition();

    return MotionModel(
      dateTime: DateTime.now(), 
      location: location,
      acceleration: acceleration
    );
  }
}