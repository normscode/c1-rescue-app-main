import 'package:ralert/core/dto/register.dto.dart';
import 'package:ralert/core/usecase/usecase.dart';
import 'package:ralert/domain/repository/user.repo.abstract.dart';

class Register implements FutureUsecase<void, RegisterDto> {
  final IUserRepository repo;
  Register({
    required this.repo,
  });

  @override
  Future<void> call({required RegisterDto params}) async {
    return await repo.register(registerDto: params);
  }
}
