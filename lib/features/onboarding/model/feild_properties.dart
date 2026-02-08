class FieldProperties {
  final String inputType;

  // Existing
  final int? max;
  final int? min;
  final int? maxLength;

  // ✅ NEW (for sliders)
  final int? defaultValue; // for single slider
  final int? defaultMin; // for range slider
  final int? defaultMax; // for range slider

  final String? unit; // km, years, etc

  FieldProperties({
    required this.inputType,
    this.max,
    this.min,
    this.maxLength,
    this.defaultValue,
    this.defaultMin,
    this.defaultMax,
    this.unit,
  });

  factory FieldProperties.fromJson(Map<String, dynamic> json) {
    return FieldProperties(
      inputType: json['input_type'] ?? '',

      max: json['max'],
      min: json['min'],
      maxLength: json['max_length'],

      defaultValue: json['default'],
      defaultMin: json['default_min'],
      defaultMax: json['default_max'],

      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'input_type': inputType,

      if (max != null) 'max': max,
      if (min != null) 'min': min,
      if (maxLength != null) 'max_length': maxLength,

      if (defaultValue != null) 'default': defaultValue,
      if (defaultMin != null) 'default_min': defaultMin,
      if (defaultMax != null) 'default_max': defaultMax,

      if (unit != null) 'unit': unit,
    };
  }
}
