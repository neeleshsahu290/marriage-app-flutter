import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:swan_match/core/theme/app_colors.dart';
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

class OnboardingPage extends StatelessWidget {
  final int currentPage;
  final FormPageModel pageData;
  const OnboardingPage({
    super.key,
    required this.pageData,
    required this.currentPage,
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
                heading: pageData.pageTitle,
                desc: pageData.pageDesc,
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
                              return _buildTextField(field, onChanged, initial);

                            case 'drop_down':
                              return _buildDropdown(
                                field,
                                onChanged,
                                initial,
                                feildsData,
                              );

                            case 'multi_drop_down':
                              return _buildMultiDrpdown(
                                field,
                                onChanged,
                                initial,
                                feildsData,
                              );
                            case 'multi_select':
                              return _buildMultiSelect(
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
                                feildsData,
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
                              error.errorTxt,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
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

  Widget _buildTextField(
    FormFieldModel field,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
  ) {
    if (field.properties.inputType == "date") {
      return DOBPickerField(
        label: field.label,
        labelIcon: field.labelIcon,
        initialDate: initial,
        onChanged: onChanged,
      );
    }
    return PrimaryTextField(
      label: field.label,
      initalValue: initial,
      hintText: field.hint,
      maxLines: field.type == 'text_area' ? 4 : 1,
      onChanged: onChanged,
    );
  }

  _buildDropdown(
    FormFieldModel feild,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
    List<String> data,
  ) {
    if (feild.properties.inputType == "height") {
      return HeightBottomSheetField(
        label: feild.label,
        //  labelIcon: feild.labelIcon,
        initalValue: initial,
        // hintText: field.hint,
        // maxLines: field.type == 'text_area' ? 4 : 1,
        onSelected: onChanged,
      );
    }
    return CustomDropdown(
      dropdownList: data,
      label: feild.label,
      hint: feild.hint,
      initialSelected: initial,
      onSelected: onChanged,
    );
  }

  _buildMultiSelect(
    feild,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
    List<String> data,
  ) {
    return MultipleSelect(
      items: data,
      label: feild.label,
      onChanged: onChanged,
      initialSelectedItems: initial,
      max: feild.properties.max,
    );
  }

  _buildMultiDrpdown(
    feild,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
    List<String> data,
  ) {
    return LanguageBottomSheetField(
      //   items: data,
      label: feild.label,
      onSelected: onChanged,

      //onChanged: onChanged,
      initalValue: initial,
    );
  }

  _buildImageSelect(
    feild,
    ValueChanged<dynamic>? onChanged,
    dynamic initial,
    List<String> data,
  ) {
    return PhotosWidget(photos: initial, onChanged: onChanged);
  }
}
