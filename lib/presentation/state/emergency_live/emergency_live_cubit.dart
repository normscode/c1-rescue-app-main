import 'package:bloc/bloc.dart';
import 'package:ralert/core/global/global.variable.dart';
import 'package:ralert/data/models/user.model.dart';
import 'package:ralert/domain/usecase/emergency/emergency.live.dart';

part 'emergency_live_state.dart';

class EmergencyLiveCubit extends Cubit<EmergencyLiveState> {
  EmergencyLiveCubit(this.live) : super(EmergencyOfflineState(null));

  final EmergencyLive live;

  void onLive(String emergencyId) {
    live(emergencyId, listen: (newChanges) {

      if (newChanges == null) return;

      emit(EmergencyLiveState(newChanges));

      if (newChanges['accepted'] == true) {
        emit(EmergencyOfflineState(null));
      }
    });
  }

  Future<void> onLiveUser(String emergencyId) async {
    print(emergencyId);
    await live(emergencyId, listen: (newChanges) async {

      print("There is new changes $newChanges");

      if (newChanges == null) return;

      emit(EmergencyLiveState(newChanges));

      if (newChanges['accepted'] == true) {

        final rescuerData = await getUser(newChanges['rescuerAcceptor']);
        final rescuer = RescuerModel.fromMap(rescuerData.data());

        emit(EmergencyAcceptedState(rescuer));
      }
    });
  }
}
