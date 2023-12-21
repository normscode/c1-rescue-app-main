import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ralert/core/dto/verification.dto.dart';
import 'package:ralert/domain/usecase/verification/verification.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {

  Verification verify;

  VerificationCubit(this.verify) : super(VerificationInitial());

  Future<void> verifyUser() async {
    final storage = FirebaseStorage.instance;

    final uid = FirebaseAuth.instance.currentUser!.uid;
    
    final idUrl = await storage.ref("user_verification/$uid/id.png").getDownloadURL();
    final selfieUrl = await storage.ref("user_verification/$uid/selfie.png").getDownloadURL();
    final videoUrl = await storage.ref("user_verification/$uid/video.mp4").getDownloadURL();

    VerificationDto verificationDto = VerificationDto(userId: uid, selfieUrl: selfieUrl, idUrl: idUrl, videoUrl: videoUrl);

    if (await getVerificationStatus(FirebaseAuth.instance.currentUser!.uid) == "verified" 
      || await getVerificationStatus(FirebaseAuth.instance.currentUser!.uid) == "verifying") {
      return;
    }

    verify(params: verificationDto);
  }

  Future<String> getVerificationStatus(String uid) async {
    final verificationStatus = await verify.getVerificationStatus(userId: uid);

    if (verificationStatus == 'verified') {
      emit(VerificationVerified());

      return 'verified';
    } else if (verificationStatus == 'verifying') {
      emit(VerificationVerifying());

      return 'verifying';
    } else {
      emit(VerificationUnverified());

      return 'unverified';
    }

  }

}
