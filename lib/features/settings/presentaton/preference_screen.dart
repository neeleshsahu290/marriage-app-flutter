import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:swan_match/core/storage/app_prefs.dart';
import 'package:swan_match/core/storage/pref_names.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/core/utils/utils.dart';
import 'package:swan_match/features/onboarding/model/feild_properties.dart';
import 'package:swan_match/features/onboarding/model/form_feild_model.dart';

import 'package:swan_match/features/onboarding/presentation/widget/language_bottom_sheet_feild.dart';
import 'package:swan_match/features/settings/cubit/settings_cubit.dart';
import 'package:swan_match/features/settings/cubit/settings_state.dart';
import 'package:swan_match/shared/widgets/buttons/primarybutton.dart';
import 'package:swan_match/shared/widgets/common/custom_app_bar.dart';
import 'package:swan_match/shared/widgets/dropdown/custom_dropdowm.dart';
import 'package:swan_match/shared/widgets/slider/custom_range_slider.dart';
import 'package:swan_match/shared/widgets/slider/custom_single_slider.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  Map<String, dynamic> values = {};
  late List<FormFieldModel> fields;

  @override
  void initState() {
    super.initState();
    _loadFields();
    _loadPreferences();
  }

  // ---------------- Load saved preferences ----------------

  void _loadPreferences() {
    final prefString = AppPrefs.getString(PrefNames.userPreferences);
    log(prefString);
    if (prefString.isNotEmpty) {
      values = Map<String, dynamic>.from(jsonDecode(prefString));
      values.addAll({
        "preferred_age_range": {
          "min": values["min_age"] ?? 18,
          "max": values["max_age"] ?? 50,
        },
        "preferred_distance": values["max_distance_km"] ?? 200,
        "preferred_min_education":
            values["min_education_level"] ?? "ANY_EDUCATION",
      });
    } else {
      // Defaults
      values = {
        "preferred_age_range": {"min": 18, "max": 50},
        "preferred_distance": 200,
        "preferred_min_education": "ANY_EDUCATION",
      };
    }

    setState(() {});
  }

  // ---------------- Field config ----------------

  void _loadFields() {
    fields = [
      FormFieldModel(
        keyName: "preferred_age_range",
        label: "ageRangeLabel",
        hint: "ageRangeHint",
        type: "range_slider",
        properties: FieldProperties(
          inputType: "",
          min: 18,
          max: 60,
          defaultMin: 18,
          defaultMax: 50,
        ),
        labelIcon: '',
        isRequired: false,
        errorText: "ageRangeError",
      ),

      FormFieldModel(
        keyName: "preferred_distance",
        label: "distanceLabel",
        hint: "distanceHint",
        type: "single_slider",
        properties: FieldProperties(
          inputType: "",
          min: 0,
          max: 1000,
          defaultValue: 200,
          unit: "km",
        ),
        labelIcon: '',
        isRequired: false,
        errorText: "distanceError",
      ),

      FormFieldModel(
        keyName: "preferred_min_education",
        label: "preferredMinEducationLabel",
        hint: "preferredMinEducationHint",
        type: "drop_down",
        properties: FieldProperties(inputType: "education"),
        labelIcon: '',
        isRequired: false,
        errorText: "preferredMinEducationError",
      ),
    ];
  }

  // ---------------- Update value ----------------

  void _onValueChanged(String key, dynamic value) {
    setState(() {
      values[key] = value;
    });
  }

  // ---------------- Submit ----------------

  // ---------------- Build dynamic field ----------------

  Widget _buildField(BuildContext context, FormFieldModel field) {
    final initial = values[field.keyName];

    switch (field.type) {
      case "range_slider":
        return _buildRangeSlider(
          context,
          field,
          (v) => _onValueChanged(field.keyName, v),
          initial,
        );

      case "single_slider":
        return _buildSingleSlider(
          context,
          field,
          (v) => _onValueChanged(field.keyName, v),
          initial,
        );

      case "drop_down":
        return _buildDropdown(
          context,
          field,
          (v) => _onValueChanged(field.keyName, v),
          initial,
          educationlist,
        );

      default:
        return const SizedBox();
    }
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.t("preferencesTitle"),
        onBackPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: fields.length,
                separatorBuilder: (_, __) => const SizedBox(height: 25),
                itemBuilder: (context, index) =>
                    _buildField(context, fields[index]),
              ),
            ),

            BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                return PrimaryButton(
                  disablePadding: true,
                  btnText: context.t(
                    "updatePreferencesBtn",
                  ), // localized (optional)
                  isLoading: state.isLoading, // show loader if you support it
                  onPressed: state.isLoading
                      ? null
                      : () async {
                          bool isValue = await context
                              .read<SettingsCubit>()
                              .updatePrefs(payload: values);

                          if (isValue && mounted) {
                            Utils.showSuccess(context.tr.settingsUpdated);
                            context.pop();
                          }
                        },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// _buildMultiDrpdown(
//   BuildContext context,
//   feild,
//   ValueChanged<dynamic>? onChanged,
//   dynamic initial,
//   List<String> data,
// ) {
//   return LanguageBottomSheetField(
//     label: context.t(feild.label),
//     onSelected: onChanged,

//     /// Convert List<dynamic> → List<String> safely
//     initalValue: initial is List
//         ? initial.map((e) => e.toString()).toList()
//         : null,
//   );
// }

Widget _buildDropdown(
  BuildContext context,
  FormFieldModel field,
  ValueChanged<dynamic>? onChanged,
  dynamic initial,
  List<String> data,
) {
  return CustomDropdown(
    dropdownList: data,
    label: context.t(field.label),
    hint: context.t(field.hint),
    initialSelected: initial,
    onSelected: onChanged,
  );
}

_buildSingleSlider(
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
    onChanged: (value) {
      onChanged?.call(value);
    },
  );
}

_buildRangeSlider(
  BuildContext context,
  FormFieldModel field,
  ValueChanged<dynamic>? onChanged,
  dynamic initial,
) {
  final props = field.properties;

  int start = props.defaultMin ?? 0;
  int end = props.defaultMax ?? 0;

  // If already selected earlier
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
    unit: "years",
    onChanged: (range) {
      onChanged?.call({"min": range.start.round(), "max": range.end.round()});
    },
  );
}

List<String> educationlist = [
  "ANY_EDUCATION",
  "SECONDARY",
  "HIGH_SCHOOL",
  "NON_DEGREE",
  "BACHELORS",
  "MASTERS",
  "DOCTORATE",
];
