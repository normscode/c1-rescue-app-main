import 'package:ralert/core/dto/medicalinfo.dto.dart';
import 'package:ralert/core/usecase/usecase.dart';
import 'package:ralert/domain/repository/user.repo.abstract.dart';

class MedicalInfo implements FutureUsecase<void, MedicalInfoDto> {
  final IUserRepository repo;
  MedicalInfo({
    required this.repo,
  });

  @override
  Future<void> call({required MedicalInfoDto params}) async {
    return await repo.editMedicalInfo(medicalInfoDto: params);
  }
}
