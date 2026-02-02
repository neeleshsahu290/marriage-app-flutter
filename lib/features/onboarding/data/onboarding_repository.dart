abstract class OnboardingRepository {
  Future<void> saveProfile(Map<String, dynamic> payload);

  Future<Map<String, dynamic>> getProfile();
}
