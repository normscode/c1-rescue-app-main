import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final String currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

Future<dynamic> getUser(userId) async {

  if (userId.isEmpty) return null;

  final user = await FirebaseFirestore.instance
    .collection('user')
    .doc(userId)
    .get();

  return user;
}