
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ralert/core/dto/login.dto.dart';
import 'package:ralert/core/dto/medicalinfo.dto.dart';
import 'package:ralert/core/dto/register.dto.dart';
import 'package:ralert/core/dto/updateprofile.dto.dart';
import 'package:ralert/domain/entity/user.entity.dart';

abstract class IUserRepository {
  Stream<User?> userCheck();
  Future<void> login({ required LoginDto loginDto });
  Future<void> register({ required RegisterDto registerDto });
  Future<UserEntity?> getUser(String id);
  Future<UserEntity?> getSelfUser();
  Future<void> updateProfile({ required UpdateProfileDto updateProfileDto });
  Future<void> editMedicalInfo({ required MedicalInfoDto medicalInfoDto });
}