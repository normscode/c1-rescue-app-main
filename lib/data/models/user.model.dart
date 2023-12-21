import 'package:ralert/core/dto/medicalinfo.dto.dart';
import 'package:ralert/core/dto/updateprofile.dto.dart';
import 'package:ralert/core/tools/vector.dart';
import 'package:ralert/domain/entity/user.entity.dart';

class MedicalInformationModel extends UserMedicalInfoEntity {
  MedicalInformationModel({
    super.bloodType,
    super.weight,
    super.height,
    super.emergencyContacts,
    super.allergies,
    super.currentMedications,
    super.chronicConditions,
    super.currentDiseases,
    super.pastDiseases,
    super.pastSurgeries,
    super.immunizationHistory,
    super.familyMedicalHistory,
    super.primaryCarePhysician,
    super.recentIllnessesOrInfections,
    super.recentTrauma,
    super.insuranceProvider,
    super.policyNumber,
    super.groupNumber,
    super.workplace,
    super.school
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bloodType': bloodType,
      'weight': weight,
      'height': height,
      'emergencyContacts': emergencyContacts,
      'allergies': allergies,
      'currentMedications': currentMedications,
      'chronicConditions': chronicConditions,
      'currentDiseases': currentDiseases,
      'pastDiseases': pastDiseases,
      'pastSurgeries': pastSurgeries,
      'immunizationHistory': immunizationHistory,
      'familyMedicalHistory': familyMedicalHistory,
      'primaryCarePhysician': primaryCarePhysician,
      'recentIllnessesOrInfections': recentIllnessesOrInfections,
      'recentTrauma': recentTrauma,
      'insuranceProvider': insuranceProvider,
      'policyNumber': policyNumber,
      'groupNumber': groupNumber,
      'workplace': workplace,
      'school': school,
    };
  }

  factory MedicalInformationModel.fromMap(Map<String, dynamic> map) {
    return MedicalInformationModel(
      bloodType: map['bloodType'] as String?,
      weight: map['weight'] as String?,
      height: map['height'] as String?,
      emergencyContacts: map['emergencyContacts'] as List<dynamic>?,
      allergies: map['allergies'] as List<dynamic>?,
      currentMedications: map['currentMedications'] as List<dynamic>?,
      chronicConditions: map['chronicConditions'] as List<dynamic>?,
      currentDiseases: map['currentDiseases'] as List<dynamic>?,
      pastDiseases: map['pastDiseases'] as List<dynamic>?,
      pastSurgeries: map['pastSurgeries'] as List<dynamic>?,
      immunizationHistory: map['immunizationHistory'] as List<dynamic>?,
      familyMedicalHistory: map['familyMedicalHistory'] as List<dynamic>?,
      primaryCarePhysician: map['primaryCarePhysician'] as List<dynamic>?,
      recentIllnessesOrInfections: map['recentIllnessesOrInfections'] as List<dynamic>?,
      recentTrauma: map['recentTrauma'] as List<dynamic>?,
      insuranceProvider: map['insuranceProvider'] as String?,
      policyNumber: map['policyNumber'] as String?,
      groupNumber: map['groupNumber'] as String?,
      workplace: map['workplace'] as String?,
      school: map['school'] as String?,
    );
  }

  factory MedicalInformationModel.fromDTO(MedicalInfoDto dto) {
    return MedicalInformationModel(
      bloodType: dto.bloodType,
      weight: dto.weight,
      height: dto.height,
      emergencyContacts: dto.emergencyContacts,
      allergies: dto.allergies,
      currentMedications: dto.currentMedications,
      chronicConditions: dto.chronicConditions,
      currentDiseases: dto.currentDiseases,
      pastDiseases: dto.pastDiseases,
      pastSurgeries: dto.pastSurgeries,
      immunizationHistory: dto.immunizationHistory,
      familyMedicalHistory: dto.familyMedicalHistory,
      primaryCarePhysician: dto.primaryCarePhysician,
      recentIllnessesOrInfections: dto.recentIllnessesOrInfections,
      recentTrauma: dto.recentTrauma,
      insuranceProvider: dto.insuranceProvider,
      policyNumber: dto.policyNumber,
      groupNumber: dto.groupNumber,
      workplace: dto.workplace,
      school: dto.school,
    );
  }
}

class UpdateProfileModel extends UpdateProfileEntity {
  UpdateProfileModel({
    required super.firstName,
    required super.middleName,
    required super.lastName,
    required super.age,
    required super.contactNumber
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'age': age,
      'contactNumber': contactNumber
    };
  }

  factory UpdateProfileModel.fromDTO(UpdateProfileDto dto) {
    return UpdateProfileModel(
      firstName: dto.firstName,
      middleName: dto.middleName,
      lastName: dto.lastName,
      age: dto.age,
      contactNumber: dto.contactNumber,
    );
  }

}

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
    required super.password,
    required super.age,
    required super.gender,
    required super.contactNumber,
    required super.userType,
    super.medicalInfo,
    super.image,
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'image': image,
      'contactNumber': contactNumber,
      'userType': userType,
      'medicalInfo': medicalInfo
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      middleName:
          map['middleName'] != null ? map['middleName'] as String : null,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      age: map['age'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      contactNumber: map['contactNumber'] as String,
      userType: map['userType'],
      medicalInfo: map['medicalInfo'] != null
        ? MedicalInformationModel.fromMap(map['medicalInfo'])
        : null
    );
  }
}

class RescuerModel extends RescuerEntity {
 RescuerModel({
    required super.id,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
    required super.password,
    required super.age,
    required super.gender,
    required super.contactNumber,
    super.image,
    required super.location,
    required super.available
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'age': age,
      'gender': gender,
      'image': image,
      'contactNumber': contactNumber,
      'locationLng': location.longitude,
      'locationLat': location.latitude,
      'available': available
    };
  }

  factory RescuerModel.fromMap(Map<String, dynamic> map) {
    return RescuerModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      middleName:
          map['middleName'] != null ? map['middleName'] as String : null,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      age: map['age'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      contactNumber: map['contactNumber'] as String,
      location: Location(
        longitude: map['locationLng'] as double, 
        latitude: map['locationLat'] as double),
      available: map['available']
    );
  }
}
