import 'package:music_sync/features/app_start/domain/repositories/app_start_repository.dart';

abstract interface class GetOnboardingStatusUseCase {
  Future<bool> execute();
}

class GetOnboardingStatusUseCaseImpl implements GetOnboardingStatusUseCase {
  final AppStartRepository _repository;

  GetOnboardingStatusUseCaseImpl(this._repository);

  @override
  Future<bool> execute() {
    return _repository.hasSeenOnboarding();
  }
}
