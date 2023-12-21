import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ralert/core/dto/login.dto.dart';
import 'package:ralert/core/dto/register.dto.dart';
import 'package:ralert/domain/entity/motion.entity.dart';
import 'package:ralert/domain/usecase/auth/login.dart';
import 'package:ralert/domain/usecase/auth/register.dart';
import 'package:ralert/domain/usecase/motion/get_motion.dart';
import 'package:ralert/domain/usecase/verification/verification.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final Login login;
  final Register register;
  final Verification verification;
  final Motion getMotion;

  AuthCubit(this.login, this.register, this.verification, this.getMotion) : super(AuthInitial());

  void onLogin({ required LoginDto loginDto }) async {
    emit(LoggingIn());

    try {
      await login(params: loginDto);

      emit(LoggedIn());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message !));
    }

  }

  void onRegister({ required RegisterDto registerDto }) async {
    emit(Registering());

    MotionEntity motionData = await getMotion.getMotionData();
    registerDto.location = motionData.location;
    registerDto.available = true;

    try {
      await register(params: registerDto);
      
      emit(Registered());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(message: e.message!));
    }

  }

}
