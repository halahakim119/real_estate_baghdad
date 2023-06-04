
import '../repositories/permission_repository.dart';

class RequestPermissionUseCase {
  final PermissionRepository _permissionRepository;

  RequestPermissionUseCase(this._permissionRepository);

  Future<bool> execute() async {
    return await _permissionRepository.requestGalleryPermission();
  }
}
