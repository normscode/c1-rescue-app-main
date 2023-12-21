
import 'package:ralert/data/data_sources/remote/emergency_datasource/abstract.dart';
import 'package:ralert/domain/entity/emergency.entity.dart';
import 'package:ralert/domain/repository/emergency.repo.abstract.dart';

class EmergencyRepositoryImpl implements IEmergencyRepository {
  final IEmergencyRemoteDatasource remote;

  EmergencyRepositoryImpl({required this.remote});

  @override
  Future<void> announceEmergency({required EmergencyEntity emergency}) {
    return remote.announceEmergency(emergency: emergency);
  }

  @override
  Future<void> acceptEmergency(String emergencyId, String rescuerID) {
    return remote.acceptEmergency(emergencyId, rescuerID);
  }
  
  @override
  Future<void> listenToEmergencies({required Function(dynamic incidentInfo) listen}) {
    return remote.listenToEmergencies(listen: listen);
  }
  
  @override
  Future<void> resolveEmergency(String emergencyId) {
    return remote.resolveEmergency(emergencyId);
  }
  
  @override
  Future<void> listenToOneEmergency(String emergencyId, {required Function(dynamic newChanges) listen}) {
    return remote.listenToOneEmergency(emergencyId, listen: listen);
  }

  @override
  Future<List<dynamic>> fetchIncidents() {
    return remote.fetchIncidents();
  }
  
  @override
  Future<List> fetchOnGoingByRescuerId(String rescuerID) {
    return remote.fetchOnGoingByRescuerId(rescuerID);
  }
  
  @override
  Future<List> fetchUnsolved() {
    return remote.fetchUnsolved();
  }
  
  @override
  Future<List> fetchResolved() {
    return remote.fetchResolved();
  }
  
  @override
  Future<List> fetchResolvedByRescuerId(String rescuerID) {
    return remote.fetchResolvedByRescuerId(rescuerID);
  }
  
}