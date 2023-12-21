import 'package:ralert/data/models/user.model.dart';
import 'package:ralert/domain/repository/admin.repo.abstract.dart';

class Admin {
  final IAdminRepository repo;

  Admin({
    required this.repo,
  });

  Future<Map<String, dynamic>> call() async {
    return await repo.getAnalytics();
  }

  Future<List<UserModel>> fetchAllUsers() async {
    return await repo.fetchAllUsers();
  }
}
