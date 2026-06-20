import 'package:music_sync/features/app_start/domain/checks/app_start_check.dart';
import 'package:music_sync/features/app_start/utils/app_start_enums.dart';

/// Orchestrates all app start checks in order
/// Each check can return a state or null to continue to next check
class AppStartChecker {
  final List<AppStartCheck> _checks;

  AppStartChecker(this._checks);

  /// Runs all checks in order and returns the first non-null state
  /// If all checks pass (return null), returns authenticated state
  Future<AppStartState> check() async {
    for (final check in _checks) {
      final result = await check.execute();
      if (result != null) {
        return result;
      }
    }
    return AppStartState.authenticated;
  }
}
