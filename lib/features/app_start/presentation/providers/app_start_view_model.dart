import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/app_start_di.dart';
import '../../domain/checks/app_start_checker.dart';
import '../../domain/usecases/set_onboarding_seen_use_case.dart';
import '../../utils/app_start_enums.dart';

final appStartViewModelProvider =
    AsyncNotifierProvider<AppStartViewModel, AppStartState>(
      AppStartViewModel.new,
    );

class AppStartViewModel extends AsyncNotifier<AppStartState> {
  late final AppStartChecker _appStartChecker;
  late final SetOnboardingSeenUseCase _setOnboardingSeenUseCase;

  @override
  Future<AppStartState> build() async {
    _appStartChecker = ref.watch(appStartCheckerProvider);
    _setOnboardingSeenUseCase = ref.watch(setOnboardingSeenUseCaseProvider);

    // Run all checks in order and return the appropriate state
    return await _appStartChecker.check();
  }

  Future<void> completeOnboarding() async {
    await _setOnboardingSeenUseCase.execute();
    // Re-run checks to get the next state (should be unauthenticated)
    state = AsyncValue.data(await _appStartChecker.check());
  }
}
