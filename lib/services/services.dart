import 'package:ralert/data/data_sources/local/motion_datasource/implementation.dart';
import 'package:ralert/services/background_service.dart';
import 'package:ralert/services/permissions.dart';

void initializeServices() async {
  await ensurePermissions();
  MotionLocalDatasource.initialize();

  // startCarCrashDetectorService();
  initializeBackgroundService();
}