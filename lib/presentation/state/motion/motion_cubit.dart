import 'package:bloc/bloc.dart';
import 'package:ralert/core/tools/vector.dart';
import 'package:ralert/domain/usecase/motion/get_motion.dart';
import 'package:ralert/services/carcrash_detection.dart';

part 'motion_state.dart';

class MotionCubit extends Cubit<MotionState> {
  MotionCubit(
    this.motion
  ) : super(MotionState());
  final Motion motion;

  void onMotion() {
    final localMotion = motion();

    localMotion.addListener((value) {

      emit(MotionState(value: localMotion.value));

      final crashMotion = checkCarCrash(value, localMotion);

      if (crashMotion == null) {
        return;
      }

      if(crashMotion.isCarCrash) {
        emit(CarCrashDetectedState());
      }

    });
  }
}
