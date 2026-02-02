import 'package:swan_match/features/onboarding/model/feild_properties.dart';

class FormFieldModel {
  final String keyName;
  final String label;
  final String labelIcon;
  final String hint;
  final String type;
  final bool isRequired;
  final String errorText;
  final FieldProperties properties;

  FormFieldModel({
    required this.keyName,
    required this.label,
    required this.labelIcon,
    required this.hint,
    required this.type,
    required this.isRequired,
    required this.errorText,
    required this.properties,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    return FormFieldModel(
      keyName: json['key'] ?? '',
      label: json['label'] ?? '',
      labelIcon: json['label_icon'] ?? '',
      hint: json['hint'] ?? '',
      type: json['type'] ?? '',
      isRequired: json['is_required'] ?? false,
      errorText: json['error_text'] ?? '',
      properties: FieldProperties.fromJson(json['properties'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': keyName,
      'label': label,
      'label_icon': labelIcon,
      'hint': hint,
      'type': type,
      'is_required': isRequired,
      'error_text': errorText,
      'properties': properties.toJson(),
    };
  }
}
