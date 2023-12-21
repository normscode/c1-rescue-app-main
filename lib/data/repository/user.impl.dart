
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ralert/core/dto/login.dto.dart';
import 'package:ralert/core/dto/medicalinfo.dto.dart';
import 'package:ralert/core/dto/register.dto.dart';
import 'package:ralert/core/dto/updateprofile.dto.dart';
import 'package:ralert/data/data_sources/remote/user_datasource/abstract.dart';
import 'package:ralert/domain/entity/user.entity.dart';
import 'package:ralert/domain/repository/user.repo.abstract.dart';

class UserRepositoryImpl implements IUserRepository {
  final IUserRemoteDatasource remote;

  UserRepositoryImpl({required this.remote});

  @override
  Stream<User?> userCheck() {
    return remote.userCheck();
  }

  @override
  Future<void> login({required LoginDto loginDto}) {
    return remote.login(loginDto: loginDto);
  }

  @override
  Future<void> register({required RegisterDto registerDto}) {
    return remote.register(registerDto: registerDto);
  }

  @override
  Future<UserEntity?> getUser(String id) {
    return remote.getUser(id);
  }

  @override
  Future<UserEntity?> getSelfUser() {
    return remote.getSelfUser();
  }

  @override
  Future<void> updateProfile({ required UpdateProfileDto updateProfileDto }) {
    return remote.updateProfile(updateProfileDto: updateProfileDto);
  }
  
  @override
  Future<void> editMedicalInfo({ required MedicalInfoDto medicalInfoDto }) {
    return remote.editMedicalInfo(medicalInfoDto: medicalInfoDto);
  }
}