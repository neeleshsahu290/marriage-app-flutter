import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/utils/utils.dart';
import 'package:swan_match/features/onboarding/cubit/onboarding_form_state.dart';
import 'package:swan_match/features/onboarding/data/onboarding_repository.dart';
import 'package:swan_match/features/onboarding/model/error_model.dart';

class OnboardingFormCubit extends Cubit<OnboardingFormState> {
  final OnboardingRepository onboardingRepository;
  OnboardingFormCubit(this.onboardingRepository)
    : super(OnboardingFormState.initial());

  // Set / update a single field value
  void updateField(String key, dynamic value, int page) {
    final values = Map<String, dynamic>.from(state.values)..[key] = value;

    final errors = List<Map<String, ErrorModel>>.from(state.errorData);

    final prev = errors[page][key];

    errors[page][key] = ErrorModel(
      errorTxt: prev?.errorTxt ?? '',
      isVerified: value != null && value.toString().isNotEmpty,
    );

    emit(state.copyWith(values: values, errorData: errors));
  }

  bool isValidFeilds(int page) {
    if (page < 0 || page >= state.errorData.length) {
      return false;
    }

    final pageErrors = state.errorData[page];

    for (final error in pageErrors.values) {
      if (!error.isVerified) {
        return false;
      }
    }

    return true;
  }

  // Remove a field (optional)
  void removeField(String key) {
    final updatedValues = Map<String, dynamic>.from(state.values);
    updatedValues.remove(key);

    emit(state.copyWith(values: updatedValues));
  }

  // Clear all form data
  void clearForm() {
    emit(OnboardingFormState.initial());
  }

  // Get value safely
  T? getValue<T>(String key) {
    return state.values[key] as T?;
  }

  // get Filds Data
  List<String> getFeildData(String key) {
    final field = state.fieldsData.cast<Map<String, dynamic>>().firstWhere(
      (e) => e['key'] == key,
      orElse: () => {},
    );

    if (field.isEmpty) return [];

    return (field['items'] as List).cast<String>();
  }

  // Insert feild Data
  void insertFeildData(
    List<Map<String, dynamic>> data,
    List<Map<String, ErrorModel>> errorData,
  ) {
    emit(state.copyWith(fieldsData: data, errorData: errorData));
  }

  Future<bool> submitForm() async {
    //  emit(state.copyWith(isSubmitting: true));

    try {
      await onboardingRepository.saveProfile(state.values);

      return true;
      //    emit(state.copyWith(isSubmitting: false));
    } catch (e) {
      Utils.showError(e.toString());
      //   emit(state.copyWith(isSubmitting: false));
      //  rethrow;
    }
    return false;
  }

  setProfileData() async {
    var formValues = await onboardingRepository.getProfile();
    emit(state.copyWith(values: formValues));
  }
}
