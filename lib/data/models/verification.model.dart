import 'package:ralert/domain/entity/verification.entity.dart';

class VerificationModel extends VerificationEntity {

  VerificationModel({
    required super.userId,
    required super.selfieUrl,
    required super.idUrl,
    required super.videoUrl,
    required super.status
  });


  factory VerificationModel.fromEntity(VerificationEntity entity) {
    return VerificationModel(
      userId: entity.userId,
      selfieUrl: entity.selfieUrl,
      idUrl: entity.idUrl,
      videoUrl: entity.videoUrl,
      status: entity.status
    );
  }
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'selfieUrl': selfieUrl,
      'idUrl': idUrl,
      'videoUrl': videoUrl,
      'status': status
    };
  }

  factory VerificationModel.fromMap(Map<String, dynamic> map) {
    return VerificationModel(
      userId: map['userId'] as String,
      selfieUrl: map['selfieUrl'] as String,
      idUrl: map['idUrl'] as String,
      videoUrl: map['videoUrl'] as String,
      status: map['status'] as String,
    );
  }

}
