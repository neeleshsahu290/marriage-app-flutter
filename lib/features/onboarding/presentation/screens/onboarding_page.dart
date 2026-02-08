import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/features/onboarding/cubit/onboarding_form_cubit.dart';
import 'package:swan_match/features/onboarding/cubit/onboarding_form_state.dart';
import 'package:swan_match/features/onboarding/model/error_model.dart';
import 'package:swan_match/features/onboarding/model/form_feild_model.dart';
import 'package:swan_match/features/onboarding/model/form_page_model.dart';
import 'package:swan_match/features/onboarding/presentation/widget/heading_onboarding.dart';
import 'package:swan_match/features/onboarding/presentation/widget/language_bottom_sheet_feild.dart';
import 'package:swan_match/shared/widgets/box/images_widget.dart';
import 'package:swan_match/shared/widgets/box/multiple_select.dart';
import 'package:swan_match/shared/widgets/dropdown/custom_dropdowm.dart';
import 'package:swan_match/shared/widgets/inputs/height_bottom_sheet.dart';
import 'package:swan_match/shared/widgets/inputs/otp_feild.dart';
import 'package:swan_match/shared/widgets/inputs/primary_text_feild.dart';
import 'package:swan_match/shared/widgets/slider/custom_range_slider.dart';
import 'package:swan_match/shared/widgets/slider/custom_single_slider.dart';

class OnboardingPage extends StatelessWidget {
  final int currentPage;
  final FormPageModel pageData;

  final bool isEdit;

  const OnboardingPage({
    super.key,
    required this.pageData,
    required this.currentPage,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadingOnboarding(
                heading: context.t(pageData.pageTitle),
                desc: context.t(pageData.pageDesc),
              ),

              SizedBox(height: 3.h),

              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: List.generate(pageData.fields.length, (index) {
                  final field = pageData.fields[index];

                  void onChanged(value) {
                    context.read<OnboardingFormCubit>().updateField(
                      field.keyName,
                      value,
                      currentPage,
                    );
                  }

                  final initial = context.read<OnboardingFormCubit>().getValue(
                    field.keyName,
                  );

                  final feildsData = context
                      .read<OnboardingFormCubit>()
                      .getFeildData(field.keyName);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Builder(
                        builder: (_) {
                          switch (field.type) {
                            case 'text_field':
                            case 'text_area':
                              return _buildTextField(
                                context,
                                field,
                                onChanged,
                                initial,
                              );

                            case 'drop_down':
                              return _buildDropdown(
                                context,
                                field,
                                onChanged,
                                initial,
                                feildsData,
                              );

                            case 'multi_drop_down':
                              return _buildMultiDropdown(
                                context,
                                field,
                                onChanged,
                                initial,
                                feildsData,
                              );

                            case 'multi_select':
                              return _buildMultiSelect(
                                context,
                                field,
                                onChanged,
                                initial,
                                feildsData,
                              );

                            case 'image_picker':
                              return _buildImageSelect(
                                field,
                                onChanged,
                                initial,
                              );

                            case 'single_slider':
                              return _buildSingleSlider(
                                context,
                                field,
                                onChanged,
                                initial,
                              );

                            case 'range_slider':
                              return _buildRangeSlider(
                                context,
                                field,
                                onChanged,
                                initial,
                              );

                            default:
                              return const SizedBox.shrink();
                          }
                        },
                      ),

                      BlocSelector<
                        OnboardingFormCubit,
                        OnboardingFormState,
                        ErrorModel?
                      >(
                        selector: (state) =>
                            state.errorData[currentPage][field.keyName],
                        builder: (context, error) {
                          if (error == null ||
                              error.errorTxt.isEmpty ||
                              error.isVerified) {
                            return const SizedBox.shrink();
                          }

                          return Padding(
                            padding: const EdgeInsets.only(top: 6, left: 4),
                            child: Text(
                              context.t(error.errorTxt),
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 16),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- TEXT FIELD ----------------

  Widget _buildTextField(
    BuildContext context,
    FormFieldModel field,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
  ) {
    if (field.properties.inputType == "date") {
      return DOBPickerField(
        label: context.t(field.label),
        initialDate: initial,
        onChanged: onChanged,
      );
    }

    return PrimaryTextField(
      label: context.t(field.label),
      initalValue: initial,
      hintText: context.t(field.hint),
      maxLines: field.type == 'text_area' ? 4 : 1,
      onChanged: onChanged,
    );
  }

  // ---------------- DROPDOWN ----------------

  Widget _buildDropdown(
    BuildContext context,
    FormFieldModel field,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
    List<String> data,
  ) {
    if (field.properties.inputType == "height") {
      return HeightBottomSheetField(
        label: context.t(field.label),
        initalValue: initial,
        onSelected: onChanged,
      );
    }

    return CustomDropdown(
      dropdownList: data,
      label: context.t(field.label),
      hint: context.t(field.hint),
      initialSelected: initial,
      onSelected: onChanged,
      enabled: field.keyName == "gender" && isEdit ? false : true,
    );
  }

  // ---------------- MULTI SELECT ----------------

  Widget _buildMultiSelect(
    BuildContext context,
    FormFieldModel field,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
    List<String> data,
  ) {
    return MultipleSelect(
      items: data,
      label: context.t(field.label),
      onChanged: onChanged,
      initialSelectedItems: initial is List
          ? initial.map((e) => e.toString()).toList()
          : [],
      max: field.properties.max,
    );
  }

  Widget _buildMultiDropdown(
    BuildContext context,
    FormFieldModel field,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
    List<String> data,
  ) {
    return LanguageBottomSheetField(
      label: context.t(field.label),
      onSelected: onChanged,
      initalValue: initial is List
          ? initial.map((e) => e.toString()).toList()
          : null,
    );
  }

  // ---------------- IMAGE ----------------

  Widget _buildImageSelect(
    FormFieldModel field,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
  ) {
    return PhotosWidget(photos: initial, onChanged: onChanged);
  }

  // ---------------- SLIDERS ----------------

  Widget _buildSingleSlider(
    BuildContext context,
    FormFieldModel field,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
  ) {
    final props = field.properties;

    return CustomSingleSlider(
      label: context.t(field.label),
      min: props.min ?? 0,
      max: props.max ?? 0,
      defaultValue: initial ?? props.defaultValue,
      unit: props.unit ?? "",
      onChanged: onChanged,
    );
  }

  Widget _buildRangeSlider(
    BuildContext context,
    FormFieldModel field,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
  ) {
    final props = field.properties;

    int start = props.defaultMin ?? 0;
    int end = props.defaultMax ?? 0;

    if (initial is Map) {
      start = initial["min"] ?? start;
      end = initial["max"] ?? end;
    }

    return CustomRangeSlider(
      label: context.t(field.label),
      min: props.min ?? 0,
      max: props.max ?? 0,
      defaultMin: start,
      defaultMax: end,
      unit: "Years",
      onChanged: (range) {
        onChanged?.call({"min": range.start.round(), "max": range.end.round()});
      },
    );
  }
}
