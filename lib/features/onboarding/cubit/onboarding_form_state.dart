import 'package:swan_match/features/onboarding/model/error_model.dart';

class OnboardingFormState {
  final Map<String, dynamic> values;
  final List<Map<String, dynamic>> fieldsData;
  final List<Map<String, ErrorModel>> errorData;

  final bool isSubmitting;

  const OnboardingFormState({
    required this.values,
    required this.fieldsData,
    required this.errorData,
    required this.isSubmitting,
  });

  factory OnboardingFormState.initial() {
    return const OnboardingFormState(
      values: {},
      fieldsData: [],
      errorData: [],
      isSubmitting: false,
    );
  }

  OnboardingFormState copyWith({
    Map<String, dynamic>? values,
    List<Map<String, dynamic>>? fieldsData,
    List<Map<String, ErrorModel>>? errorData,
    bool? isSubmitting,
  }) {
    return OnboardingFormState(
      values: values ?? this.values,
      fieldsData: fieldsData ?? this.fieldsData,
      errorData: errorData ?? this.errorData,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
