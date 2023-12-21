part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoggingIn extends AuthState {}

class LoggedIn extends AuthState {}

class Registering extends AuthState {}

class Registered extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  const AuthFailure({
    required this.message,
  });
}
