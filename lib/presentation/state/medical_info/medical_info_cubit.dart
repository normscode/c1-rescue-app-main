import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralert/core/dto/medicalinfo.dto.dart';
import 'package:ralert/domain/usecase/profile/edit.medical.info.dart';

part 'medical_info_state.dart';

class MedicalInfoCubit extends Cubit<MedicalInfoState> {
  MedicalInfoCubit(this.medicalInfo) : super(MedicalInfoInitial());

  MedicalInfo medicalInfo;

  Future<void> editMedicalInfo({ required MedicalInfoDto medicalInfoDto }) async {

    emit(MedicalInfoSaving());

    await medicalInfo(params: medicalInfoDto);

    emit(MedicalInfoSaved());
    
  }
}
