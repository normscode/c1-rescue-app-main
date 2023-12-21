import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

final Telephony telephony = Telephony.instance;

Future<PermissionStatus> getLocationPermissionStatus() => Permission.location.status;
Future<PermissionStatus> getNotificationPermissionStatus() => Permission.notification.status;


Future<void> ensurePermissions() async {
  while((await getLocationPermissionStatus()).isDenied) {
    await Permission.location.request();
  }

  while((await getNotificationPermissionStatus()).isDenied) {
    await Permission.notification.request();
  }

  await telephony.requestPhoneAndSmsPermissions;

}