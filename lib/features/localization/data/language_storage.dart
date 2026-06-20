import '../../../core/common/constants/secure_storage_constants.dart';
import '../../../core/common/services/secure_storage_service.dart';

abstract interface class ILanguageStorage {
  Future<String?> loadLanguage();
  Future<void> saveLanguage(String code);
}

class LanguageStorage implements ILanguageStorage {
  final ISecureStorageService _secureStorage;

  LanguageStorage(this._secureStorage);
  // static final ISecureStorageService _secureStorage = SecureStorageService();

  @override
  Future<String?> loadLanguage() async {
    return await _secureStorage.getString(SecureStorageConstants.locale);
  }

  @override
  Future<void> saveLanguage(String code) async {
    await _secureStorage.saveString(SecureStorageConstants.locale, code);
  }
}
