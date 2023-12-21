import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ralert/core/dto/updateprofile.dto.dart';
import 'package:ralert/domain/usecase/profile/edit.profile.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit(this.updateProfile) : super(EditProfileInitial());

  final UpdateProfile updateProfile;

  void updateUserProfile(UpdateProfileDto updateProfileDto) {
    emit(ProfileEditing());

    updateProfile(params: updateProfileDto);

    emit(ProfileEdited());
  }
}
