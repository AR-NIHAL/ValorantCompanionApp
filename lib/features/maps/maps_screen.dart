import 'package:flutter/material.dart';
import 'package:valorant_companion_app/features/home/list_screen.dart';
import '../../core/providers/api_provider.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Maps",
      provider: mapsProvider,
    );
  }
}