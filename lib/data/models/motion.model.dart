import 'package:ralert/domain/entity/motion.entity.dart';

class MotionModel extends MotionEntity {
  MotionModel({
    required super.dateTime,
    super.location,
    super.acceleration,
    super.speed
  });
}