
import 'package:ralert/data/data_sources/local/motion_datasource/implementation.dart';
import 'package:ralert/data/models/motion.model.dart';
import 'package:ralert/domain/repository/motion.repo.abstract.dart';

class Motion {
  final IMotionRepository repo;

  Motion({ required this.repo });

  AccelerometerRecordKeeper call({ void params }) {
    return repo.onMotion();
  }

  Future<MotionModel> getMotionData() {
    return repo.getMotionData();
  }
}