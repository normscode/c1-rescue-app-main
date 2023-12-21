
import 'package:camera/camera.dart';
import 'package:ralert/data/data_sources/remote/storage_datasource/abstract.dart';
import 'package:ralert/domain/repository/storage.repo.abstract.dart';

class StorageImageRepositoryImpl implements IStorageImageRepository {
  final IStorageImageRemoteDatasource remote;

  StorageImageRepositoryImpl({required this.remote});
  
  @override
  Future<void> uploadToStorage({XFile? file, required String path}) {
    return remote.uploadToStorage(file: file, path: path);
  }

}