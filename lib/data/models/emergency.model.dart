
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ralert/domain/entity/emergency.entity.dart';
import 'package:ralert/domain/entity/user.entity.dart';

class EmergencyModel extends EmergencyEntity {

  EmergencyModel({
    required super.id,
    required super.emergencyType,
    required super.locationLat,
    required super.locationLng,
    required super.dateTime,
    required super.acceleration,
    required super.user,
    required super.resolved,
    required super.accepted,
    required super.rescuerAcceptor,
    required super.resolvedDate,
    required super.resolvedRescuer,
    required super.targetRescuers,
    super.lifeThreatening
  });


  factory EmergencyModel.fromEntity(EmergencyEntity entity) {
    return EmergencyModel(
      id: entity.id,
      emergencyType: entity.emergencyType, 
      locationLat: entity.locationLat, 
      locationLng: entity.locationLng, 
      dateTime: entity.dateTime, 
      acceleration: entity.acceleration, 
      user: entity.user, 
      resolved: entity.resolved,
      accepted: entity.accepted,
      rescuerAcceptor: entity.rescuerAcceptor,
      resolvedDate: entity.resolvedDate, 
      resolvedRescuer: entity.resolvedRescuer,
      targetRescuers: entity.targetRescuers,
      lifeThreatening: entity.lifeThreatening
    );
  }
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'emergencyType': emergencyType,
      'locationLat': locationLat,
      'locationLng': locationLng,
      'dateTime': dateTime,
      'acceleration': acceleration,
      'user': user.id,
      'resolved': resolved,
      'accepted': accepted,
      'rescuerAcceptor': rescuerAcceptor,
      'resolvedDate': resolvedDate,
      'resolvedRescuer': resolvedRescuer?.id,
      'targetRescuers': targetRescuers,
      'lifeThreatening': lifeThreatening
    };
  }

  factory EmergencyModel.fromMap(Map<String, dynamic> map) {
    return EmergencyModel(
      id: map['id'] as String,
      emergencyType: map['emergencyType'] as String,
      locationLat: map['locationLat'] as double,
      locationLng: map['locationLng'] as double,
      dateTime: map['dateTime'] as Timestamp,
      acceleration: map['acceleration'] as int,
      user: map['user'] as UserEntity,
      resolved: map['resolved'] as bool,
      accepted: map['accepted'] as bool,
      rescuerAcceptor: map['rescuerAcceptor'] as String?,
      resolvedDate: map['resolvedDate'] as Timestamp,
      resolvedRescuer: map['resolvedRescuer'] as UserEntity,
      targetRescuers: map['targetRescuers'] as List<String>,
      lifeThreatening: map['lifeThreatening'] as bool
    );
  }
}
