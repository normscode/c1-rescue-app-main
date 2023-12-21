import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralert/domain/entity/user.entity.dart';
import 'package:ralert/domain/usecase/auth/get_user.dart';

part 'getself_state.dart';

class GetselfCubit extends Cubit<GetselfState> {
  GetselfCubit(this.getSelf) : super(GetselfInitial());

  GetSelfUser getSelf;

  Future<UserEntity?> fetchUser() async {
    return getSelf();
  }
}
