// import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:music_sync/core/network/dio_service.dart';

import 'common/services/secure_storage_service.dart';
import 'utils/logger/logger.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  if (getIt.isRegistered<AppLogger>()) {
    return;
  }

  getIt
    ..registerSingleton<AppLogger>(AppLogger())
    ..registerSingleton<ISecureStorageService>(SecureStorageService())
    ..registerSingleton<DioService>(DioService());
  // ..registerLazySingleton<Dio>(() => getIt<DioService>().dio);
  // getIt.registerSingleton<NetworkConnectivity>(NetworkConnectivity());
}

AppLogger get appLog => getIt<AppLogger>();
ISecureStorageService get secureStorage => getIt<ISecureStorageService>();
DioService get dioService => getIt<DioService>();
// Dio get dio => getIt<Dio>();
// NetworkConnectivity get networkConnection => getIt<NetworkConnectivity>();
