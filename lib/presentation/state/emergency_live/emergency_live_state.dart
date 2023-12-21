part of 'emergency_live_cubit.dart';

class EmergencyLiveState {
  final dynamic data;

  EmergencyLiveState(this.data);
}

class EmergencyOfflineState extends EmergencyLiveState {
  EmergencyOfflineState(super.data);
}

class EmergencyAcceptedState extends EmergencyLiveState {
  EmergencyAcceptedState(super.data);
}