import 'package:ralert/core/dto/verification.dto.dart';
import 'package:ralert/domain/repository/verification.repo.abstract.dart';

class Verification {
  final IVerificationRepository repo;

  Verification({
    required this.repo,
  });

  Future<void> call({required VerificationDto params}) async {
    return await repo.verify(verificationDto: params);
  }

  Future<String> getVerificationStatus({ required String userId }) async {
    return await repo.getVerificationStatus(userId: userId);
  }
  
  Future<void> verified({ required String userId }) async {
    return await repo.verified(userId: userId);
  }

  Future<void> denied({ required String userId }) async {
    return await repo.denied(userId: userId);
  }
}
