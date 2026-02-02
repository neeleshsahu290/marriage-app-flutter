class FieldProperties {
  final String inputType;
  final int? max;
  final int? min;
  final int? maxLength;

  FieldProperties({
    required this.inputType,
    this.max,
    this.min,
    this.maxLength,
  });

  factory FieldProperties.fromJson(Map<String, dynamic> json) {
    return FieldProperties(
      inputType: json['input_type'] ?? '',
      max: json['max'],
      min: json['min'],
      maxLength: json['max_length'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'input_type': inputType,
      if (max != null) 'max': max,
      if (min != null) 'min': min,
      if (maxLength != null) 'max_length': maxLength,
    };
  }
}


