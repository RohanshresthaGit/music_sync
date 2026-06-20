import 'package:music_sync/features/app_start/domain/repositories/app_start_repository.dart';

abstract interface class SetOnboardingSeenUseCase {
  Future<void> execute();
}

class SetOnboardingSeenUseCaseImpl implements SetOnboardingSeenUseCase {
  final AppStartRepository _repository;

  SetOnboardingSeenUseCaseImpl(this._repository);

  @override
  Future<void> execute() {
    return _repository.setOnboardingSeen();
  }
}
