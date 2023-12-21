import 'package:ralert/domain/repository/emergency.repo.abstract.dart';

class EmergencyRadar {
  final IEmergencyRepository repo;

  EmergencyRadar({
    required this.repo,
  });

  Future<void> call({ required Function(dynamic incidentInfo) listen }) {
    return repo.listenToEmergencies(listen: listen);
  }
}
