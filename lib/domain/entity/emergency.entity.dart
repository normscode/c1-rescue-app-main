import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ralert/domain/entity/user.entity.dart';

class EmergencyType {
  static const carCrash = "car-crash";
  static const distressSignal = "distress-signal";
}

class EmergencyEntity {
  final String id;
  final String emergencyType;
  final double locationLat;
  final double locationLng;
  final Timestamp dateTime;
  final int acceleration;
  final UserEntity user;
  final bool resolved;
  final bool accepted;
  final String? rescuerAcceptor;
  final Timestamp? resolvedDate;
  final UserEntity? resolvedRescuer;
  final bool lifeThreatening;
  List<String?>? targetRescuers;

  EmergencyEntity({
    required this.id,
    required this.emergencyType,
    required this.locationLat,
    required this.locationLng,
    required this.dateTime,
    required this.acceleration,
    required this.user,
    this.resolved = false,
    this.accepted = false,
    this.rescuerAcceptor,
    this.resolvedDate,
    this.resolvedRescuer,
    this.targetRescuers,
    this.lifeThreatening = true
  });

}
