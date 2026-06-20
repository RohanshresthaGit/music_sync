import 'package:music_sync/features/app_start/utils/app_start_enums.dart';

/// Abstract interface for app start checks
/// Each check implements this to determine the app's initial state
abstract interface class AppStartCheck {
  /// Executes the check and returns the appropriate app start state
  /// Returns null if this check doesn't apply and should continue to next check
  Future<AppStartState?> execute();
}

