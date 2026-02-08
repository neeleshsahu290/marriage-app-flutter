import 'dart:convert';

import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/shared/models/user.dart';

class UserMatchHelper {
  /// Main method to get common important values
  static List<String> getCommonImportantValues(User otherUser) {
    final profileJson = AppPrefs.getString(PrefNames.userProfile);
    if (profileJson.isEmpty) {
      return [];
    }

    User userMe = User.fromJson(jsonDecode(profileJson));

    final List<String> common = [];

    // -------- Direct string matches --------

    _addIfSame(common, "Religion", otherUser.religion, userMe.religion);
    _addIfSame(
      common,
      "Faith",
      otherUser.religiousFaith,
      userMe.religiousFaith,
    );
    _addIfSame(
      common,
      "Education",
      otherUser.educationLevel,
      userMe.educationLevel,
    );
    _addIfSame(common, "Profession", otherUser.profession, userMe.profession);
    _addIfSame(
      common,
      "Marital Status",
      otherUser.maritalStatus,
      userMe.maritalStatus,
    );
    _addIfSame(common, "Family Type", otherUser.familyType, userMe.familyType);
    _addIfSame(
      common,
      "Parents Status",
      otherUser.parentsStatus,
      userMe.parentsStatus,
    );
    _addIfSame(
      common,
      "Marriage Priority",
      otherUser.marriagePriority,
      userMe.marriagePriority,
    );
    _addIfSame(common, "Location", otherUser.location, userMe.location);

    // -------- Boolean important --------

    if (otherUser.hasChildren != null &&
        otherUser.hasChildren == userMe.hasChildren) {
      common.add(
        otherUser.hasChildren == true
            ? "Both have children"
            : "Both have no children",
      );
    }

    // -------- List intersections --------

    common.addAll(
      _getCommonFromList(
        otherUser.languagesKnown,
        userMe.languagesKnown,
        label: "Language",
      ),
    );

    common.addAll(
      _getCommonFromList(
        otherUser.personalityTraits,
        userMe.personalityTraits,
        label: "Trait",
      ),
    );

    common.addAll(
      _getCommonFromList(otherUser.hobbies, userMe.hobbies, label: "Hobby"),
    );

    common.addAll(
      _getCommonFromList(otherUser.habits, userMe.habits, label: "Habit"),
    );

    // -------- Smart matches --------

    if (_isSimilarAge(otherUser.dob, userMe.dob)) {
      common.add("Similar age group");
    }

    if (_isSimilarHeight(otherUser.heightCm, userMe.heightCm)) {
      common.add("Similar height range");
    }

    return common;
  }

  // ================= Helpers =================

  static void _addIfSame(
    List<String> list,
    String label,
    String? a,
    String? b,
  ) {
    if (a == null || b == null) return;

    if (a.toLowerCase() == b.toLowerCase()) {
      list.add("$a");
    }
  }

  static List<String> _getCommonFromList(
    List<String> list1,
    List<String> list2, {
    required String label,
  }) {
    final set1 = list1.map((e) => e.toLowerCase()).toSet();
    final set2 = list2.map((e) => e.toLowerCase()).toSet();

    final common = set1.intersection(set2);

    return common.map((e) => "$label: ${_capitalize(e)}").toList();
  }

  static String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  static bool _isSimilarAge(DateTime? dob1, DateTime? dob2) {
    if (dob1 == null || dob2 == null) return false;

    int age1 = DateTime.now().year - dob1.year;
    int age2 = DateTime.now().year - dob2.year;

    return (age1 - age2).abs() <= 3;
  }

  static bool _isSimilarHeight(String? h1, String? h2) {
    if (h1 == null || h2 == null) return false;

    final int? height1 = int.tryParse(h1);
    final int? height2 = int.tryParse(h2);

    if (height1 == null || height2 == null) return false;

    return (height1 - height2).abs() <= 5;
  }
}
