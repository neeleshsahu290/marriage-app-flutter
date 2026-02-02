import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:swan_match/core/constants/api_constants.dart';
import 'package:swan_match/core/network/api_client.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/features/settings/data/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final ApiClient api;

  SettingsRepositoryImpl(this.api);

  @override
  Future<void> updateUserSetting({required dynamic data}) async {
    try {
      await Future.delayed(Duration(seconds: 5));

      var response = await api.put(ApiConstants.updateUserFeilds, data: data);

      final updatedFields = response.data["data"]["updated_fields"];

      // Store each setting
      await AppPrefs.setBool(
        PrefNames.showOnlineStatus,
        updatedFields["show_online_status"],
      );

      await AppPrefs.setBool(PrefNames.showEmail, updatedFields["show_email"]);

      await AppPrefs.setBool(PrefNames.showPhone, updatedFields["show_phone"]);

      await AppPrefs.setString(
        PrefNames.photoVisibility,
        updatedFields["photo_visibility"],
      );
    } on DioException catch (e) {
      log(e.toString());
      throw Exception(
        e.response?.data["message"] ?? "Failed to update setting",
      );
    }
  }
}
