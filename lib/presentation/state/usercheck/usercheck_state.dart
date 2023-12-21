part of 'usercheck_cubit.dart';

sealed class UsercheckState extends Equatable {
  const UsercheckState();

  @override
  List<Object> get props => [];
}

class Authenticating extends UsercheckState {}

// ignore: must_be_immutable
class Authenticated extends UsercheckState {
  dynamic user;

  Authenticated(this.user);
}

class UnAuthenticated extends UsercheckState {}
