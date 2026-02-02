class Language {
  final String key;
  final String name;
  final String flag;

  Language({required this.key, required this.name, required this.flag});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      key: json['key'],
      name: json['name'],
      flag: json['flag'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {'key': key, 'name': name, 'flag': flag};
  }
}
