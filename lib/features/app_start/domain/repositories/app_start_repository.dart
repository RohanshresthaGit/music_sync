abstract interface class AppStartRepository {
  Future<bool> hasSeenOnboarding();
  Future<void> setOnboardingSeen();
}
