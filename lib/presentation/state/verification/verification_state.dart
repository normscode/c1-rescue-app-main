part of 'verification_cubit.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}

final class VerificationUnverified extends VerificationState {}

final class VerificationVerifying extends VerificationState {}

final class VerificationVerified extends VerificationState {}

