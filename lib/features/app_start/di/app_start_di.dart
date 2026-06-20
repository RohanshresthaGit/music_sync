import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_sync/core/common/services/secure_storage_service.dart';
import 'package:music_sync/features/app_start/data/app_start_repository.dart';
import 'package:music_sync/features/app_start/data/app_start_storage.dart';
import 'package:music_sync/features/app_start/domain/checks/app_start_checker.dart';
import 'package:music_sync/features/app_start/domain/checks/onboarding_check.dart';
import 'package:music_sync/features/app_start/domain/repositories/app_start_repository.dart';
import 'package:music_sync/features/app_start/domain/usecases/get_onboarding_status_use_case.dart';
import 'package:music_sync/features/app_start/domain/usecases/set_onboarding_seen_use_case.dart';

import '../domain/checks/app_start_check.dart';

final appStartSecureStorageProvider = Provider<ISecureStorageService>((ref) {
  return SecureStorageService();
});

final appStartStorageProvider = Provider<IAppStartStorage>((ref) {
  final secureStorage = ref.watch(appStartSecureStorageProvider);
  return AppStartStorage(secureStorage);
});

final appStartRepositoryProvider = Provider<AppStartRepository>((ref) {
  final storage = ref.watch(appStartStorageProvider);
  return AppStartRepositoryImpl(storage);
});

final getOnboardingStatusUseCaseProvider = Provider<GetOnboardingStatusUseCase>(
  (ref) {
    return GetOnboardingStatusUseCaseImpl(
      ref.watch(appStartRepositoryProvider),
    );
  },
);

final setOnboardingSeenUseCaseProvider = Provider<SetOnboardingSeenUseCase>((
  ref,
) {
  return SetOnboardingSeenUseCaseImpl(ref.watch(appStartRepositoryProvider));
});

// ============================================================================
// HOW TO ADD A NEW CHECK - EXAMPLE
// ============================================================================

/*
To add a new check (e.g., Maintenance Check), follow these steps:

1. Create the check class in domain/checks/maintenance_check.dart:
   ```dart
   class MaintenanceCheck implements AppStartCheck {
     final GetMaintenanceStatusUseCase _useCase;

     MaintenanceCheck(this._useCase);

     @override
     Future<AppStartState?> execute() async {
       final isMaintenance = await _useCase.execute();
       if (isMaintenance) {
         return AppStartState.maintenance; // Add this to AppStartState enum
       }
       return null;
     }
   }
   ```

2. Create the use case in domain/usecases/get_maintenance_status_use_case.dart:
   ```dart
   abstract class GetMaintenanceStatusUseCase {
     Future<bool> execute();
   }

   class GetMaintenanceStatusUseCaseImpl implements GetMaintenanceStatusUseCase {
     // Implementation here
   }
   ```

3. Add the use case provider here:
   ```dart
   final getMaintenanceStatusUseCaseProvider = Provider<GetMaintenanceStatusUseCase>((ref) {
     return GetMaintenanceStatusUseCaseImpl();
   });
   ```

4. Add the check provider here:
   ```dart
   final maintenanceCheckProvider = Provider<AppStartCheck>((ref) {
     final useCase = ref.watch(getMaintenanceStatusUseCaseProvider);
     return MaintenanceCheck(useCase);
   });
   ```

5. Add to the checks list below:
   ```dart
   final appStartChecksProvider = Provider<List<AppStartCheck>>((ref) {
     return [
       ref.watch(maintenanceCheckProvider),  // Check maintenance first
       ref.watch(onboardingCheckProvider),    // Then check onboarding
     ];
   });
   ```
*/

final onboardingCheckProvider = Provider<AppStartCheck>((ref) {
  final getOnboardingStatusUseCase = ref.watch(
    getOnboardingStatusUseCaseProvider,
  );
  return OnboardingCheck(getOnboardingStatusUseCase);
});

// ============================================================================
// APP START CHECKS CONFIGURATION
// ============================================================================

/// Ordered list of checks - add new checks here in desired order
/// Currently only onboarding check is active
/// To add more checks, follow the extension guide above
final appStartChecksProvider = Provider<List<AppStartCheck>>((ref) {
  return [
    ref.watch(onboardingCheckProvider), // Check onboarding status
  ];
});

// Main checker that orchestrates all checks
final appStartCheckerProvider = Provider<AppStartChecker>((ref) {
  final checks = ref.watch(appStartChecksProvider);
  return AppStartChecker(checks);
});
