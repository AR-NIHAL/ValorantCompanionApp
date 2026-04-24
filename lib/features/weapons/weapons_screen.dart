import 'package:flutter/material.dart';
import '../../core/providers/api_provider.dart';
import 'package:valorant_companion_app/features/home/list_screen.dart';

class WeaponsScreen extends StatelessWidget {
  const WeaponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListScreen(
      title: "Weapons",
      provider: weaponsProvider,
    );
  }
}