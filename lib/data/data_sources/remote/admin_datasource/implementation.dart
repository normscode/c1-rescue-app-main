import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ralert/data/data_sources/remote/admin_datasource/abstract.dart';
import 'package:ralert/data/models/user.model.dart';

class AdminRemoteDatasource implements IAdminRemoteDatasource {

  final CollectionReference<Map<String, dynamic>> emergencyCollection = 
    FirebaseFirestore.instance.collection('emergency');

  final CollectionReference<Map<String, dynamic>> userCollection = 
    FirebaseFirestore.instance.collection('user');

  final CollectionReference<Map<String, dynamic>> verificationCollection = 
    FirebaseFirestore.instance.collection('verification');
    
  @override
  Future<Map<String, dynamic>> getAnalytics() async {

    // On-Going Emergencies
    final onGoingSnapshot = await emergencyCollection.where('resolved', isEqualTo: false).get();

    // Solved Emergencies
    final solvedSnapshot = await emergencyCollection.where('resolved', isEqualTo: true).get();

    // Total Emergencies
    final totalEmergencySnapshot = await emergencyCollection.get();

    // Total Users
    final totalUsersSnapshot = await userCollection.get();

    // Pending Users Verification
    final pendingUsersVeficationSnapshot = await verificationCollection.where('status', isEqualTo: "verifying").get();

    return {
      "onGoing": onGoingSnapshot.docs,
      "solved": solvedSnapshot.docs,
      "totalEmergency": totalEmergencySnapshot.docs,
      "totalUsers": totalUsersSnapshot.docs,
      "pendingUsersVerification": pendingUsersVeficationSnapshot.docs
    };

  }
  
  @override
  Future<List<UserModel>> fetchAllUsers() async {
    final users = await userCollection.get();
    final List<UserModel> usersData = [];

    for (final userSnapshot in users.docs) {
      final userData = userSnapshot.data();

      if (userData['userType'] != "admin") {;
        final userModel = UserModel.fromMap(userData);

        usersData.add(userModel);
      }
    }

    return usersData;
  }
  
}