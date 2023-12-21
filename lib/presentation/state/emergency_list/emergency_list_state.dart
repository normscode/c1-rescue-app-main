part of 'emergency_list_cubit.dart';

sealed class EmergencyListState extends Equatable {
  const EmergencyListState();

  @override
  List<Object> get props => [];
}

final class EmergencyListInitial extends EmergencyListState {}

final class EmergencyListFetching extends EmergencyListState {}

final class EmergencyListFetched extends EmergencyListState {
  final List<dynamic> data;

  const EmergencyListFetched(this.data);
}
