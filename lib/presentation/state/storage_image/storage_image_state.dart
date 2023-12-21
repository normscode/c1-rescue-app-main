part of 'storage_image_cubit.dart';

abstract class StorageImageState extends Equatable {
  const StorageImageState();

  @override
  List<Object> get props => [];
}

class StorageImageInitial extends StorageImageState {}

class Uploading extends StorageImageState {}

class Uploaded extends StorageImageState {
  final String? path;
  const Uploaded({
    this.path,
  });
}

class Empty extends StorageImageState {}