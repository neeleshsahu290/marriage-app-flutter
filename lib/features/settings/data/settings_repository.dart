abstract class SettingsRepository {
  Future<void> updateUserSetting({required dynamic data});

  Future<void> updatePreferences({required dynamic data});
}
