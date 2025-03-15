class UserSettings {
  final String name;
  final double weight;
  final double height;
  final String allergies;

  UserSettings({
    required this.name,
    required this.weight,
    required this.height,
    required this.allergies,
  });

  factory UserSettings.empty() {
    return UserSettings(name: '', weight: 0, height: 0, allergies: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'height': height,
      'allergies': allergies,
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      name: json['name'] ?? '',
      weight: (json['weight'] ?? 0).toDouble(),
      height: (json['height'] ?? 0).toDouble(),
      allergies: json['allergies'] ?? '',
    );
  }
}
