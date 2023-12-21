import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:ralert/core/dto/emergency.dto.dart';
import 'package:ralert/domain/entity/motion.entity.dart';
import 'package:ralert/domain/entity/user.entity.dart';
import 'package:ralert/domain/usecase/auth/get_user.dart';
import 'package:ralert/domain/usecase/emergency/emergency.dart';
import 'package:ralert/domain/usecase/motion/get_motion.dart';
import 'package:uuid/uuid.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {

  final Emergency emergency;
  final GetSelfUser getSelf;
  final Motion motion;

  EmergencyCubit( 
    this.emergency, 
    this.getSelf, 
    this.motion 
  ) : super(EmergencyInitial());
  
  void checkEmergencyAcceptance(bool accepted) {
    if (accepted == true) {
      emit(EmergencyAccepted());
    } else {
      emit(EmergencyInitial());
    }
  }

  Future<String> sendSOS({ bool? lifeThreatening }) async {
    UserEntity? currentUser = await getSelf(params: null);
    MotionEntity motionData = await motion.getMotionData();

    final id = const Uuid().v4();

    EmergencyDto emergencyDto = EmergencyDto(
      id: id,
      emergencyType: EmergencyType.distressSignal,
      locationLat: motionData.location!.latitude, 
      locationLng: motionData.location!.longitude,
      dateTime: Timestamp.now(), 
      acceleration: 0, 
      user: currentUser!,
      lifeThreatening: lifeThreatening ?? true
    );

    announceEmergency(emergencyDto: emergencyDto);

    return id;
  }

  Future<void> announceEmergency({ required EmergencyDto emergencyDto }) async {
    emit(AnnouncingEmergency());

    await emergency(params: emergencyDto);

    emit(EmergencyAnnounced());
  }

  Future<void> acceptEmergency(String emergencyId, String rescuerID) async {
    await emergency.acceptEmergency(emergencyId, rescuerID);

    emit(EmergencyAccepted());
  }

  Future<void> resolveEmergency(String emergencyId) async {
    await emergency.resolveEmergency(emergencyId);

    emit(EmergencyResolved());
  }
}
