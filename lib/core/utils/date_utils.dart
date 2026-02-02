import 'package:intl/intl.dart';

class DateUtils {
  static final _formatter = DateFormat('yyyy-MM-dd');

  // DateTime → "1996-07-26"
  static String toApiFormat(DateTime date) {
    return _formatter.format(date);
  }

  // "1996-07-26" → DateTime
  static DateTime fromApiFormat(String date) {
    return _formatter.parse(date);
  }
}
