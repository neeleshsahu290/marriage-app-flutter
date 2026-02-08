import 'package:swan_match/core/storage/app_prefs.dart';

class PrefUtils {
  static Future<void> saveApiCallDate() async {
    final today = DateTime.now();

    final formattedDate = "${today.year}-${today.month}-${today.day}";

    await AppPrefs.setString("lastApiCallDate", formattedDate);
  }

  static Future<bool> canApiCallAgain() async {
    final String lastDate = AppPrefs.getString("lastApiCallDate");

    final now = DateTime.now();

    // 2 AM today
    final today2AM = DateTime(now.year, now.month, now.day, 2);

    final todayString = "${now.year}-${now.month}-${now.day}";

    // ❌ Before 2 AM -> never allow
    if (now.isBefore(today2AM)) {
      return false;
    }

    // ✅ Never called before -> allow
    if (lastDate.isEmpty) {
      return true;
    }

    // ✅ Called on previous day -> allow
    if (lastDate != todayString) {
      return true;
    }

    // ❌ Already called today after 2 AM
    return false;
  }
}
