import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:ralert/domain/usecase/storage_image/storage.image.dart';

part 'storage_image_state.dart';

class StorageImageCubit extends Cubit<StorageImageState> {

  final StorageImage uploadToStorage;

  StorageImageCubit(this.uploadToStorage) : super(StorageImageInitial());

  void onUploadToStorage({XFile? file, String? path}) async {
    emit(Uploading());
    if (path != null) {
      await uploadToStorage(file: file, path: path).then((value) {
        emit(Uploaded(path: path));
      });
    } else {
      emit(Empty());
    }
  }

  void onUploadVerification() async {}
  
}
