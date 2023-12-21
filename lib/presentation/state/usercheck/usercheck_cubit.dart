import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ralert/core/global/global.variable.dart';
import 'package:ralert/domain/usecase/auth/usercheck.dart';

part 'usercheck_state.dart';

class UsercheckCubit extends Cubit<UsercheckState> {
  UsercheckCubit(
    this.usercheck,
  ) : super(Authenticating());
  final Usercheck usercheck;

  void onUsercheck() {
    final localusercheck = usercheck();
    
    localusercheck.listen((user) async {
      if (user == null) {
        emit(UnAuthenticated());
      } else {
        final user = await getUser(FirebaseAuth.instance.currentUser!.uid);

        emit(Authenticated(user));  
      }
    });
  }
}
