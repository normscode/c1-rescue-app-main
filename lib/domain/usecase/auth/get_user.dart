import 'package:ralert/core/usecase/usecase.dart';
import 'package:ralert/domain/entity/user.entity.dart';
import 'package:ralert/domain/repository/user.repo.abstract.dart';

class GetUser implements FutureUsecase<UserEntity?, String> {
  final IUserRepository repo;

  GetUser({ required this.repo });

  @override
  Future<UserEntity?> call({required String params}) {
    return repo.getUser(params);
  }
}

class GetSelfUser implements FutureUsecase<UserEntity?, void> {
  final IUserRepository repo;

  GetSelfUser({ required this.repo });

  @override
  Future<UserEntity?> call({void params}) {
    return repo.getSelfUser();
  }
}