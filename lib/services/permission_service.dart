import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> checkLocationPermission() {
    return Permission.location.status;
  }

  Future<PermissionStatus> requestLocationPermission() {
    return Permission.location.request();
  }
}
