import 'package:ralert/core/dto/crashmotion.dto.dart';
import 'package:ralert/core/tools/countdown_timer.dart';
import 'package:ralert/domain/entity/motion.entity.dart';
import 'package:ralert/services/background_service.dart';

CrashMotion? checkCarCrash(value, recordKeeper) {
  if (value.x > 40 && value.y > 40) {
    MotionEntity motionData = MotionEntity(
        dateTime: DateTime.now(), acceleration: recordKeeper.value);

    return CrashMotion(motion: motionData, isCarCrash: true);
  }

  return null;
}

void carCrashDetected() {
  CountdownTimer countdownTimer = CountdownTimer(15, onTick: (int seconds) {
    showNotification(
        title: "Ralert Car Crash Safety Detection",
        content: "We detected a car crash! Alerting rescuers in $seconds",
        payload: 'alert-sending/$seconds');
  }, onDone: () {
    showNotification(
        title: "Ralert Car Crash Safety Detection",
        content: "Help is coming your way!",
        payload: 'alert-sent/0');
  });

  // Start the countdown timer
  countdownTimer.start();
}
