import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState(Locale('ar '))) {
    _loadInitialLocale();
  }

  void _loadInitialLocale() {
    final savedCode = AppPrefs.getString(PrefNames.languageCodeKey);

    final languageCode = (savedCode.isNotEmpty)
        ? savedCode
        : 'en'; // default Arabic

    emit(LocaleState(Locale(languageCode)));
  }

  void changeLocale(String code) {
    AppPrefs.setString(PrefNames.languageCodeKey, code);

    emit(LocaleState(Locale(code)));
  }
}
