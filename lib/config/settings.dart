class Settings {
  static bool carCrashDetectionEnabled = true;
  
  static void toggleCarCrashDetection() {
    Settings.carCrashDetectionEnabled = !Settings.carCrashDetectionEnabled;
  }
}