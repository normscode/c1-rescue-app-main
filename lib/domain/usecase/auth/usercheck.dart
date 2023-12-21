import 'package:firebase_auth/firebase_auth.dart';
import 'package:ralert/data/repository/user.impl.dart';

class Usercheck {
  final UserRepositoryImpl repo;

  Usercheck({
    required this.repo,
  });

  Stream<User?> call() {
    return repo.userCheck();
  }
}
