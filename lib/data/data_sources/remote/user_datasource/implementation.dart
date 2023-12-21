import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ralert/core/dto/login.dto.dart';
import 'package:ralert/core/dto/medicalinfo.dto.dart';
import 'package:ralert/core/dto/register.dto.dart';
import 'package:ralert/core/dto/updateprofile.dto.dart';
import 'package:ralert/data/data_sources/remote/user_datasource/abstract.dart';
import 'package:ralert/data/models/user.model.dart';

class UserRemoteDatasource implements IUserRemoteDatasource {
  final auth = FirebaseAuth.instance;
  final collection = FirebaseFirestore.instance.collection('user');

  @override
  Stream<User?> userCheck() {
    return auth.userChanges();
  }

  @override
  Future<void> login({required LoginDto loginDto}) async {
    await auth.signInWithEmailAndPassword(
      email: loginDto.email,
      password: loginDto.password
    );
  }

  @override
  Future<void> register({required RegisterDto registerDto}) async {
    final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: registerDto.email,
      password: registerDto.password,
    );

    if (userCredential.user != null) {
      await collection.doc(userCredential.user!.uid).set({
        'id': userCredential.user!.uid,
        'email': registerDto.email,
        'password': registerDto.password,
        'firstName': registerDto.firstName,
        'middleName': registerDto.middleName,
        'lastName': registerDto.lastName,
        'gender': registerDto.gender,
        'age': registerDto.age,
        'contactNumber': registerDto.contactNumber,
        'userType': registerDto.userType,
        'locationLat': registerDto.location!.latitude,
        'locationLng': registerDto.location!.longitude,
        'available': registerDto.available,
        'verified': false
      });
    }
  }

  @override
  Future<UserModel?> getSelfUser() async {
    String selfUserId = FirebaseAuth.instance.currentUser!.uid;
    if(selfUserId != '') return await getUser(selfUserId);
    return null;
  }

  @override
  Future<UserModel?> getUser(String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await collection.doc(id).get();
    Map<String, dynamic>? data = snapshot.data();

    if(data != null) return UserModel.fromMap(data);
    return null;
  }
  
  @override
  Future<void> updateProfile({ required UpdateProfileDto updateProfileDto }) async {
    
    final updateProfile = UpdateProfileModel.fromDTO(updateProfileDto);
    final DocumentReference userReference = collection.doc(FirebaseAuth.instance.currentUser!.uid);

    await userReference.update(updateProfile.toMap());

  }

  @override
  Future<void> editMedicalInfo({ required MedicalInfoDto medicalInfoDto }) async {
    
    final medicalInfo = MedicalInformationModel.fromDTO(medicalInfoDto);
    final DocumentReference userReference = collection.doc(FirebaseAuth.instance.currentUser!.uid);

    await userReference.update({
      'medicalInfo': medicalInfo.toMap()
    });

  }
  
}
