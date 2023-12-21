import 'package:ralert/core/dto/updateprofile.dto.dart';
import 'package:ralert/core/usecase/usecase.dart';
import 'package:ralert/domain/repository/user.repo.abstract.dart';

class UpdateProfile implements FutureUsecase<void, UpdateProfileDto> {
  final IUserRepository repo;
  UpdateProfile({
    required this.repo,
  });

  @override
  Future<void> call({required UpdateProfileDto params}) async {
    return await repo.updateProfile(updateProfileDto: params);
  }
}
