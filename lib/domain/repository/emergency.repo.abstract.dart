
import 'package:ralert/domain/entity/emergency.entity.dart';

abstract class IEmergencyRepository {
  Future<void> announceEmergency({ required EmergencyEntity emergency });
  Future<void> acceptEmergency(String emergencyId, String rescuerID);
  Future<void> resolveEmergency(String emergencyId);
  Future<void> listenToEmergencies({ required Function(dynamic incidentInfo) listen });
  Future<void> listenToOneEmergency(String emergencyId, { required Function(dynamic newChanges) listen });
  Future<List<dynamic>> fetchIncidents();
  Future<List<dynamic>> fetchOnGoingByRescuerId(String rescuerID);
  Future<List<dynamic>> fetchUnsolved();
  Future<List<dynamic>> fetchResolved();
  Future<List<dynamic>> fetchResolvedByRescuerId(String rescuerID);
}