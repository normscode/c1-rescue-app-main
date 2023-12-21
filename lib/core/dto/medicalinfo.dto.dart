
class MedicalInfoDto {
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

  MedicalInfoDto({this.bloodType, this.weight, this.height, this.emergencyContacts, this.allergies, this.currentMedications, this.chronicConditions, this.currentDiseases, this.pastDiseases, this.pastSurgeries, this.immunizationHistory, this.familyMedicalHistory, this.primaryCarePhysician, this.recentIllnessesOrInfections, this.recentTrauma, this.insuranceProvider, this.policyNumber, this.groupNumber, this.workplace, this.school});
}