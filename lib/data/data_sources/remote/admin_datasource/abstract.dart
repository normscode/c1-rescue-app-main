
import 'package:ralert/data/models/user.model.dart';

abstract class IAdminRemoteDatasource {
  Future<Map<String, dynamic>> getAnalytics();
  Future<List<UserModel>> fetchAllUsers();
}