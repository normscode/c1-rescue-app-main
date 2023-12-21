

import 'package:ralert/data/models/user.model.dart';

abstract class IAdminRepository {
  Future<Map<String, dynamic>> getAnalytics();
  Future<List<UserModel>> fetchAllUsers();
}