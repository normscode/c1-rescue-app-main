import 'package:camera/camera.dart';

abstract class IStorageImageRepository {
  Future<void> uploadToStorage({XFile? file, required String path});
}