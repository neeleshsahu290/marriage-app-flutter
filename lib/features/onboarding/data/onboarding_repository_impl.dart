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
      var response = await api.post(ApiConstants.saveProfile, data: payload);

      await AppPrefs.setString(
        PrefNames.userProfile,
        jsonEncode(response.data['data']),
      );
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

    // Remove file objects
    payload["profile_photos"] = [];
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
      payload["has_children"] = payload["has_children"] == 'Yes' ? true : false;
    }

    // Height: feet/inch → cm
    if (payload["height_cm"] != null) {
      payload["height_cm"] = HeightUtils.feetInchToCm(payload["height_cm"]);
    }

    // Languages: object list → string list
    if (payload["languages_known"] != null) {
      payload["languages_known"] = (payload["languages_known"] as List)
          .map((e) => e["name"].toString())
          .toList();
    }

    // Marriage priority from prefs
    payload["marriage_priority"] = AppPrefs.getString(
      PrefNames.marriagePriority,
    );

    return payload;
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
          ? 'Yes'
          : 'No';
    }

    // Height: cm → feet/inch
    if (formValues["height_cm"] != null) {
      formValues["height_cm"] = HeightUtils.cmToFeetInch(
        formValues["height_cm"],
      );
    }

    // Languages: string list → object list
    if (formValues["languages_known"] != null) {
      formValues["languages_known"] = (formValues["languages_known"] as List)
          .map((e) => {"name": e})
          .toList();
    }

    // Profile photos already URLs (keep as is for edit preview)

    // Marriage priority (already string, keep as is)

    return formValues;
  }
}
