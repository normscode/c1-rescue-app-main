part of 'admin_cubit.dart';

sealed class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

final class AdminInitial extends AdminState {}

final class AdminFetchingState extends AdminState {}

final class AdminAnalyticsState extends AdminState {
  final Map<String, dynamic> analytics;

  const AdminAnalyticsState(this.analytics);
}

