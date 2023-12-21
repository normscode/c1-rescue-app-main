part of 'medical_info_cubit.dart';

sealed class MedicalInfoState extends Equatable {
  const MedicalInfoState();

  @override
  List<Object> get props => [];
}

final class MedicalInfoInitial extends MedicalInfoState {}

final class MedicalInfoSaving extends MedicalInfoState {}

final class MedicalInfoSaved extends MedicalInfoState {}

