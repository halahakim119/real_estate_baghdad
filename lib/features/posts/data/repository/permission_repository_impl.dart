import 'package:permission_handler/permission_handler.dart';

import '../../domain/repositories/permission_repository.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  @override
  Future<bool> requestGalleryPermission() async {
    final PermissionStatus status = await Permission.photos.request();
    return status == PermissionStatus.granted;
  }
}