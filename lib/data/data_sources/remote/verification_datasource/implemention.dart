import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ralert/core/dto/verification.dto.dart';
import 'package:ralert/data/data_sources/remote/verification_datasource/abstract.dart';
import 'package:ralert/data/models/verification.model.dart';

class VerificationRemoteDatasource implements IVerificationRemoteDatasource {

  final CollectionReference<Map<String, dynamic>> collection = 
    FirebaseFirestore.instance.collection('verification');

  @override
  Future<void> verify({ required VerificationDto verificationDto }) async {
    VerificationModel model = VerificationModel(
      userId: FirebaseAuth.instance.currentUser!.uid,
      selfieUrl: verificationDto.selfieUrl,
      idUrl: verificationDto.idUrl,
      videoUrl: verificationDto.videoUrl,
      status: 'verifying'
    );

    await collection.doc(model.userId).set(model.toMap());
  }
  
  @override
  Future<String> getVerificationStatus({required String userId}) async {

    try {
      final userVerificationStatus = await collection.doc(userId).get();
      final verificationModel  = VerificationModel.fromMap(userVerificationStatus.data()!);

      return verificationModel.status;

    } catch (_) {
      return 'unverified';
    }  
    
  }
  
  @override
  Future<void> denied({required String userId}) async {
    final userVerificationReference = collection.doc(userId);

    userVerificationReference.update({ 'status': 'denied' });
  }
  
  @override
  Future<void> verified({required String userId}) async {
    final userVerificationReference = collection.doc(userId);

    userVerificationReference.update({ 'status': 'verified' });
  }
  
}