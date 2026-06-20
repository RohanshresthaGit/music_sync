import 'package:music_sync/features/app_start/domain/checks/app_start_check.dart';
import 'package:music_sync/features/app_start/domain/usecases/get_onboarding_status_use_case.dart';
import 'package:music_sync/features/app_start/utils/app_start_enums.dart';

class OnboardingCheck implements AppStartCheck {
  final GetOnboardingStatusUseCase _getOnboardingStatusUseCase;

  OnboardingCheck(this._getOnboardingStatusUseCase);

  @override
  Future<AppStartState?> execute() async {
    final hasSeenOnboarding = await _getOnboardingStatusUseCase.execute();
    if (!hasSeenOnboarding) {
      return AppStartState.onboarding;
    }
    return null; // Continue to next check
  }
}
