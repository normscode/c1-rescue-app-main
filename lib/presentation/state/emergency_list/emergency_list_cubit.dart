import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralert/core/global/global.variable.dart';
import 'package:ralert/domain/usecase/emergency_list/emergency_list.dart';

part 'emergency_list_state.dart';

class EmergencyListCubit extends Cubit<EmergencyListState> {

  EmergencyList emergencyList;

  EmergencyListCubit(this.emergencyList) : super(EmergencyListInitial());

  Future<List<dynamic>> getIncidents() async {

    emit(EmergencyListFetching());

    final List<dynamic> incidents = await emergencyList();

    emit(EmergencyListFetched(incidents));

    return incidents;
    
  }

  Future<List<dynamic>> getAccepted() async {
    final List<dynamic> onGoing = await emergencyList.fetchAcceptedByRescuerId(currentUserId);

    return onGoing;
  }

  Future<List<dynamic>> getUnsolved() async {
    final List<dynamic> unsolved = await emergencyList.fetchUnsolved();

    return unsolved;
  }

  Future<List<dynamic>> getResolved() async {
    final List<dynamic> resolved = await emergencyList.fetchResolved();

    return resolved;
  }

  Future<List<dynamic>> getResolvedRescuer() async {
    final List<dynamic> resolved = await emergencyList.fetchResolvedByRescuerId(currentUserId);

    return resolved;
  }

}
