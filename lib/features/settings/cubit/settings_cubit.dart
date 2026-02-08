import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/utils/utils.dart';
import 'package:swan_match/features/settings/data/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository settingsRepository;

  SettingsCubit(this.settingsRepository) : super(const SettingsState());

  Future<bool> updateSettings({
    required bool emailVisible,
    required bool mobileVisible,
    required String photoVisibility,
    required bool showOnline,
  }) async {
    emit(state.copyWith(isLoading: true));

    Map<String, Object> payload = {
      "show_email": emailVisible,
      "show_phone": mobileVisible,
      "photo_visibility": photoVisibility,
      "show_online_status": showOnline,
    };

    //   const allowedFields = ["show_online_status", "show_email", "show_phone", "photo_visibility"];

    try {
      await settingsRepository.updateUserSetting(data: payload);

      emit(state.copyWith(isLoading: false));
      return true;
    } catch (err) {
      Utils.showError(err.toString());
      emit(state.copyWith(isLoading: false));
    }
    return false;
  }

  Future<bool> updatePrefs({
    required Map<String, dynamic> payload, // { "min": 22, "max": 30 }
  }) async {
    emit(state.copyWith(isLoading: true));
    log(payload.toString());
    try {
      final Map<String, Object> data = {
        "min_age": payload["preferred_age_range"]["min"],
        "max_age": payload["preferred_age_range"]["max"],
        "max_distance_km": payload["preferred_distance"],
        "min_education_level": payload["preferred_min_education"],
      };

      await settingsRepository.updatePreferences(data: data);

      emit(state.copyWith(isLoading: false));
      return true;
    } catch (err) {
      Utils.showError(err.toString());
      emit(state.copyWith(isLoading: false));
      return false;
    }
  }
}
