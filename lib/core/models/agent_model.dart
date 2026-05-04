import 'package:flutter/material.dart';

class Agent {
  final String uuid;
  final String displayName;
  final String description;
  final String displayIcon;
  final String fullPortrait;
  final String background;
  final String roleName;
  final List<Color> backgroundGradientColors;

  const Agent({
    required this.uuid,
    required this.displayName,
    required this.description,
    required this.displayIcon,
    required this.fullPortrait,
    required this.background,
    required this.roleName,
    required this.backgroundGradientColors,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    final gradients = json['backgroundGradientColors'] as List<dynamic>? ?? [];

    return Agent(
      uuid: json['uuid'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      displayIcon: json['displayIcon'] as String? ?? '',
      fullPortrait: json['fullPortrait'] as String? ?? '',
      background: json['background'] as String? ?? '',
      roleName: json['role']?['displayName'] as String? ?? '',
      backgroundGradientColors: gradients
          .map((color) => _parseApiHex(color.toString()))
          .toList(),
    );
  }

  static Color _parseApiHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 8) {
      final alpha = hex.substring(6, 8);
      final rgb = hex.substring(0, 6);
      hex = alpha + rgb;
    } else if (hex.length == 6) {
      hex = 'FF$hex';
    }

    return Color(int.tryParse(hex, radix: 16) ?? 0xFF0F1923);
  }
}
