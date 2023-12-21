

import 'package:ralert/core/dto/verification.dto.dart';

abstract class IVerificationRemoteDatasource {
  Future<void> verify({ required VerificationDto verificationDto });
  Future<String> getVerificationStatus({ required String userId });
  Future<void> verified({ required String userId });
  Future<void> denied({ required String userId });
}