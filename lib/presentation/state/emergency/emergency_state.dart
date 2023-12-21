part of 'emergency_cubit.dart';

sealed class EmergencyState extends Equatable {
  const EmergencyState();

  @override
  List<Object> get props => [];
}

final class EmergencyInitial extends EmergencyState {}

final class AnnouncingEmergency extends EmergencyState {}

final class EmergencyAnnounced extends EmergencyState {}

final class EmergencyAccepted extends EmergencyState {}

final class EmergencyResolved extends EmergencyState {}