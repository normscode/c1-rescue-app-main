part of 'edit_profile_cubit.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

final class EditProfileInitial extends EditProfileState {}

final class ProfileEditing extends EditProfileState {}

final class ProfileEdited extends EditProfileState {}

