
import 'package:ralert/core/usecase/usecase.dart';
import 'package:ralert/domain/entity/emergency.entity.dart';
import 'package:ralert/domain/repository/emergency.repo.abstract.dart';

class Emergency implements FutureUsecase<void, EmergencyEntity> {
  
  final IEmergencyRepository repo;

  Emergency({required this.repo});

  @override
  Future<void> call({required EmergencyEntity params}) {
    return repo.announceEmergency(emergency: params);
  }

  Future<void> acceptEmergency(String emergencyId, String rescuerId) {
    return repo.acceptEmergency(emergencyId, rescuerId);
  }

  Future<void> resolveEmergency(String emergencyId) {
    return repo.resolveEmergency(emergencyId);
  }
  
}