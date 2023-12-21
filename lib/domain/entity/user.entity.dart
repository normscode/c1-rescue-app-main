
import 'package:ralert/core/tools/vector.dart';

class UserType {
  static const user = "user";
  static const rescuer = "rescuer";
}

class UserMedicalInfoEntity {
  final String? bloodType;
  final String? weight;
  final String? height;

  final List<dynamic>? emergencyContacts;

  // Medical Information
  final List<dynamic>? allergies;
  final List<dynamic>? currentMedications;
  final List<dynamic>? chronicConditions;
  final List<dynamic>? currentDiseases;
  final List<dynamic>? pastDiseases;
  final List<dynamic>? pastSurgeries;
  final List<dynamic>? immunizationHistory;
  final List<dynamic>? familyMedicalHistory;
  final List<dynamic>? primaryCarePhysician;
  final List<dynamic>? recentIllnessesOrInfections;
  final List<dynamic>? recentTrauma;

  // Insurance Information
  final String? insuranceProvider;
  final String? policyNumber;
  final String? groupNumber;

  // Additional Contact Information
  final String? workplace;
  final String? school;

  UserMedicalInfoEntity({this.bloodType, this.weight, this.height, this.emergencyContacts, this.allergies, this.currentMedications, this.chronicConditions, this.currentDiseases, this.pastDiseases, this.pastSurgeries, this.immunizationHistory, this.familyMedicalHistory, this.primaryCarePhysician, this.recentIllnessesOrInfections, this.recentTrauma, this.insuranceProvider, this.policyNumber, this.groupNumber, this.workplace, this.school});
}

class UpdateProfileEntity {
  final String firstName;
  final String middleName;
  final String lastName;
  final String age;
  final String contactNumber;

  UpdateProfileEntity({required this.firstName, required this.middleName, required this.lastName, required this.age, required this.contactNumber});
}

class UserEntity {
  final String id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String password;
  final String age;
  final String? gender;
  final String? image;
  final String contactNumber;
  final UserMedicalInfoEntity? medicalInfo;
  final String userType;

  UserEntity({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.age,
    this.gender,
    this.image,
    required this.contactNumber,
    this.medicalInfo,
    required this.userType,
  });
}

class RescuerEntity extends UserEntity {
  
  final Location location;
  final bool available;

  RescuerEntity({
    required super.id,
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
    required super.password,
    required super.age,
    super.gender,
    super.image,
    required super.contactNumber,
    required this.location,
    required this.available
  }): super(userType: UserType.rescuer);
}

