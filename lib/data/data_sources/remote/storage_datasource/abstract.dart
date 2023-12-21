
import 'package:camera/camera.dart';

abstract class IStorageImageRemoteDatasource {
  Future<void> uploadToStorage({XFile? file, required String path});
}