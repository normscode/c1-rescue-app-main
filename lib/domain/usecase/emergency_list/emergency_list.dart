
import 'package:ralert/domain/repository/emergency.repo.abstract.dart';

class EmergencyList {
  final IEmergencyRepository repo;

  EmergencyList({ required this.repo });

  Future<List<dynamic>> call() {
    return repo.fetchIncidents();
  }

  Future<List<dynamic>> fetchAcceptedByRescuerId(String rescuerID) {
    return repo.fetchOnGoingByRescuerId(rescuerID);
  }

  Future<List<dynamic>> fetchUnsolved() {
    return repo.fetchUnsolved();
  }

  Future<List<dynamic>> fetchResolved() {
    return repo.fetchResolved();
  }

  Future<List<dynamic>> fetchResolvedByRescuerId(String rescuerID) {
    return repo.fetchResolvedByRescuerId(rescuerID);
  }

}