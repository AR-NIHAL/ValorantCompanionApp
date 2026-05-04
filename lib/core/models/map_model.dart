class ValorantMap {
  final String uuid;
  final String displayName;
  final String displayIcon;
  final String listViewIcon;
  final String splash;
  final String coordinates;

  const ValorantMap({
    required this.uuid,
    required this.displayName,
    required this.displayIcon,
    required this.listViewIcon,
    required this.splash,
    required this.coordinates,
  });

  factory ValorantMap.fromJson(Map<String, dynamic> json) {
    return ValorantMap(
      uuid: json['uuid'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      listViewIcon: json['listViewIcon'] as String? ?? '',
      splash: json['splash'] as String? ?? '',
      coordinates: json['coordinates'] as String? ?? '',
    );
  }
}
