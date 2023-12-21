import 'package:ralert/domain/repository/emergency.repo.abstract.dart';

class EmergencyLive {
  final IEmergencyRepository repo;

  EmergencyLive({
    required this.repo,
  });

  Future<void> call(String emergencyId, { required Function(dynamic newChanges) listen }) {
    return repo.listenToOneEmergency(emergencyId, listen: listen);
  }
}
