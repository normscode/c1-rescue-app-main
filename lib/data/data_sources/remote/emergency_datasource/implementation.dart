
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ralert/core/global/global.variable.dart';
import 'package:ralert/core/tools/vector.dart';
import 'package:ralert/data/data_sources/remote/emergency_datasource/abstract.dart';
import 'package:ralert/data/models/emergency.model.dart';
import 'package:ralert/data/models/user.model.dart';
import 'package:ralert/domain/entity/emergency.entity.dart';
import 'package:ralert/domain/entity/user.entity.dart';
import 'package:telephony/telephony.dart';

class EmergencyRemoteDatasource implements IEmergencyRemoteDatasource {

  final CollectionReference<Map<String, dynamic>> collection = 
    FirebaseFirestore.instance.collection('emergency');

  final Telephony telephony = Telephony.instance;

  @override
  Future<void> announceEmergency({required EmergencyEntity emergency}) async {
    EmergencyModel model = EmergencyModel.fromEntity(emergency);

    // Find nearest rescuer
    Location origin = Location(
      longitude: emergency.locationLng,
      latitude: emergency.locationLat);

    List<RescuerModel> nearestRescuers = await getNearestRescuers(origin, 1);
    List<String?> targetRescuers = nearestRescuers.map((rescuer) {
      if (rescuer.available) return rescuer.id;
    }).toList();

    model.targetRescuers = targetRescuers;

    final userData = await getUser(emergency.user.id);

    try {
      if (userData['medicalInfo'] != null) {
        for (var data in userData['medicalInfo']['emergencyContacts']) {
          await telephony.sendSms(
            to: data,
            message: """RALERT CAR CRASH ALERT!

We have detected car crash on the phone of ${emergency.user.firstName} ${emergency.user.lastName}.

Don't worry, rescuers have been alerted about this. Help is coming!
      """,
            isMultipart: true
          );
        }
      }
    } catch (e) {
      print("Something went wrong $e");
    }

    await collection.doc(model.id).set(model.toMap());
  }

  @override
  Future<void> acceptEmergency(String emergencyId, String rescuerID) async {
    final DocumentReference emergencyDoc = collection.doc(emergencyId);

    await emergencyDoc.update({
      'accepted': true,
      'rescuerAcceptor': rescuerID
    });
  }

  @override
  Future<void> resolveEmergency(String emergencyId) async {
    final DocumentReference doc = collection.doc(emergencyId);

    await doc.update({'resolved': true});
  }

  @override
  Future<void> listenToOneEmergency(String emergencyId, { required Function(dynamic newChanges) listen }) async {
    final DocumentReference doc = collection.doc(emergencyId);
      
    // Listen to incoming emergencies
    doc.snapshots().listen((DocumentSnapshot snapshot) {
      final data = snapshot.data();
      listen(data);
    });

  }

  @override
  Future<void> listenToEmergencies({ required Function(dynamic incidentInfo) listen }) async {
    // Listen to incoming emergencies
    collection.snapshots().listen((QuerySnapshot snapshot) {
      for (var change in snapshot.docChanges) {
        if(change.type == DocumentChangeType.added) {

          final data = change.doc.data() as Map<String, dynamic>;

          if (data['targetRescuers'] == null) return;

          data["targetRescuers"].forEach((rescuerID) {
            if (rescuerID == FirebaseAuth.instance.currentUser!.uid && data['resolved'] == false) {
              listen(data);
            }
          });
        }
      }
    });

  }
  
  @override
  Future<List<dynamic>> fetchIncidents() async {
    final emergencySnapshot = await collection.get();

    List<dynamic> incidents = [];

    for (var docSnapshot in emergencySnapshot.docs) {
      incidents.add(docSnapshot);
    }

    return incidents;
  }
  
  @override
  Future<List> fetchOnGoingByRescuerId(String rescuerID) async {
    final emergencySnapshot = await collection.where("rescuerAcceptor", isEqualTo: rescuerID).get();

    List<dynamic> rescuerOnGoing = [];

    for (var docSnapshot in emergencySnapshot.docs) {
      try {
        if (docSnapshot['accepted'] == true && docSnapshot['resolved'] == false) {
          rescuerOnGoing.add(docSnapshot);
        }
      } catch (e) {
        // ignore: avoid_print
        print("Something went wrong $e");
      }
    }

    return rescuerOnGoing;
  }
  
  @override
  Future<List> fetchUnsolved() async {
    final emergencySnapshot = await collection.where("resolved", isEqualTo: false).get();

    List<dynamic> unsolved = [];

    for (var docSnapshot in emergencySnapshot.docs) {
      try {
        if (docSnapshot['accepted'] == false && docSnapshot['resolved'] == false) {
          unsolved.add(docSnapshot);
        }
      } catch (e) {
        // ignore: avoid_print
        print("Something went wrong $e");
      }
    }

    return unsolved;
  }

  @override
  Future<List> fetchResolvedByRescuerId(String rescuerID) async {
    final emergencySnapshot = await collection.where("rescuerAcceptor", isEqualTo: rescuerID).get();

    List<dynamic> rescuerOnGoing = [];

    for (var docSnapshot in emergencySnapshot.docs) {
      try {
        if (docSnapshot['resolved'] == true) {
          rescuerOnGoing.add(docSnapshot);
        }
      } catch (e) {
        // ignore: avoid_print
        print("Something went wrong $e");
      }
    }

    return rescuerOnGoing;
  }

  @override
  Future<List> fetchResolved() async {
    final emergencySnapshot = await collection.where("resolved", isEqualTo: true).get();

    List<dynamic> resolved = [];

    for (var docSnapshot in emergencySnapshot.docs) {
      try {
        resolved.add(docSnapshot);
      } catch (e) {
        // ignore: avoid_print
        print("Something went wrong $e");
      }
    }

    return resolved;
  }

}

Future<List<RescuerModel>> getNearestRescuers(Location origin, int max) async {
  final collection = FirebaseFirestore.instance.collection('user');
  final querySnapshot = await collection.where('userType', isEqualTo: UserType.rescuer).get(); 
  List<RescuerDistance> rescuerDistances = querySnapshot.docs.map((doc) {
    RescuerModel rescuer = RescuerModel.fromMap(doc.data());
    double distance = Location.getDistance(origin, rescuer.location);
    return RescuerDistance(rescuer: rescuer, distance: distance);
  }).toList();
  
  rescuerDistances.sort((a, b) => a.distance.compareTo(b.distance));

  List<RescuerDistance> nearestDistances = rescuerDistances.sublist(0, max);
  return nearestDistances.map((d) => d.rescuer).toList();
}

class RescuerDistance {
  RescuerModel rescuer;
  double distance;

  RescuerDistance({ required this.rescuer, required this.distance });
}

