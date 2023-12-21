
import 'package:ralert/data/data_sources/remote/admin_datasource/abstract.dart';
import 'package:ralert/data/models/user.model.dart';
import 'package:ralert/domain/repository/admin.repo.abstract.dart';

class AdminRepositoryImpl implements IAdminRepository {
  final IAdminRemoteDatasource remote;

  AdminRepositoryImpl({required this.remote});
  
  @override
  Future<Map<String, dynamic>> getAnalytics() async {
    return await remote.getAnalytics();
  }
  
  @override
  Future<List<UserModel>> fetchAllUsers() async {
    return await remote.fetchAllUsers();
  }
  

}