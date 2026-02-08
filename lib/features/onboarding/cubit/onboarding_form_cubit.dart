import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swan_match/core/services/supabase_service.dart';
import 'package:swan_match/core/utils/image_compresser_helper.dart';
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
    List<Map<String, ErrorModel>> errorData, {
    bool isEdit = false,
  }) {
    Map<String, dynamic> initialFormValues = {};

    // ---------- Default preferences only for new profile ----------
    if (!isEdit) {
      initialFormValues.addAll({
        "preferred_age_range": {"min": 18, "max": 50},
        "preferred_distance": 200,
        "preferred_min_education": "ANY_EDUCATION",
      });
    }
    log("Initial form values: ${initialFormValues.toString()}");
    emit(
      state.copyWith(
        fieldsData: data,
        errorData: errorData,
        values: {...state.values, ...initialFormValues},
      ),
    );
    log("State after insert field data: ${state.values.toString()}");
  }

  Future<bool> submitForm() async {
    try {
      final rawImages = state.values['profile_photos'];

      if (rawImages is! List) {
        Utils.showError("Invalid photos data");
        return false;
      }

      final List<File> newFiles = rawImages.whereType<File>().toList();
      final List<String> existingUrls = rawImages.whereType<String>().toList();

      log("Existing urls: ${existingUrls.length}");
      log("New files: ${newFiles.length}");

      final updatedValues = Map<String, dynamic>.from(state.values);

      // Upload only new images
      Map<File, String> uploadedMap = {};

      if (newFiles.isNotEmpty) {
        final compressedFiles = await ImageCompressHelper.compressFiles(
          newFiles,
        );

        if (compressedFiles.isEmpty) {
          Utils.showError("Image compression failed");
          return false;
        }

        final uploadedUrls = await SupabaseService.uploadImages(
          compressedFiles,
        );

        if (uploadedUrls.length != compressedFiles.length) {
          Utils.showError("Image upload failed");
          return false;
        }

        // Map compressed file -> url
        for (int i = 0; i < compressedFiles.length; i++) {
          uploadedMap[compressedFiles[i]] = uploadedUrls[i];
        }
      }

      // 🔥 Build final list in SAME sequence as UI
      List<String> finalImageUrls = [];

      int newFileIndex = 0;

      for (var item in rawImages) {
        if (item is String) {
          // old image
          finalImageUrls.add(item);
        } else if (item is File) {
          // new image → get uploaded url in order
          finalImageUrls.add(uploadedMap.values.elementAt(newFileIndex));
          newFileIndex++;
        }
      }

      log("Final ordered images: $finalImageUrls");

      updatedValues['profile_photos'] = finalImageUrls;

      await onboardingRepository.saveProfile(updatedValues);

      return true;
    } catch (e) {
      log("Submit form error: $e");
      Utils.showError(e.toString());
      return false;
    }
  }

  Future<void> setProfileData() async {
    final formValues = await onboardingRepository.getProfile();
    log(formValues.toString());

    // Copy existing errors structure
    final errors = List<Map<String, ErrorModel>>.from(state.errorData);

    for (int page = 0; page < errors.length; page++) {
      errors[page].forEach((key, errorModel) {
        final value = formValues[key];

        errors[page][key] = ErrorModel(
          errorTxt: errorModel.errorTxt,
          isVerified: value != null && value.toString().isNotEmpty,
        );
      });
    }

    emit(state.copyWith(values: formValues, errorData: errors));
  }
}
