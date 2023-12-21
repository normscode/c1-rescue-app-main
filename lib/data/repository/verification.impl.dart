
import 'package:ralert/core/dto/verification.dto.dart';
import 'package:ralert/data/data_sources/remote/verification_datasource/abstract.dart';
import 'package:ralert/domain/repository/verification.repo.abstract.dart';

class VerificationRepositoryImpl implements IVerificationRepository {
  final IVerificationRemoteDatasource remote;

  VerificationRepositoryImpl({required this.remote});
  
  @override
  Future<void> verify({ required VerificationDto verificationDto }) {
    return remote.verify(verificationDto: verificationDto);
  }
  
  @override
  Future<String> getVerificationStatus({required String userId}) {
    return remote.getVerificationStatus(userId: userId);
  }
  
  @override
  Future<void> denied({required String userId}) {
    return remote.denied(userId: userId);
  }
  
  @override
  Future<void> verified({required String userId}) {
    return remote.verified(userId: userId);
  }
  
}