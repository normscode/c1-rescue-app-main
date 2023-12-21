
import 'package:ralert/domain/entity/motion.entity.dart';

class CrashMotion {
  final MotionEntity? motion;
  final bool isCarCrash;

  CrashMotion({ this.motion, required this.isCarCrash });

  @override
  String toString() {
    return "{crashed=$isCarCrash} ${motion.toString()}";
  }
}