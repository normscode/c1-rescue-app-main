
import 'package:camera/camera.dart';
import 'package:ralert/domain/repository/storage.repo.abstract.dart';

class StorageImage {
  final IStorageImageRepository repo;

  StorageImage({ required this.repo });

  Future<void> call({XFile? file, required String path}) {
    return repo.uploadToStorage(file: file, path: path);
  }
}