import 'package:bloc/bloc.dart';
import 'package:ralert/domain/usecase/emergency/emergency.radar.dart';

part 'radar_state.dart';

class RadarCubit extends Cubit<RadarState> {
  RadarCubit(this.emergencyRadar) : super(RadarNone(null));

  final EmergencyRadar emergencyRadar;

  void onRadar() {
    emergencyRadar(listen: (incidentInfo) {
      emit(RadarStateValue(incidentInfo));
    });
  }
}
