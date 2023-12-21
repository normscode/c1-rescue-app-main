import 'package:ralert/core/tools/vector.dart';

class RegisterDto {
  final String email;
  final String password;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? gender;
  final String age;
  final String contactNumber;
  final String userType;
  Location? location;
  bool? available;

  RegisterDto({
    required this.email,
    required this.password,
    required this.firstName,
    this.middleName,
    required this.lastName,
    this.gender,
    required this.age,
    required this.contactNumber,
    required this.userType,
    this.location,
    this.available
  });
}
