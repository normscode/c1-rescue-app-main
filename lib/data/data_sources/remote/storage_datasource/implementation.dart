
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:ralert/data/data_sources/remote/storage_datasource/abstract.dart';
import 'package:firebase_storage/firebase_storage.dart';


class StorageImageRemoteDatasource implements IStorageImageRemoteDatasource {

  final storage = FirebaseStorage.instance;
  
  @override
  Future<void> uploadToStorage({XFile? file, required String path}) async {
    if (file != null) {
      await storage.ref(path).putFile(File(file.path));
    }
  }
  
}