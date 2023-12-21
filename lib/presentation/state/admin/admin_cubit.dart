import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralert/data/models/user.model.dart';
import 'package:ralert/domain/usecase/admin/admin.dart';
import 'package:ralert/domain/usecase/verification/verification.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  
  Admin adminAnalytics;
  Verification verification;

  AdminCubit(this.adminAnalytics, this.verification) : super(AdminInitial());

  Future<String> getAdminAnalytics() async {
    emit(AdminFetchingState());

    final analytics = await adminAnalytics();

    emit(AdminAnalyticsState(analytics));

    return 'done';
  }

  Future<void> verify(userId) async {
    verification.verified(userId: userId);
  }

  Future<void> deny(userId) async {
    verification.denied(userId: userId);
  }

  Future<List<UserModel>> getAllUsers() async {
    return await adminAnalytics.fetchAllUsers();
  }

}
