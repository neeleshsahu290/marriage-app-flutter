import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:swan_match/core/constants/api_constants.dart';
import 'package:swan_match/core/network/api_client.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/core/utils/date_utils.dart' show DateUtils;
import 'package:swan_match/core/utils/height_utils.dart';
import 'package:swan_match/features/onboarding/data/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final ApiClient api;

  OnboardingRepositoryImpl(this.api);

  @override
  Future<void> saveProfile(Map<String, dynamic> formValues) async {
    try {
      final payload = _prepareOnboardingPayload(formValues);
      log(jsonEncode(payload));
      var response = await api.post(ApiConstants.saveProfile, data: payload);

      await AppPrefs.setString(
        PrefNames.userProfile,
        jsonEncode(response.data['data']['profile']),
      );
      try {
        if (response.data['data']['preferences'] != null) {
          await AppPrefs.setString(
            PrefNames.userPreferences,
            jsonEncode(response.data['data']['preferences']),
          );
        }
      } catch (e) {
        log("Error saving preferences: $e");
      }
    } on DioException catch (e) {
      log(e.message.toString());
      throw Exception(
        e.response?.data['message'] ?? e.message ?? 'Failed to save profile',
      );
    }
  }

  @override
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final profileString = AppPrefs.getString(PrefNames.userProfile);

      if (profileString.isEmpty) {
        return {};
      }

      final profileData = jsonDecode(profileString);

      return Map<String, dynamic>.from(prepareFormValuesFromApi(profileData));
    } catch (e) {
      log(e.toString());
      return {};
    }
  }

  // ================= HELPERS =================

  Map<String, dynamic> _prepareOnboardingPayload(
    Map<String, dynamic> formValues,
  ) {
    final payload = Map<String, dynamic>.from(formValues);
    final pref = {};

    // Remove file objects
    //  payload["profile_photos"] = [];
    try {
      // DOB: timestamp → yyyy-MM-dd
      if (payload["dob"] != null) {
        payload["dob"] = DateUtils.toApiFormat(
          DateTime.fromMillisecondsSinceEpoch(int.parse(payload["dob"])),
        );
      }
    } catch (e) {
      log(e.toString());
    }

    // Has Children: 'Yes'/'No' → bool
    if (payload["has_children"] != null) {
      payload["has_children"] = payload["has_children"] == 'YES' ? true : false;
    }

    // Height: feet/inch → cm
    if (payload["height_cm"] != null) {
      payload["height_cm"] = HeightUtils.feetInchToCm(payload["height_cm"]);
    }

    // Marriage priority from prefs
    payload["marriage_priority"] = AppPrefs.getString(
      PrefNames.marriagePriority,
    );

    // Age range
    final ageRange = payload.remove("preferred_age_range");
    if (ageRange is Map) {
      pref["min_age"] = ageRange["min"];
      pref["max_age"] = ageRange["max"];
    }

    // Distance
    final distance = payload.remove("preferred_distance");
    if (distance != null) {
      pref["max_distance_km"] = distance;
    }

    // Minimum education
    final minEducation = payload.remove("preferred_min_education");
    if (minEducation != null) {
      pref["min_education_level"] = minEducation;
    }

    // ---------- Optional cleanup ----------
    payload.removeWhere((key, value) => value == null);
    pref.removeWhere((key, value) => value == null);

    return {"user_profile": payload, "preferences": pref};
  }

  Map<String, dynamic> prepareFormValuesFromApi(Map<String, dynamic> apiData) {
    final allowedKeys = <String>{
      "full_name",
      "dob",
      "gender",
      "height_cm",
      "religion",
      "religious_faith",
      "languages_known",
      "bio",
      "marital_status",
      "has_children",
      "family_type",
      "parents_status",
      "education_level",
      "profession",
      "personality_traits",
      "hobbies",
      "profile_photos",
      "habits",
      "marriage_priority",
    };

    //  Filter only allowed fields
    final formValues = <String, dynamic>{};

    for (final entry in apiData.entries) {
      if (allowedKeys.contains(entry.key)) {
        formValues[entry.key] = entry.value;
      }
    }
    // DOB: yyyy-MM-dd → timestamp (ms)
    try {
      if (formValues["dob"] != null) {
        final date = DateTime.parse(formValues["dob"]);
        formValues["dob"] = date.millisecondsSinceEpoch.toString();
      }
    } catch (e) {
      log(e.toString());
    }

    // Has Children: bool → 'Yes'/'No'
    if (formValues["has_children"] != null) {
      formValues["has_children"] = formValues["has_children"] == true
          ? 'YES'
          : 'NO';
    }

    // Height: cm → feet/inch
    try {
      if (formValues["height_cm"] != null &&
          formValues["height_cm"].toString().isNotEmpty) {
        final value = double.parse(formValues["height_cm"].toString());

        formValues["height_cm"] = HeightUtils.cmToFeetInch(value);
      }
    } catch (e) {
      log(e.toString());
    }

    // Profile photos already URLs (keep as is for edit preview)

    // Marriage priority (already string, keep as is)

    return formValues;
  }
}
