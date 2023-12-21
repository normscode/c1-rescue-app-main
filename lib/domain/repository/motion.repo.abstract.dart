
import 'package:ralert/data/data_sources/local/motion_datasource/implementation.dart';
import 'package:ralert/data/models/motion.model.dart';

abstract class IMotionRepository {
  AccelerometerRecordKeeper onMotion();
  Future<MotionModel> getMotionData();
}