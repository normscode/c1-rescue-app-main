import 'package:ralert/data/data_sources/local/motion_datasource/abstract.dart';
import 'package:ralert/data/data_sources/local/motion_datasource/implementation.dart';
import 'package:ralert/data/models/motion.model.dart';
import 'package:ralert/domain/repository/motion.repo.abstract.dart';

class MotionRepositoryImpl implements IMotionRepository {
  final IMotionLocalDatasource source;

  MotionRepositoryImpl({ required this.source });

  @override
  AccelerometerRecordKeeper onMotion() {
    return source.onMotion();
  }
  
  @override
  Future<MotionModel> getMotionData() {
    return source.getMotionData();
  }
  
}