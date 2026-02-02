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
}
