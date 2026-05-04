import 'package:flutter/material.dart';
import 'package:valorant_companion_app/features/agents/agent_list_screen.dart';
import 'package:valorant_companion_app/features/maps/map_list_screen.dart';
import 'package:valorant_companion_app/features/weapons/weapon_list_screen.dart';

class ExploreSection extends StatelessWidget {
  const ExploreSection({super.key});

  Widget card(
      BuildContext context,
      String title,
      String subtitle,
      Color color,
      Widget screen,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.3),
              color.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("EXPLORE",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white70)),
        const SizedBox(height: 16),

        card(context, "AGENTS", "View all agents", Colors.red,
            const AgentsListScreen()),
        card(context, "GUNS", "View all weapons", Colors.teal,
            const WeaponsListScreen()),
        card(context, "MAPS", "View all maps", Colors.orange,
            const MapsListScreen()),
      ],
    );
  }
}
