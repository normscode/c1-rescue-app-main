import 'package:ralert/core/dto/login.dto.dart';
import 'package:ralert/core/usecase/usecase.dart';
import 'package:ralert/domain/repository/user.repo.abstract.dart';

class Login implements FutureUsecase<void, LoginDto> {
  final IUserRepository repo;
  Login({
    required this.repo,
  });

  @override
  Future<void> call({required LoginDto params}) async {
    return await repo.login(loginDto: params);
  }
}
