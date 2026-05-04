import 'package:flutter/material.dart';
import 'package:valorant_companion_app/core/models/map_model.dart';
import 'package:valorant_companion_app/features/home/list_screen.dart';
import '../../core/providers/api_provider.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListScreen<ValorantMap>(
      title: "Maps",
      provider: mapsProvider,
      nameBuilder: (map) => map.displayName,
      imageBuilder: (map) => map.displayIcon,
    );
  }
}
