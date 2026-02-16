import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  final status = await Permission.microphone.request();
  switch (status) {
    case PermissionStatus.granted:
      break;
    case PermissionStatus.denied:
      openAppSettings();
      break;
    case PermissionStatus.permanentlyDenied:
      openAppSettings();
      break;
    default:
      break;
  }
}