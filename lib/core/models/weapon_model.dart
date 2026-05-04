class Weapon {
  final String uuid;
  final String displayName;
  final String displayIcon;
  final String category;

  const Weapon({
    required this.uuid,
    required this.displayName,
    required this.displayIcon,
    required this.category,
  });

  factory Weapon.fromJson(Map<String, dynamic> json) {
    return Weapon(
      uuid: json['uuid'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }
}
