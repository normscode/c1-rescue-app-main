
import 'package:ralert/domain/entity/emergency.entity.dart';

class EmergencyType {
  static const carCrash = "car-crash";
  static const distressSignal = "distress-signal";
}

/// Used explicitly by the Presentation layer
class EmergencyDto extends EmergencyEntity {
  EmergencyDto({
    required super.id,
    required super.emergencyType,
    required super.locationLat,
    required super.locationLng,
    required super.dateTime,
    required super.acceleration,
    required super.user,
    super.resolved = false,
    super.resolvedDate = null,
    super.resolvedRescuer = null,
    super.lifeThreatening = true
  });

  factory EmergencyDto.fromEntity(EmergencyEntity entity) {
    return EmergencyDto(
      id: entity.id,
      emergencyType: entity.emergencyType, 
      locationLat: entity.locationLat, 
      locationLng: entity.locationLng, 
      dateTime: entity.dateTime, 
      acceleration: entity.acceleration, 
      user: entity.user, 
      resolved: entity.resolved, 
      resolvedDate: entity.resolvedDate, 
      resolvedRescuer: entity.resolvedRescuer,
      lifeThreatening: entity.lifeThreatening
    );
  }
}
