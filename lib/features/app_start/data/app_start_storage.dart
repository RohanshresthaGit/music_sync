import '../../../core/common/constants/secure_storage_constants.dart';
import '../../../core/common/services/secure_storage_service.dart';

abstract interface class IAppStartStorage {
  Future<bool> loadOnboardingStatus();
  Future<void> saveOnboardingSeen();
}

class AppStartStorage implements IAppStartStorage {
  final ISecureStorageService _secureStorage;

  AppStartStorage(this._secureStorage);

  @override
  Future<bool> loadOnboardingStatus() async {
    final onboardingSeen = await _secureStorage.getBool(
      SecureStorageConstants.onboardingSeen,
    );
    return onboardingSeen ?? false; // Default to false if not set
  }

  @override
  Future<void> saveOnboardingSeen() async {
    await _secureStorage.saveBool(SecureStorageConstants.onboardingSeen, true);
  }
}
